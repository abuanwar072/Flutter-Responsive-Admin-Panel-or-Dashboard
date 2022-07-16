part of 'employees_bloc.dart';

abstract class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

// FETCH EMPLOYEES EVENT
class GetEmployees extends EmployeesEvent {}

// STORE EMPLOYEE EVENT
class StoreEmployee extends EmployeesEvent {
  final Employee employee;
  const StoreEmployee({required this.employee});

  @override
  List<Object> get props => [employee];
}

// UPDATE EMPLOYEE EVENT
class UpdateEmployee extends EmployeesEvent {
  final Employee employee;
  const UpdateEmployee({required this.employee});

  @override
  List<Object> get props => [employee];
}

// DELETE EMPLOYEE EVENT
class DeleteEmployee extends EmployeesEvent {
  final Employee employee;
  const DeleteEmployee({required this.employee});

  @override
  List<Object> get props => [employee];
}
