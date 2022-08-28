import 'package:drift/drift.dart';

class Noti extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()(); //time, date 포함해서 저장하기
  TextColumn get title => text()();
  TextColumn get contents => text()();
  BoolColumn get status => boolean()();

}
