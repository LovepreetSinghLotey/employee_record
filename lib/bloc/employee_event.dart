part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class SetupEmployeeListener extends EmployeeEvent {
  const SetupEmployeeListener();

  @override
  List<Object?> get props => [];
}

class SaveEmployee extends EmployeeEvent {
  final Employee employee;
  const SaveEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

class DeleteEmployee extends EmployeeEvent {
  final Employee employee;
  const DeleteEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

class UndoDeleteEmployee extends EmployeeEvent {
  const UndoDeleteEmployee();

  @override
  List<Object?> get props => [];
}
