import 'package:yupcity_admin/models/user.dart';
import 'package:yupcity_admin/services/http_client.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../Environments.dart';

abstract class UpdateUserLogic {
  Future<YupcityUser> getUser(String id);
  Future<YupcityUser> getUserByUsername(String id);
}

class LoginException implements Exception {}

class DatsmiUpdateUserLogic extends UpdateUserLogic {



  @override
  Future<YupcityUser> getUser(String id) async {
    String baseUrl = Environments().getHost("Production","application");
    var finalUrlGet= baseUrl + "/userById/" + id;
    var responseGet = await GetIt.I.get<HttpClient>().dio.get(finalUrlGet);
    var yupcityUser = YupcityUser.fromJson(responseGet.data);
    return Future.value(yupcityUser);
  }

  @override
  Future<YupcityUser> getUserByUsername(String userName) async {
    String baseUrl = Environments().getHost("Production","application");
    try {
      var cleanUserName = userName.trim();
      var finalUrlGet = baseUrl + "/userByUsername/" + cleanUserName;
      var responseGet = await GetIt.I
          .get<HttpClient>()
          .dio
          .get(finalUrlGet);
      var yupcityUser = YupcityUser.fromJson(responseGet.data);
      return Future.value(yupcityUser);
    }catch(e)
    {

       debugPrint(e.toString());
       return YupcityUser();
    }
  }

}