part of 'employees_bloc.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => [];
}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<Employee> employees;

  const EmployeesLoaded({required this.employees});

  @override
  List<Object> get props => [employees];
}

class EmployeeDuplication extends EmployeesState {}

class EmployeesFailure extends EmployeesState {
  final String message;

  const EmployeesFailure({required this.message});

  @override
  List<Object> get props => [message];
}