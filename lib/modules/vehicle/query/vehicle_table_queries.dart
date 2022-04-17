import 'package:drift/drift.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_vehicle.dart';

part 'vehicle_table_queries.g.dart';

@DriftAccessor(tables: [ModelVehicle])
class VehicleTableQueries extends DatabaseAccessor<AppDatabase>
    with _$VehicleTableQueriesMixin {
  final AppDatabase db;
  VehicleTableQueries(this.db) : super(db);

  // get all vehicles where isActive = true
  Future<List<ModelVehicleData>> getAllActiveVehicles() async {
    return (select(modelVehicle)
          ..where((table) => table.isActive.equals(true))
          ..orderBy([
            (table) => OrderingTerm.desc(table.vehicleId),
          ])
          )
        .get();
  }

  Future<int> insertVehicle(ModelVehicleCompanion vehicle) async {
    return into(modelVehicle).insert(vehicle);
  }

  // update deActiveVehicle
   Future<int> deActiveVehicle(int vehicleId) async {
    return (update(modelVehicle)
          ..where((table) => table.vehicleId.equals(vehicleId)))
        .write(
      const ModelVehicleCompanion(
        isActive: Value(false),
      ),
    );
  }


  

}
