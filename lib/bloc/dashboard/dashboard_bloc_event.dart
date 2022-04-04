import 'package:yupcity_admin/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardBlocEvent extends Equatable {
  const DashboardBlocEvent();
}

class GetUserDataEvent extends DashboardBlocEvent{

  const GetUserDataEvent();
  @override
  List<Object> get props => [];

}


class GetUserByUsernameDataEvent extends DashboardBlocEvent{

  final String userName;

  const GetUserByUsernameDataEvent(this.userName);

  @override
  List<Object> get props => [];

}

class GetPoiDataEvent extends DashboardBlocEvent {

  const GetPoiDataEvent();

  @override
  List<Object> get props => [];

}


class SavePoiDataEvent extends DashboardBlocEvent {

  final String center;

  final String centerDescription;

  final double latitude;

  final double longuitude;


  const SavePoiDataEvent(this.center, this.centerDescription, this.latitude, this.longuitude);

  @override
  List<Object> get props => [];

}



class UpdateUserDataEvent extends DashboardBlocEvent{

  final String name;

  final String bio;

  final int theme;

  final String background;

  final bool needsReturn;

  const UpdateUserDataEvent(this.name, this.bio, this.theme, this.background, this.needsReturn);
  @override
  List<Object> get props => [];

}

