// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $NotiTable extends Noti with TableInfo<$NotiTable, NotiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentsMeta =
      const VerificationMeta('contents');
  @override
  late final GeneratedColumn<String> contents = GeneratedColumn<String>(
      'contents', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<bool> status = GeneratedColumn<bool>(
      'status', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("status" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, date, title, contents, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'noti';
  @override
  VerificationContext validateIntegrity(Insertable<NotiData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('contents')) {
      context.handle(_contentsMeta,
          contents.isAcceptableOrUnknown(data['contents']!, _contentsMeta));
    } else if (isInserting) {
      context.missing(_contentsMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotiData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      contents: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contents'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $NotiTable createAlias(String alias) {
    return $NotiTable(attachedDatabase, alias);
  }
}

class NotiData extends DataClass implements Insertable<NotiData> {
  final int id;
  final DateTime date;
  final String title;
  final String contents;
  final bool status;
  const NotiData(
      {required this.id,
      required this.date,
      required this.title,
      required this.contents,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['title'] = Variable<String>(title);
    map['contents'] = Variable<String>(contents);
    map['status'] = Variable<bool>(status);
    return map;
  }

  NotiCompanion toCompanion(bool nullToAbsent) {
    return NotiCompanion(
      id: Value(id),
      date: Value(date),
      title: Value(title),
      contents: Value(contents),
      status: Value(status),
    );
  }

  factory NotiData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotiData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      title: serializer.fromJson<String>(json['title']),
      contents: serializer.fromJson<String>(json['contents']),
      status: serializer.fromJson<bool>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'title': serializer.toJson<String>(title),
      'contents': serializer.toJson<String>(contents),
      'status': serializer.toJson<bool>(status),
    };
  }

  NotiData copyWith(
          {int? id,
          DateTime? date,
          String? title,
          String? contents,
          bool? status}) =>
      NotiData(
        id: id ?? this.id,
        date: date ?? this.date,
        title: title ?? this.title,
        contents: contents ?? this.contents,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('NotiData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('contents: $contents, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, title, contents, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotiData &&
          other.id == this.id &&
          other.date == this.date &&
          other.title == this.title &&
          other.contents == this.contents &&
          other.status == this.status);
}

class NotiCompanion extends UpdateCompanion<NotiData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> title;
  final Value<String> contents;
  final Value<bool> status;
  const NotiCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.title = const Value.absent(),
    this.contents = const Value.absent(),
    this.status = const Value.absent(),
  });
  NotiCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String title,
    required String contents,
    required bool status,
  })  : date = Value(date),
        title = Value(title),
        contents = Value(contents),
        status = Value(status);
  static Insertable<NotiData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? title,
    Expression<String>? contents,
    Expression<bool>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (title != null) 'title': title,
      if (contents != null) 'contents': contents,
      if (status != null) 'status': status,
    });
  }

  NotiCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? title,
      Value<String>? contents,
      Value<bool>? status}) {
    return NotiCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      contents: contents ?? this.contents,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contents.present) {
      map['contents'] = Variable<String>(contents.value);
    }
    if (status.present) {
      map['status'] = Variable<bool>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotiCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('contents: $contents, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  _$MyDatabaseManager get managers => _$MyDatabaseManager(this);
  late final $NotiTable noti = $NotiTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [noti];
}

typedef $$NotiTableInsertCompanionBuilder = NotiCompanion Function({
  Value<int> id,
  required DateTime date,
  required String title,
  required String contents,
  required bool status,
});
typedef $$NotiTableUpdateCompanionBuilder = NotiCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<String> title,
  Value<String> contents,
  Value<bool> status,
});

class $$NotiTableTableManager extends RootTableManager<
    _$MyDatabase,
    $NotiTable,
    NotiData,
    $$NotiTableFilterComposer,
    $$NotiTableOrderingComposer,
    $$NotiTableProcessedTableManager,
    $$NotiTableInsertCompanionBuilder,
    $$NotiTableUpdateCompanionBuilder> {
  $$NotiTableTableManager(_$MyDatabase db, $NotiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NotiTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NotiTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$NotiTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> contents = const Value.absent(),
            Value<bool> status = const Value.absent(),
          }) =>
              NotiCompanion(
            id: id,
            date: date,
            title: title,
            contents: contents,
            status: status,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required String title,
            required String contents,
            required bool status,
          }) =>
              NotiCompanion.insert(
            id: id,
            date: date,
            title: title,
            contents: contents,
            status: status,
          ),
        ));
}

class $$NotiTableProcessedTableManager extends ProcessedTableManager<
    _$MyDatabase,
    $NotiTable,
    NotiData,
    $$NotiTableFilterComposer,
    $$NotiTableOrderingComposer,
    $$NotiTableProcessedTableManager,
    $$NotiTableInsertCompanionBuilder,
    $$NotiTableUpdateCompanionBuilder> {
  $$NotiTableProcessedTableManager(super.$state);
}

class $$NotiTableFilterComposer extends FilterComposer<_$MyDatabase, $NotiTable> {
  $$NotiTableFilterComposer(super.$state);

  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column as Expression<int>, joinBuilders: joinBuilders)
  );

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column as Expression<DateTime>, joinBuilders: joinBuilders)
  );

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column as Expression<String>, joinBuilders: joinBuilders)
  );

  ColumnFilters<String> get contents => $state.composableBuilder(
      column: $state.table.contents,
      builder: (column, joinBuilders) =>
          ColumnFilters(column as Expression<String>, joinBuilders: joinBuilders)
  );

  ColumnFilters<bool> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column as Expression<bool>, joinBuilders: joinBuilders)
  );
}

class $$NotiTableOrderingComposer extends OrderingComposer<_$MyDatabase, $NotiTable> {
  $$NotiTableOrderingComposer(super.$state);

  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column as Expression<int>, joinBuilders: joinBuilders)
  );

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column as Expression<DateTime>, joinBuilders: joinBuilders)
  );

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column as Expression<String>, joinBuilders: joinBuilders)
  );

  ColumnOrderings<String> get contents => $state.composableBuilder(
      column: $state.table.contents,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column as Expression<String>, joinBuilders: joinBuilders)
  );

  ColumnOrderings<bool> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column as Expression<bool>, joinBuilders: joinBuilders)
  );
}

class _$MyDatabaseManager {
  final _$MyDatabase _db;
  _$MyDatabaseManager(this._db);
  $$NotiTableTableManager get noti => $$NotiTableTableManager(_db, _db.noti);
}
