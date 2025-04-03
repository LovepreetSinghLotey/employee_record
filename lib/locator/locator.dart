import 'package:employee_record/datasource/employee_data_source.dart';
import 'package:get_it/get_it.dart';

/// Created by lovepreetsingh on 02,April,2025

class Locator {
  Future setupLocator() async {
    GetIt.I.registerLazySingleton<EmployeeDataSource>(
      () => EmployeeDataSource(),
    );
    await GetIt.I.allReady();
  }
}
