part of 'validation_bloc.dart';

abstract class ValidationEvent extends Equatable {
  const ValidationEvent();

  @override
  List<Object> get props => [];
}

class ValidateField extends ValidationEvent {
  final String fieldValue;

  ValidateField({required this.fieldValue});
  @override
  List<Object> get props => [fieldValue];
}
