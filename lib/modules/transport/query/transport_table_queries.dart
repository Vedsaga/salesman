// Package imports:
import 'package:drift/drift.dart';

// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_delivery_order.dart';
import 'package:salesman/core/db/drift/models/model_return_order.dart';
import 'package:salesman/core/db/drift/models/model_transport.dart';
import 'package:salesman/core/db/drift/models/model_vehicle.dart';

part 'transport_table_queries.g.dart';

@DriftAccessor(
  tables: [
    ModelTransport,
    ModelDeliveryOrder,
    ModelReturnOrder,
    ModelVehicle,
  ],
)
class TransportTableQueries extends DatabaseAccessor<AppDatabase>
    with _$TransportTableQueriesMixin {
  final AppDatabase db;
  TransportTableQueries(this.db) : super(db);

  Future<int> newTransport(ModelTransportCompanion transport) {
    return transaction(() async {
      if (transport.vehicleId.value != null) {
        await (update(modelVehicle)
              ..where(
                (table) => table.vehicleId.equals(transport.vehicleId.value),
              ))
            .write(
          ModelVehicleCompanion(
            vehicleStatus: const Value("unavailable"),
            lastUpdated: Value(DateTime.now()),
          ),
        );
      }
      return into(modelTransport).insert(transport);
    });

  }

  // get transport by id
  Future<ModelTransportData> getTransportById(int id) async {
    return (select(modelTransport)
          ..where((table) => table.transportId.equals(id)))
        .getSingle();
  }

  Future<List<ModelTransportData>> getAllPendingTransports() {
    return (select(modelTransport)
          ..where(
            (table) =>
                table.transportStatus.equals("pending") |
                table.transportStatus.equals("started") |
                table.transportStatus.equals("delayed") |
                table.transportStatus.equals("postpone"),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.transportId)]))
        .get();
  }

  Future<List<ModelTransportData>> getAllPendingForDropdown() {
    return (select(modelTransport)
          ..where(
            (table) =>
                table.transportStatus.equals("pending") |
                table.transportStatus.equals("delayed") |
                table.transportStatus.equals("postpone"),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.transportId)]))
        .get();
  }

  // get all getTransportHistoryTrip with transportStatus = "complete" or "cancel"
  Future<List<ModelTransportData>> getTransportHistoryTrip() {
    return (select(modelTransport)
          ..where(
            (table) =>
                table.transportStatus.equals("complete") |
                table.transportStatus.equals("cancel"),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.transportId)]))
        .get();
  }


  Future<List<ModelTransportData>> getOnlyScheduleDatePassedTransport() async {
    final transportList = await (select(modelTransport)
          ..where(
            (table) => table.transportStatus.equals("pending"),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.transportId)]))
        .get();

    // return all the transport where schedule date is passed
    return transportList
        .where((transport) => transport.scheduleDate.isBefore(DateTime.now()))
        .toList();
  }

  Future<List<int>> updateTransportStatus(
    List<ModelTransportData> transportList,
    String transportStatus,
  ) async {
    return transaction(() async {
      final List<int> transportIds = [];
      for (final ModelTransportData transport in transportList) {
        transportIds.add(transport.transportId);
        await (update(modelTransport)
              ..where(
                (table) => table.transportId.equals(transport.transportId),
              ))
            .write(
          ModelTransportCompanion(
            transportStatus: Value(transportStatus),
            lastUpdated: Value(DateTime.now()),
          ),
        );
      }
      return transportIds;
    });
  }

  // update transport
  Future<int> updateTransport({
    required ModelTransportCompanion transport,
    required String type,
    required int? deliveryOrderId,
    required int? returnOrderID,
  }) async {
    return transaction(() async {
      final int noOfRowUpdated = await (update(modelTransport)
            ..where(
              (table) => table.transportId.equals(transport.transportId.value),
            ))
          .write(transport);
      if (type == "delivery" && deliveryOrderId != null) {
        // update delivery order status to process
        await (update(modelDeliveryOrder)
              ..where(
                (table) => table.deliveryOrderId.equals(deliveryOrderId),
              ))
            .write(
          ModelDeliveryOrderCompanion(
            orderStatus: const Value("process"),
            transportId: Value(transport.transportId.value),
          ),
        );
      } else if (type == "return" && returnOrderID != null) {
        // update return order status to process
        await (update(modelReturnOrder)
              ..where(
                (table) => table.returnOrderId.equals(returnOrderID),
              ))
            .write(
          ModelReturnOrderCompanion(
            returnStatus: const Value("approve"),
            transportId: Value(transport.transportId.value),
            lastUpdated: Value(DateTime.now()),
          ),
        );
      } else {
        throw Exception("Invalid type");
      }

      return noOfRowUpdated;
    });
  }

  // update transport status to cancel by id
  Future<int> updateTransportStatusById({
    required int id,
    required List<int>? deliveryOrderIds,
    required List<int>? returnOrderIds,
    required String transportStatus,
    required String deliveryStatus,
    required String returnStatus,
    required String? transportBy,
    required DateTime? startedAt,
    required int vehicleId,
  }) {
    return transaction(() async {
      final int transportId = await (update(modelTransport)
            ..where(
              (table) => table.transportId.equals(id),
            ))
          .write(
        ModelTransportCompanion(
          transportStatus: Value(transportStatus),
          startedAt: Value(startedAt),
          transportBy: Value(transportBy),
          lastUpdated: Value(DateTime.now()),
        ),
      );

      if (deliveryOrderIds != null) {
        // update the status of each deliveryId to pending
        for (final int deliveryOrderId in deliveryOrderIds) {
          await (update(modelDeliveryOrder)
                ..where(
                  (table) => table.deliveryOrderId.equals(deliveryOrderId),
                ))
              .write(
            ModelDeliveryOrderCompanion(
              orderStatus: Value(deliveryStatus),
              lastUpdated: Value(DateTime.now()),
            ),
          );
        }
      }

      if (returnOrderIds != null) {
        // update the status of each returnId to pending
        for (final int returnOrderId in returnOrderIds) {
          await (update(modelReturnOrder)
                ..where(
                  (table) => table.returnOrderId.equals(returnOrderId),
                ))
              .write(
            ModelReturnOrderCompanion(
              returnStatus: Value(returnStatus),
              lastUpdated: Value(DateTime.now()),
            ),
          );
        }
      }

      if (transportStatus == "cancel") {
        // in modelVehicle to update the vehicleStatus to available
        await (update(modelVehicle)
              ..where(
                (table) => table.vehicleId.equals(vehicleId),
              ))
            .write(
          ModelVehicleCompanion(
            vehicleStatus: const Value("available"),
            lastUpdated: Value(DateTime.now()),
          ),
        );
      }
      return transportId;
    });
  }

  // update transport status to complete by id
  Future<List<int>> updateTransportStatusByIdComplete({
    required List<ModelTransportData> transportList,
  }) {
    return transaction(() async {
      final List<int> idList = [];
      for (final ModelTransportData data in transportList) {
        final int transportId = await (update(modelTransport)
              ..where(
                (table) => table.transportId.equals(data.transportId),
              ))
            .write(
          const ModelTransportCompanion(
            transportStatus: Value("complete"),
          ),
        );

        // in modelVehicle to update the vehicleStatus to available
        await (update(modelVehicle)
              ..where(
                (table) => table.vehicleId.equals(data.vehicleId),
              ))
            .write(
          ModelVehicleCompanion(
            vehicleStatus: const Value("available"),
            lastUpdated: Value(DateTime.now()),
          ),
        );
        idList.add(transportId);
      }
      return idList;
    });
  }

  // get all the transport which have status "start"
  Future<List<ModelTransportData>> getTransportByStatus() async {
    final transportList = await (select(modelTransport)
          ..where(
            (table) => table.transportStatus.equals("started"),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.transportId)]))
          
        .get();
    return transportList;
  }
}
