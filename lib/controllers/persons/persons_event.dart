part of 'persons_bloc.dart';

abstract class PersonsEvent extends Equatable {
  const PersonsEvent();

  @override
  List<Object> get props => [];
}

// GET PERSONS WITH SPECHIAL NEEDS
class GetPersonsWithSpecialNeeds extends PersonsEvent {}

// ADD PERSON WITH SPECIAL NEEDS
class AddPersonWithSpecialNeeds extends PersonsEvent {
  final Person person;

  const AddPersonWithSpecialNeeds({required this.person});

  @override
  List<Object> get props => [person];
}

// UPDATE PERSON WITH SPECIAL NEEDS
class UpdatePersonWithSpecialNeeds extends PersonsEvent {
  final Person person;

  const UpdatePersonWithSpecialNeeds({required this.person});

  @override
  List<Object> get props => [person];
}

// TERMINATE PERSON WITH SPECIAL NEEDs
class TerminatePersonWithSpecialNeeds extends PersonsEvent {
  final Person person;

  const TerminatePersonWithSpecialNeeds({required this.person});

  @override
  List<Object> get props => [person];
}
