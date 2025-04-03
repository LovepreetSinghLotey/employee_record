import 'dart:async';

import 'package:employee_record/datasource/employee_data_source.dart';
import 'package:employee_record/locator/locator.dart';
import 'package:employee_record/main_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:get_it/get_it.dart';

/// Created by lovepreetsingh on 02,April,2025

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      Locator().setupLocator();
      if(kIsWeb) {
        await GetIt.I<EmployeeDataSource>().initWebDb();
      } else{
        await GetIt.I<EmployeeDataSource>().initRealm();
      }
      runApp(const MyApp());
    },
    (error, stack) {
      Logger.d(error);
      Logger.d(stack);
    },
    zoneSpecification: ZoneSpecification(),
  );
}
