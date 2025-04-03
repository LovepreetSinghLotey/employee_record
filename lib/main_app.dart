import 'package:employee_record/bloc/employee_bloc.dart';
import 'package:employee_record/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Created by lovepreetsingh on 02,April,2025

extension CustomColors on ColorScheme {
  Color get buttonBlue => const Color(0xFF1DA1F2);
  Color get aliceBlue => const Color(0xFFEDF8FF);
  Color get jet => const Color(0xFF323238);
  Color get spanishGray => const Color(0xFF949C9E);
  Color get platinum => const Color(0xFFF2F2F2);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
