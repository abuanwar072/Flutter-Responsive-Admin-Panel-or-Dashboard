part of 'validation_bloc.dart';

abstract class ValidationState extends Equatable {
  const ValidationState();
  
  @override
  List<Object> get props => [];
}

class ValidationInitial extends ValidationState {}
