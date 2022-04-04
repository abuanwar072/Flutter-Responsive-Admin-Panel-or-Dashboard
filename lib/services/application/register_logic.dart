import 'package:yupcity_admin/bloc/auth/recoverPass_bloc/register_request.dart';
import 'package:yupcity_admin/services/http_client.dart';
import 'package:get_it/get_it.dart';

import '../Environments.dart';
import '../local_storage_service.dart';

abstract class RegisterLogic {
  Future<String> register(String name, String email, String telephone, String password);
}

class RegisterException implements Exception {}


class YupchargeRegisterLogic extends RegisterLogic {
  @override
  Future<String> register(
      String name,  String email, String telephone, String password) async {
    String baseUrl = Environments().getHost("Production", "application");
    var finalUrl = baseUrl + "/users/create";
    var request = RequestRegister(name: name, email: email, telephone: telephone, password: password);
    var response = await GetIt.I
        .get<HttpClient>()
        .dio
        .post(finalUrl, data: request.toJson());

    var localStorage = GetIt.I.get<LocalStorageService>();
    localStorage.setCurrentPassword(password);
    localStorage.setCurrentEmail(email);
    localStorage.setToken("");
    return Future.value("");
  }
}
