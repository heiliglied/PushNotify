import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:push_notify/database/tables/notification.dart';
part 'database.g.dart';

@DriftDatabase(tables: [Notification])

class Database extends _$Database {
  // we tell the database where to store the data with this constructor
  Database() : super(_openConnection());
  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  Future<int> insertNoti(NotificationCompanion notiCompanion) => into(notification).insert(notiCompanion);
  Stream<List<NotificationData>> watchAllNoti() => select(notification).watch();
  Stream<List<NotificationData>>? watchNotNotifiedNoti() => (select(notification)
    ..where((t) => t.status.equals(false) & t.date.isBiggerThanValue(DateTime.now()))
  ).watch();

  Stream<List<NotificationData>>? getNotNotifiedNotiPaginationStream(int page, int limit) => (select(notification)
    ..where((t) => t.status.equals(false) & t.date.isBiggerThanValue(DateTime.now()))..limit(limit, offset: page * limit)..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])
  ).watch();

  Future<List<NotificationData>>? getNotNotifiedNotiPagination(int page, int limit) => (select(notification)
    ..where((t) => t.status.equals(false) & t.date.isBiggerThanValue(DateTime.now()))..limit(limit, offset: page * limit)..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])
  ).get();

  Future<int> updateNoti(int id, NotificationCompanion notiCompanion) => (update(notification) ..where((t) => t.id.equals(id))).write(notiCompanion);

  Future<int> deleteNoti(int id) => (delete(notification) ..where((t) => t.id.equals(id))).go();

  Future<NotificationData?> selectNoti(int id) => (select(notification)..where((t) => t.id.equals(id))..limit(1)).getSingleOrNull();

  Future<List<NotificationData>>? selectFirstDate() => (select(notification)..limit(1)..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])).get();

  Future<List<NotificationData>>? selectLastDate() => (select(notification)..limit(1)..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])).get();

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}