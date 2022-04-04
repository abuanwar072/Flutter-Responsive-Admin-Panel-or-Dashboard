import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:yupcity_admin/bloc/auth/recoverPass_bloc/recover_pass_event.dart';
import 'package:yupcity_admin/bloc/auth/recoverPass_bloc/recover_pass_state.dart';
import 'package:yupcity_admin/services/application/recover_pass_logic.dart';
import 'package:flutter/cupertino.dart';

class RecoverPassBloc extends Bloc<RecoverPassEvent, RecoverPassState> {
  final RecoverPassLogic? logic;

  RecoverPassBloc({@required this.logic}) : super(InitialRecoverPassState());

  @override
  RecoverPassState get initialState => InitialRecoverPassState();

  @override
  Stream<RecoverPassState> mapEventToState(
    RecoverPassEvent event,
  ) async* {
      if( event is DoRecoverPassEvent){
        try{
          yield RecoveringPassInBlocState(event.email);
          var responseData = await logic?.recoverPass(event.email);
          yield RecoveredPassInBlocState(true);
        }catch(e){
          print(e);
          yield ErrorRecoverPassBlocState("Error recovering password");
        }
      }
  }
}
