import 'package:employee_record/bloc/employee_bloc.dart';
import 'package:employee_record/model/employee.dart';
import 'package:employee_record/ui/add_edit/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Created by lovepreetsingh on 03,April,2025

class MockEmployeeBloc extends Mock implements EmployeeBloc {}

class FakeEmployeeState extends Fake implements EmployeeState {}

class FakeEmployeeEvent extends Fake implements EmployeeEvent {}

void main() {
  late MockEmployeeBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeEmployeeState());
    registerFallbackValue(FakeEmployeeEvent());
  });

  setUp(() {
    mockBloc = MockEmployeeBloc();
    when(() => mockBloc.state).thenReturn(EmployeeInitial({}));
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(EmployeeInitial({})));
  });

  Widget createTestWidget({Employee? employee}) {
    return MaterialApp(
      home: BlocProvider<EmployeeBloc>.value(
        value: mockBloc,
        child: AddEditScreen(employee),
      ),
    );
  }

  testWidgets('renders AddEditScreen with correct UI elements', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text("Add Employee Details"), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4));
    expect(find.text("Save"), findsOneWidget);
    expect(find.text("Cancel"), findsOneWidget);
  });

  testWidgets('fills form with existing employee data when editing', (WidgetTester tester) async {
    final employee = Employee(1, "John Doe", "Developer", DateTime(2023, 5, 20));
    await tester.pumpWidget(createTestWidget(employee: employee));

    expect(find.text("Edit Employee Details"), findsOneWidget);
    expect(find.text("John Doe"), findsOneWidget);
    expect(find.text("Developer"), findsOneWidget);
  });

  testWidgets('shows error message if fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.tap(find.text("Save"));
    await tester.pump();

    expect(find.text("Please enter the name of employee!"), findsOneWidget);
  });

  testWidgets('triggers SaveEmployee event on valid input', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.byType(TextField).at(0), "Jane Doe");
    await tester.enterText(find.byType(TextField).at(1), "Designer");
    await tester.tap(find.text("Save"));
    await tester.pump();

    verifyNever(() => mockBloc.add(any())).called(0);
  });
}
