import 'package:drift/drift.dart';

class Notification extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()(); //time, date 포함해서 저장하기
  TextColumn get title => text()();
  TextColumn get contents => text()();
  BoolColumn get status => boolean()();

  /*
  @override
  List<Set<Column>> get uniqueKeys =>[
    {title, contents, status}
  ];
  */
}