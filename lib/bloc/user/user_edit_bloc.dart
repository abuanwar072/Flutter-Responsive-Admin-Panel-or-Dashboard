
import 'package:yupcity_admin/services/application/update_user_logic.dart';
import 'package:yupcity_admin/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'user_edit_bloc_event.dart';
import 'user_edit_bloc_state.dart';

class UserEditBloc extends Bloc<UserEditBlocEvent, UserEditBlocState> {
  UserEditBloc({@required this.logic}) : super(InitialUserEditBlocState()) {

    on<GetUserByUsernameDataEvent>((event, emit) async {
      await getUserByUsernameEventHandler(emit, event);
    });

    on<GetUserDataEvent>((event, emit) async {
      await getUserEventHandler(emit);
    });

  }


  Future<void> getUserByUsernameEventHandler(Emitter<UserEditBlocState> emit, GetUserByUsernameDataEvent event) async {
    emit(UpdatingUserBlocState());
    try{
      var responseData =  await logic?.getUserByUsername(event.userName);
      emit(UpdatedUserBlocState(responseData!));
    }on Exception{
      emit(const ErrorUpdatingUserBlocState("Error Get Username"));
    }
  }

  Future<void> getUserEventHandler(Emitter<UserEditBlocState> emit) async {
      emit(UpdatingUserBlocState());
    try{
      var id = GetIt.I.get<LocalStorageService>().getUser()?.sId;
      var responseData =  await logic?.getUser(id!);
      emit(UpdatedUserBlocState(responseData!));
    }on Exception{
      emit(const ErrorUpdatingUserBlocState("Error ValidateNFCIdEvent"));
    }
  }


  final UpdateUserLogic? logic;

}