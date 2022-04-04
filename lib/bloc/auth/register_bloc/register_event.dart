import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}
//functions
class DoRegisterEvent extends RegisterEvent{
  final String name;
  final String email;
  final String telephone;
  final String password;

  const DoRegisterEvent(this.name,  this.email, this.telephone, this.password);

  @override
  List<Object> get props => [email,password];

}
