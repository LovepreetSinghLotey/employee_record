import 'package:employee_record/bloc/employee_bloc.dart';
import 'package:employee_record/model/employee.dart';
import 'package:employee_record/ui/home/home_screen.dart';
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

    // Mock state and stream
    when(() => mockBloc.state).thenReturn(EmployeeInitial({}));
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(EmployeeInitial({})));
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<EmployeeBloc>.value(
        value: mockBloc,
        child: HomeScreen(),
      ),
    );
  }

  testWidgets('renders HomeScreen with AppBar and FAB', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text("Employee List"), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('shows empty state when there are no employees', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('shows employee list when employees exist', (WidgetTester tester) async {
    final Map<EmployeeType, List<Employee>> employees = {
      EmployeeType.current: [Employee(1, "John Doe", "Product", DateTime.now())],
      EmployeeType.previous: []
    };

    when(() => mockBloc.state).thenReturn(EmployeeInitial(employees));
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(EmployeeInitial(employees)));

    await tester.pumpWidget(createTestWidget());
    expect(find.text("John Doe"), findsOneWidget);
  });

  testWidgets('triggers delete action on swipe left', (WidgetTester tester) async {
    var employee = Employee(1, "John Doe", "Product", DateTime.now());
    final employees = {
      EmployeeType.current: [employee]
    };

    when(() => mockBloc.state).thenReturn(EmployeeInitial(employees));
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(EmployeeInitial(employees)));

    await tester.pumpWidget(createTestWidget());
    await tester.drag(find.text("John Doe"), const Offset(-500, 0));
    await tester.pumpAndSettle();

    verify(() => mockBloc.add(DeleteEmployee(employee))).called(1);
  });
}
