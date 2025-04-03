import 'dart:async';

import 'package:employee_record/model/employee.dart';
import 'package:realm/realm.dart';

/// Created by lovepreetsingh on 02,April,2025

class EmployeeDataSource {
  late Realm realm;
  EmployeeDataSource() {
    var config = Configuration.local([Employee.schema]);
    realm = Realm(config);
  }

  void saveEmployee(Employee employee) => realm.write(() {
    realm.add(employee, update: true);
  });

  void deleteEmployee(Employee employee) => realm.write((){
    realm.delete(employee);
  });

  Stream<RealmResultsChanges<Employee>> employeeData() =>
      realm.all<Employee>().changes;
}
