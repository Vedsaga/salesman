import 'package:drift/drift.dart';

import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/drift/models/model_status_group.dart';

part 'status_group_table_queries.g.dart';

@DriftAccessor(tables: [ModelStatusGroup])
class StatusGroupTableQueries extends DatabaseAccessor<AppDatabase>
    with _$StatusGroupTableQueriesMixin {
  final AppDatabase db;
  StatusGroupTableQueries(this.db) : super(db);

  Future<List<int>> insertValues({
    required List<String> values,
    required String groupName,
  }) async {
    final List<int> listOfStatusId = [];
    if (values.isNotEmpty) {
      for (final value in values) {
        final int id = await into(modelStatusGroup).insert(
          ModelStatusGroupCompanion(
            value: Value(value),
            groupName: Value(groupName),
          ),
        );
        listOfStatusId.add(id);
      }
    }
    return listOfStatusId;
  }

  Future<List<ModelStatusGroupData>> getAllStatusByGroup({
    required String group,
  }) async {
    final List<ModelStatusGroupData> listOfStatus =
        await (select(modelStatusGroup)
              ..where((table) => table.groupName.equals(group)))
            .get();
    return listOfStatus;
  }

  Future<int> updateStatusValue({
    required int statusId,
    required String value,
  }) async {
    final int updated = await (update(modelStatusGroup)
          ..where((table) => table.statusGroupId.equals(statusId)))
        .write(
      ModelStatusGroupCompanion(
        value: Value(value),
      ),
    );
    return updated;
  }

  Future<int> deleteStatus({
    required int statusId,
  }) async {
    final int deleted = await (delete(modelStatusGroup)
          ..where((table) => table.statusGroupId.equals(statusId)))
        .go();
    return deleted;
  }
}
