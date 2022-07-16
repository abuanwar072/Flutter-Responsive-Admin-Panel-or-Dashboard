import 'package:admin/config/helper.dart';
import 'package:admin/models/models.dart';
import 'package:admin/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'persons_event.dart';
part 'persons_state.dart';

class PersonsBloc extends Bloc<PersonsEvent, PersonsState> {
  final PersonsServices _personServices;
  PersonsBloc()
      : _personServices = PersonsServices(),
        super(PersonsLoading()) {
    on<GetPersonsWithSpecialNeeds>(_onGetPersonsWithSpecialNeeds);
    on<AddPersonWithSpecialNeeds>(_onAddPersonWithSpecialNeeds);
    on<UpdatePersonWithSpecialNeeds>(_onUpdatePersonWithSpecialNeeds);
    on<TerminatePersonWithSpecialNeeds>(_onTerminatePersonWithSpecialNeeds);
  }

  // GET PERSONS EVENT
  Future<void> _onGetPersonsWithSpecialNeeds(
    GetPersonsWithSpecialNeeds event,
    Emitter<PersonsState> emit,
  ) async {
    emit(PersonsLoading());
    final persons = await _personServices.getPersonsWithSpecialNeeds();
    if (persons != null) {
      emit(PersonsLoaded(persons: persons));
      Helper.logger.d('Persons Bloc:: ()=> Persons loaded');
    } else {
      emit(const PersonsError(
          message: 'Failed to load persons with special needs'));
      Helper.logger.e('Persons Bloc:: ()=> Persons error');
    }
  }

  // ADD PERSON EVENT
  Future<void> _onAddPersonWithSpecialNeeds(
    AddPersonWithSpecialNeeds event,
    Emitter<PersonsState> emit,
  ) async {
    emit(PersonsLoading());
    final person =
        await _personServices.storePersonWithSpecialNeeds(event.person);
    if (person!) {
      Helper.logger.d('Persons Bloc:: ()=> Person added');
      final persons = await _personServices.getPersonsWithSpecialNeeds();
      if (persons != null) {
        emit(PersonsLoaded(persons: persons));
        Helper.logger.d('Persons Bloc:: ()=> Persons loaded');
      } else {
        emit(const PersonsError(
            message: 'Failed to load persons with special needs'));
        Helper.logger.e('Persons Bloc:: ()=> Persons error');
      }
    } else {
      emit(const PersonsError(
          message: 'Failed to add person with special needs'));
      Helper.logger.e('Persons Bloc:: ()=> Person error');
    }
  }

  // UPDATE PERSON
  Future<void> _onUpdatePersonWithSpecialNeeds(
    UpdatePersonWithSpecialNeeds event,
    Emitter<PersonsState> emit,
  ) async {
    emit(PersonsLoading());
    final person =
        await _personServices.updatePersonWithSpecialNeeds(event.person);
    if (person!) {
      Helper.logger.d('Persons Bloc:: ()=> Person updated');
      final persons = await _personServices.getPersonsWithSpecialNeeds();
      if (persons != null) {
        emit(PersonsLoaded(persons: persons));
        Helper.logger.d('Persons Bloc:: ()=> Persons loaded');
      } else {
        emit(const PersonsError(
            message: 'Failed to load persons with special needs'));
        Helper.logger.e('Persons Bloc:: ()=> Persons error');
      }
    } else {
      emit(const PersonsError(
          message: 'Failed to update person with special needs'));
      Helper.logger.e('Persons Bloc:: ()=> Person error');
    }
  }

  // TERMINATE PERSON
  Future<void> _onTerminatePersonWithSpecialNeeds(
    TerminatePersonWithSpecialNeeds event,
    Emitter<PersonsState> emit,
  ) async {
    emit(PersonsLoading());
    final person =
        await _personServices.terminatePersonWithSpecialNeeds(event.person);
    if (person!) {
      Helper.logger.d('Persons Bloc:: ()=> Person terminated');
      final persons = await _personServices.getPersonsWithSpecialNeeds();
      if (persons != null) {
        emit(PersonsLoaded(persons: persons));
        Helper.logger.d('Persons Bloc:: ()=> Persons loaded');
      } else {
        emit(const PersonsError(
            message: 'Failed to load persons with special needs'));
        Helper.logger.e('Persons Bloc:: ()=> Persons error');
      }
    } else {
      emit(const PersonsError(
          message: 'Failed to terminate person with special needs'));
      Helper.logger.e('Persons Bloc:: ()=> Person error');
    }
  }
}
