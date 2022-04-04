
import 'package:yupcity_admin/models/yupcity_trap_poi.dart';
import 'package:yupcity_admin/services/application/dashboard_logic.dart';
import 'package:yupcity_admin/services/application/update_user_logic.dart';
import 'package:yupcity_admin/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'dashboard_bloc_event.dart';
import 'dashboard_bloc_state.dart';

class DashboardBloc extends Bloc<DashboardBlocEvent, DashboardBlocState> {
  DashboardBloc({@required this.logic}) : super(InitialBoardBlocState()) {

    on<SavePoiDataEvent>((event, emit) async {

    });


    on<GetPoiDataEvent>((event, emit) async {
      await getPoiEventHandler(emit, event);
    });
  }

  Future<void> savePoiEventHandler(Emitter<DashboardBlocState> emit, SavePoiDataEvent event) async {
    emit(UpdatingUserBlocState());
    try{

      var yupcityTraPoi = YupcityTrapPoi(center: event.center, centerDescription: event.centerDescription, lat: event.latitude, lon : event.longuitude);
      await logic?.setPoi(yupcityTraPoi);
      var responseData =  await logic?.getPois();
      emit(PoiDataBlocState(responseData!));
    }on Exception{
      emit(const ErrorUpdatingUserBlocState("Error Get Username"));
    }
  }


  Future<void> getPoiEventHandler(Emitter<DashboardBlocState> emit, GetPoiDataEvent event) async {
    emit(UpdatingUserBlocState());
    try{
      var responseData =  await logic?.getPois();
      emit(PoiDataBlocState(responseData!));
    }on Exception{
      emit(const ErrorUpdatingUserBlocState("Error Get Username"));
    }
  }










 /* Future<void> updatedUserPhotoDataEventHandler(UpdateUserPhotoDataEvent event, Emitter<DashboardBlocState> emit) async {
    var id = GetIt.I.get<LocalStorageService>().getUser()?.sId;
    var file =  await ImagePicker().pickImage(source: event.imageSource, maxWidth: 1024, maxHeight: 1024, imageQuality: 70);
    emit(UpdatingUserBlocState());
    var responseData = await logic?.updateImage(id ?? "",  file?.path ?? "");
    emit(UpdatedUserBlocState(responseData!));
  } */

  final DashboardLogic? logic;

}