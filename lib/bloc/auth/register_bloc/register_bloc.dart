import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:yupcity_admin/bloc/auth/register_bloc/register_event.dart';
import 'package:yupcity_admin/bloc/auth/register_bloc/register_state.dart';
import 'package:yupcity_admin/services/application/register_logic.dart';
import 'package:flutter/cupertino.dart';




class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final RegisterLogic? logic;
 RegisterBloc ({@required this.logic}) : super(InitialRegisterState()) {

 }
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is DoRegisterEvent){
      yield RegisterinInBlocState();
      try{
        var doneRegister =  await logic?.register(event.name,event.email,event.telephone, event.password);
        yield RegisteredInBlocState(true);
      }on RegisterException{
        yield ErrorRegisterBlocState("Fallo en el registro");

      }
    }
  }
}
