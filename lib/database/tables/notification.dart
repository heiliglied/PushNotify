import 'package:drift/drift.dart';

class Notification extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get title => text()();
  TextColumn get contents => text()();
  BoolColumn get status => boolean()();
}