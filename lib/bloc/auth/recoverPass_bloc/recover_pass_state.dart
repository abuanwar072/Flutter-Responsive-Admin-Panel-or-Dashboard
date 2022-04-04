import 'package:equatable/equatable.dart';

abstract class RecoverPassState extends Equatable {
  const RecoverPassState();
}

//Initial state
class InitialRecoverPassState extends RecoverPassState {
  @override
  List<Object> get props => [];
}

//While the function is running
class RecoverinPassInBlocState extends RecoverPassState {
  @override
  List<Object> get props => [];
}

class RecoveringPassInBlocState extends RecoverPassState {
  final String email;
  RecoveringPassInBlocState(this.email);
  @override
  List<Object> get props => [email];
}


// When the result has arrived
class RecoveredPassInBlocState extends RecoverPassState {
  final bool done;
  RecoveredPassInBlocState(this.done);
  @override
  List<Object> get props => [done];
}

class ErrorRecoverPassBlocState extends RecoverPassState {
  final String message;

  ErrorRecoverPassBlocState(this.message);

  @override
  List<Object> get props => [message];
}
