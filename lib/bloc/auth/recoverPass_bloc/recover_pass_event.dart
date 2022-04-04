import 'package:equatable/equatable.dart';

abstract class RecoverPassEvent extends Equatable {
  const RecoverPassEvent();
}
//functions
class DoRecoverPassEvent extends RecoverPassEvent{
  final String email;
  DoRecoverPassEvent(this.email);
  @override
  List<Object> get props => [email];

}

