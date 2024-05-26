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

  Future<int> addOrUpdateNoti(NotiCompanion notiCompanion) =>
      into(noti).insertOnConflictUpdate(notiCompanion);

  // Stream<List<NotiData>> watchAllNoti() => select(noti).watch();

  // MultiSelectable<NotiData> watchPagingNoti(int page,
  //         {required int pageSize}) =>
  //     select(noti)
  //       ..where((t) =>
  //           t.status.equals(false) & t.date.isBiggerThanValue(DateTime.now()))
  //       ..limit(pageSize, offset: page);

  // Stream<List<NotiData>> watchNotNotifiedNoti() => (select(noti)
  //       ..where((t) =>
  //           t.status.equals(false) & t.date.isBiggerThanValue(DateTime.now())))
  //     .watch();

  Future<int> turnOffNoti(NotiData data) =>
      (update(noti)..where((tbl) => tbl.id.equals(data.id)))
          .write(const NotiCompanion(status: Value(true)));

  Future<NotiData> getNoti(int id) =>
      (select(noti)..where((t) => t.id.equals(id))).getSingle();

  Future<List<NotiData>> getNotNotifiedNotiPagination(int page, int limit) =>
      (select(noti)
            ..where((t) =>
                t.status.equals(false) &
                t.date.isBiggerThanValue(DateTime.now()))
            ..limit(limit, offset: (page - 1) * 10)
            ..orderBy([
              (t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)
            ]))
          .get();

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

  // Future<List<NotiData>> getNotiDataMonth(DateTime startDay, DateTime endDay) =>
  //     (select(noti)..where((t) => t.date.isBetweenValues(startDay, endDay))).get();

  // Stream<List<NotiData>> getNotiDataCalendar() =>
  //     (select(noti)).watch();

// Future<List<NotiData>> getNotNotifiedNotiPagination(int page, int limit) => (select(noti)
//   ..where((t) => t.status.equals(false) & t.date.isBiggerThanValue(DateTime.now()))..limit(limit, offset: (page - 1) * 10)
// ).get();

// Stream<List<NotiData>> getNotNotifiedNotiPagination(int page, int limit) => (select(noti)
//   ..where((t) => t.status.equals(false) & t.date.isBiggerThanValue(DateTime.now()))..limit(limit, offset: (page - 1) * 10)
// ).watch();

// Future<int> turnOffNoti(int id, NotiCompanion notiCompanion) => (update(noti) ..where((t) => t.id.equals(id))).write(notiCompanion);

// Future<List<NotiData>> watchNotNotifiedNoti() => (select(noti)
//   ..where((t) => t.status.equals(false))
//   ..where((t) => t.date.isBiggerThanValue(DateTime.now())))
//     .get();
}
