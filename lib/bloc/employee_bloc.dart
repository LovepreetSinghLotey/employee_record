import 'package:employee_record/datasource/employee_data_source.dart';
import 'package:employee_record/model/employee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final roles = [
    "Product Designer",
    "Flutter Developer",
    "Senior Software Developer",
    "QA Tester",
    "Product Owner",
  ];

  DateTime? startDate;
  DateTime? endDate;
  Employee? _deletedEmployee;

  EmployeeBloc() : super(EmployeeInitial({})) {
    on<SetupEmployeeListener>(_setupEmployeeListener);
    on<SaveEmployee>(_saveEmployee);
    on<DeleteEmployee>(_deleteEmployee);
    on<UndoDeleteEmployee>(_undoDeleteEmployee);
  }

  void _saveEmployee(SaveEmployee event, emit) {
    GetIt.I<EmployeeDataSource>().saveEmployee(event.employee);
    startDate = null;
    endDate = null;
  }

  void _setupEmployeeListener(event, Emitter emit) async {
    await emit.forEach<RealmResultsChanges<Employee>>(
      GetIt.I<EmployeeDataSource>().employeeData(),
      onData: (employees) {
        final groupedEmployees = employees.results.fold(
          <EmployeeType, List<Employee>>{},
          (map, employee) {
            EmployeeType type =
                (employee.endDate == null ||
                        employee.endDate!.isAfter(DateTime.now()))
                    ? EmployeeType.current
                    : EmployeeType.previous;

            (map[type] ??= []).add(employee);
            return map;
          },
        );

        groupedEmployees.forEach((type, list) {
          list.sort((a, b) => b.startDate.compareTo(a.startDate));
        });

        final sortedGroupedEmployees = {
          EmployeeType.current: groupedEmployees[EmployeeType.current] ?? [],
          EmployeeType.previous: groupedEmployees[EmployeeType.previous] ?? [],
        }..removeWhere((key, value) => value.isEmpty);

        return EmployeeInitial(sortedGroupedEmployees);
      },
    );
  }

  void _deleteEmployee(DeleteEmployee event, emit) {
    _deletedEmployee = Employee(
      event.employee.id,
      event.employee.name,
      event.employee.designation,
      event.employee.startDate,
      endDate: event.employee.endDate,
      // Add other fields if necessary
    );
    GetIt.I<EmployeeDataSource>().deleteEmployee(event.employee);
  }

  void _undoDeleteEmployee(event, emit) {
    if (_deletedEmployee == null) return;
    GetIt.I<EmployeeDataSource>().saveEmployee(_deletedEmployee!);
    _deletedEmployee = null;
  }
}
