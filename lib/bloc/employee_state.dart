part of 'employee_bloc.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();
}

final class EmployeeInitial extends EmployeeState {
  final Map<EmployeeType, List<Employee>> employees;
  const EmployeeInitial(this.employees);

  @override
  List<Object> get props => [employees];
}
