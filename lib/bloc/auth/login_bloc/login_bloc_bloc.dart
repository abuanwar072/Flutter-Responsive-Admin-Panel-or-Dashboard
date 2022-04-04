import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:yupcity_admin/services/application/login_logic.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'login_bloc_event.dart';
import 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc({@required this.logic}) : super(InitialLoginBlocState()) {}

  final LoginLogic? logic;

  @override
  LoginBlocState get initialState => InitialLoginBlocState();

  @override
  Stream<LoginBlocState> mapEventToState(
    LoginBlocEvent event,
  ) async* {
    if(event is DoLoginEvent){
        yield LogginInBlocState();
        try{
        var responseData =  await logic?.login(event.email, event.password);
          yield LoggedInBlocState(true);
        }on Exception{
          yield ErrorBlocState("Error login to the system. User or password incorrect.");
        }
    }
  }
}
