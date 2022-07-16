import 'package:admin/models/employee.dart';
import 'package:admin/services/employees_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  // CREATE AN INSTANCE OF EMPLOYEES SERVICES CLASS
  final EmployeesServices _employeesServices;

  EmployeesBloc()

      // INITIALIZE _EMPLOYEES SERVICES CLASS
      : _employeesServices = EmployeesServices(),
        super(EmployeesLoading()) {
    on<GetEmployees>(_onGetEmployees);
    on<StoreEmployee>(_onStoreEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
  }

  // ? PROCESS GET EMPLOYEES EVENT
  Future<void> _onGetEmployees(
    GetEmployees event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    List<Employee>? employees = await _employeesServices.getEmployees();
    if (employees == null) {
      emit(const EmployeesFailure(message: 'Failed to load employees'));
    } else {
      emit(EmployeesLoaded(employees: employees));
    }
  }

  // ? PROCESS STORE EMPLOYEE EVENT
  Future<void> _onStoreEmployee(
    StoreEmployee event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    bool? stored = await _employeesServices.storeEmployee(event.employee);
    if (stored == null) {
      emit(EmployeeDuplication());
    } else if (!stored) {
      emit(const EmployeesFailure(message: 'Failed to store employee'));
    } else {
      List<Employee>? employees = await _employeesServices.getEmployees();
      if (employees == null) {
        emit(const EmployeesFailure(message: 'Failed to load employees'));
      } else {
        emit(EmployeesLoaded(employees: employees));
      }
    }
  }

  Future<void> _onUpdateEmployee(
    UpdateEmployee event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    bool updated = await _employeesServices.updateEmployee(event.employee);
    if (!updated) {
      emit(const EmployeesFailure(message: 'Failed to update employee'));
    } else {
      List<Employee>? employees = await _employeesServices.getEmployees();
      if (employees == null) {
        emit(const EmployeesFailure(message: 'Failed to load employees'));
      } else {
        emit(EmployeesLoaded(employees: employees));
      }
    }
  }

  Future<void> _onDeleteEmployee(
    DeleteEmployee event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    bool deleted = await _employeesServices.deleteEmployee(event.employee);
    if (!deleted) {
      emit(const EmployeesFailure(message: 'Failed to delete employee'));
    } else {
      List<Employee>? employees = await _employeesServices.getEmployees();
      if (employees == null) {
        emit(const EmployeesFailure(message: 'Failed to load employees'));
      } else {
        emit(EmployeesLoaded(employees: employees));
      }
    }
  }
}
