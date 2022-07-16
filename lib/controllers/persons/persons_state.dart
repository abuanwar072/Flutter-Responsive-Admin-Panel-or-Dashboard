part of 'persons_bloc.dart';

abstract class PersonsState extends Equatable {
  const PersonsState();

  @override
  List<Object> get props => [];
}

class PersonsLoading extends PersonsState {}

class PersonsLoaded extends PersonsState {
  final List<Person> persons;
  const PersonsLoaded({required this.persons});

  @override
  List<Object> get props => [persons];
}

class PersonAdded extends PersonsState {}

class PersonUpdated extends PersonsState {}

class PersonTerminated extends PersonsState {}

class PersonsError extends PersonsState {
  final String message;
  const PersonsError({required this.message});

  @override
  List<Object> get props => [message];
}
