part of 'employee_bloc.dart';

class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

final class EmployeeInitial extends EmployeeState {
  final Map<EmployeeType, List<Employee>> employees;
  const EmployeeInitial(this.employees);

  @override
  List<Object> get props => [employees];
}
