import 'package:equatable/equatable.dart';

abstract class LoginBlocState extends Equatable {
  const LoginBlocState();
}
//Initial state
class InitialLoginBlocState extends LoginBlocState {
  @override
  List<Object> get props => [];
}
//While the function is running
class LogginInBlocState extends LoginBlocState{
  @override
  List<Object> get props => [];
}
// When the result has arrived
class LoggedInBlocState extends LoginBlocState{
  final bool isLog;
  LoggedInBlocState(this.isLog);
  @override
  List<Object> get props => [isLog];

}
// When the result has arrived
class SignOutBlocState extends LoginBlocState{
  final bool isSignOut;
  SignOutBlocState(this.isSignOut);
  @override
  List<Object> get props => [isSignOut];

}
class ErrorBlocState extends LoginBlocState{
  final String message;

  ErrorBlocState(this.message);

  @override
  List<Object> get props => [message];

}
