import 'dart:async';

import 'package:employee_record/locator/locator.dart';
import 'package:employee_record/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

/// Created by lovepreetsingh on 02,April,2025

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      Locator().setupLocator();
      runApp(const MyApp());
    },
    (error, stack) {
      Logger.d(error);
      Logger.d(stack);
    },
    zoneSpecification: ZoneSpecification(),
  );
}
