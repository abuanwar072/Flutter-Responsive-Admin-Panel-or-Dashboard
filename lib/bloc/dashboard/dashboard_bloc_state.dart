import 'package:yupcity_admin/models/yupcity_trap_poi.dart';
import 'package:yupcity_admin/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardBlocState extends Equatable {
  const DashboardBlocState();
}
//Initial state
class InitialBoardBlocState extends DashboardBlocState {
  @override
  List<Object> get props => [];
}

class UpdatingUserBlocState extends DashboardBlocState {
  @override
  List<Object> get props => [];
}

class UpdatedUserBlocState extends DashboardBlocState {

  final YupcityUser user;

  const UpdatedUserBlocState(this.user);

  @override
  List<Object> get props => [];
}

class PoiDataBlocState extends DashboardBlocState {

  final List<YupcityTrapPoi> listOfPois;

  const PoiDataBlocState(this.listOfPois);

  @override
  List<Object> get props => [];
}

class FinishUpdatingUserBlocState extends DashboardBlocState {
  @override
  List<Object> get props => [];
}

class ErrorUpdatingUserBlocState extends DashboardBlocState{


  final String message;

  const ErrorUpdatingUserBlocState(this.message);

  @override
  List<Object> get props => [message];

}
