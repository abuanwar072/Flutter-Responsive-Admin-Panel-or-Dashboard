import 'package:yupcity_admin/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEditBlocEvent extends Equatable {
  const UserEditBlocEvent();
}

class GetUserDataEvent extends UserEditBlocEvent{

  const GetUserDataEvent();
  @override
  List<Object> get props => [];

}


class GetUserByUsernameDataEvent extends UserEditBlocEvent{

  final String userName;

  const GetUserByUsernameDataEvent(this.userName);

  @override
  List<Object> get props => [];

}


class UpdateUserDataEvent extends UserEditBlocEvent{

  final String name;

  final String bio;

  final int theme;

  final String background;

  final bool needsReturn;

  const UpdateUserDataEvent(this.name, this.bio, this.theme, this.background, this.needsReturn);
  @override
  List<Object> get props => [];

}