// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Employee extends _Employee
    with RealmEntity, RealmObjectBase, RealmObject {
  Employee(
    int id,
    String name,
    String designation,
    DateTime startDate, {
    DateTime? endDate,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'designation', designation);
    RealmObjectBase.set(this, 'startDate', startDate);
    RealmObjectBase.set(this, 'endDate', endDate);
  }

  Employee._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get designation =>
      RealmObjectBase.get<String>(this, 'designation') as String;
  @override
  set designation(String value) =>
      RealmObjectBase.set(this, 'designation', value);

  @override
  DateTime get startDate =>
      RealmObjectBase.get<DateTime>(this, 'startDate') as DateTime;
  @override
  set startDate(DateTime value) =>
      RealmObjectBase.set(this, 'startDate', value);

  @override
  DateTime? get endDate =>
      RealmObjectBase.get<DateTime>(this, 'endDate') as DateTime?;
  @override
  set endDate(DateTime? value) => RealmObjectBase.set(this, 'endDate', value);

  @override
  Stream<RealmObjectChanges<Employee>> get changes =>
      RealmObjectBase.getChanges<Employee>(this);

  @override
  Stream<RealmObjectChanges<Employee>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Employee>(this, keyPaths);

  @override
  Employee freeze() => RealmObjectBase.freezeObject<Employee>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'designation': designation.toEJson(),
      'startDate': startDate.toEJson(),
      'endDate': endDate.toEJson(),
    };
  }

  static EJsonValue _toEJson(Employee value) => value.toEJson();
  static Employee _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'designation': EJsonValue designation,
        'startDate': EJsonValue startDate,
      } =>
        Employee(
          fromEJson(id),
          fromEJson(name),
          fromEJson(designation),
          fromEJson(startDate),
          endDate: fromEJson(ejson['endDate']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Employee._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Employee, 'Employee', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('designation', RealmPropertyType.string),
      SchemaProperty('startDate', RealmPropertyType.timestamp),
      SchemaProperty('endDate', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
