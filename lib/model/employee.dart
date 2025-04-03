import 'package:realm/realm.dart';

/// Created by lovepreetsingh on 02,April,2025

part 'employee.realm.dart';

enum EmployeeType {
  current("Current employees"),
  previous("Previous employees");

  final String stringValue;
  const EmployeeType(this.stringValue);
}

@RealmModel()
class _Employee {
  @PrimaryKey()
  late int id;
  late String name;
  late String designation;
  late DateTime startDate;
  late DateTime? endDate;
}
