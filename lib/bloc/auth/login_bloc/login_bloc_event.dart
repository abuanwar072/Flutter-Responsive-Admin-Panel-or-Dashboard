import 'package:equatable/equatable.dart';

abstract class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();
}
//functions
class DoLoginEvent extends  LoginBlocEvent{

  final String email;
  final String password;

  DoLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email,password];

}
class SignOutEvent extends LoginBlocEvent{
  final bool signOut;
  SignOutEvent(this.signOut);
  @override
  List<Object> get props => [signOut];

}

class DoLoginWithFacebookEvent extends  LoginBlocEvent{
  final String email;

  DoLoginWithFacebookEvent(this.email);

  @override
  List<Object> get props => [email];

}

