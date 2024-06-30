import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:push_notify/data/database/table/Noti.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // 기존 파일 삭제 (개발 중에만 사용)
    if (await file.exists()) {
      await file.delete();
    }

    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [Noti],
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );

  Future<int> addOrUpdateNoti(NotiCompanion notiCompanion) =>
      into(noti).insertOnConflictUpdate(notiCompanion);

  Future<int> turnOffNoti(NotiData data) =>
      (update(noti)..where((tbl) => tbl.id.equals(data.id)))
          .write(const NotiCompanion(status: Value(true)));

  Future<NotiData> getNoti(int id) =>
      (select(noti)..where((t) => t.id.equals(id))).getSingle();


  Future<List<NotiData>>? selectDate(String mode) => (select(noti)
        ..limit(1)
        ..orderBy(
            [(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)]))
      .get();

  Stream<List<NotiData>> getNotNotifiedNotiPaginationStream(
          int page, int limit) =>
      (select(noti)
            ..where((t) =>
                t.status.equals(false) &
                t.date.isBiggerThanValue(DateTime.now()))
            ..limit(limit * (page + 1))
            ..orderBy([
              (t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)
            ]))
          .watch();

  Stream<List<NotiData>> getNotiDataMonth(DateTime startDay, DateTime endDay) =>
      (select(noti)..where((t) => t.date.isBetweenValues(startDay, endDay)))
          .watch();

}
