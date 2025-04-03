import 'dart:async';

import 'package:employee_record/model/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:realm/realm.dart';
import 'package:sembast_web/sembast_web.dart';

/// Created by lovepreetsingh on 02,April,2025

class EmployeeDataSource {
  late Realm realm;
  late StoreRef store;
  late Database webDb;

  Future initRealm() async {
    var config = Configuration.local([Employee.schema]);
    realm = Realm(config);
  }

  Future initWebDb() async {
    store = intMapStoreFactory.store();
    var factory = databaseFactoryWeb;
    webDb = await factory.openDatabase('employees');
  }

  void saveEmployee(Employee employee) async {
    if (kIsWeb) {
      await store
          .record(employee.id)
          .put(webDb, employee.toJson(), ifNotExists: true);
    } else {
      realm.write(() {
        realm.add(employee, update: true);
      });
    }
  }

  void deleteEmployee(Employee employee) async {
    if (kIsWeb) {
      var filter = Filter.equals('id', employee.id);
      var finder = Finder(filter: filter);
      await store.delete(webDb, finder: finder);
    } else {
      realm.write(() {
        realm.delete(employee);
      });
    }
  }

  Stream<RealmResultsChanges<Employee>> employeeData() =>
      realm.all<Employee>().changes;

  Stream employeeWebData() => store.query().onSnapshots(webDb);

  void closeWebDb() {
    if (kIsWeb) {
      webDb.close();
    } else {
      realm.close();
    }
  }
}
