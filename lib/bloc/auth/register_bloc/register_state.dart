import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

//Initial state
class InitialRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}

//While the function is running
class RegisterinInBlocState extends RegisterState {
  @override
  List<Object> get props => [];
}

// When the result has arrived
class RegisteredInBlocState extends RegisterState {
  final bool done;
  RegisteredInBlocState(this.done);
  @override
  List<Object> get props => [done];
}

class ErrorRegisterBlocState extends RegisterState {
  final String message;

  ErrorRegisterBlocState(this.message);

  @override
  List<Object> get props => [message];
}
