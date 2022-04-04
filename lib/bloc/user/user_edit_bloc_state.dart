import 'package:yupcity_admin/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEditBlocState extends Equatable {
  const UserEditBlocState();
}
//Initial state
class InitialUserEditBlocState extends UserEditBlocState {
  @override
  List<Object> get props => [];
}

class UpdatingUserBlocState extends UserEditBlocState {
  @override
  List<Object> get props => [];
}

class UpdatedUserBlocState extends UserEditBlocState {

  final YupcityUser user;

  const UpdatedUserBlocState(this.user);

  @override
  List<Object> get props => [];
}

class FinishUpdatingUserBlocState extends UserEditBlocState {
  @override
  List<Object> get props => [];
}

class ErrorUpdatingUserBlocState extends UserEditBlocState{


  final String message;

  const ErrorUpdatingUserBlocState(this.message);

  @override
  List<Object> get props => [message];

}
