import 'package:yupcity_admin/bloc/auth/login_bloc/datsmi/reset_password_password.dart';
import 'package:yupcity_admin/bloc/auth/recoverPass_bloc/change_password_request.dart';
import 'package:yupcity_admin/bloc/auth/recoverPass_bloc/recover_otp_request.dart';
import 'package:yupcity_admin/bloc/auth/recoverPass_bloc/recover_request.dart';
import 'package:yupcity_admin/services/http_client.dart';
import 'package:get_it/get_it.dart';

import '../Environments.dart';

abstract class  RecoverPassLogic{
  Future<bool> recoverPass(String email);
  Future<ResetPasswordResponse> validateOtp(String email, int otp);
  Future<ResetPasswordResponse> changePassword(String email, String password);
}
class RecoverPassException implements Exception{}


class DatsmiRecoverPassLogic implements RecoverPassLogic {

  @override
  Future<bool> recoverPass(String email) async {
    String baseUrl = Environments().getHost("Production","application");
    var finalUrl = baseUrl + "/forgotPassword";
    var request =  RequestRecovery(email: email);
    var response = await GetIt.I.get<HttpClient>().dio.post(finalUrl, data: request.toJson());
    //var recoverResponse = RecoverResponse.fromJson(response.data);
   // debugPrint(recoverResponse.message);
    return Future.value(true);
  }

  Future<ResetPasswordResponse> validateOtp(String email, int otp) async{
    String baseUrl = Environments().getHost("Production","application");
    var finalUrl = baseUrl + "/verifyOtp";
    var request =  RequestOtpRecovery(email: email, otp: otp);
    var response = await GetIt.I.get<HttpClient>().dio.post(finalUrl, data: request.toJson());
    var responsePassword = ResetPasswordResponse.fromJson(response.data);
    return Future.value(responsePassword);
  }

  @override
  Future<ResetPasswordResponse> changePassword(String email, String password) async {
    String baseUrl = Environments().getHost("Production","application");
    var finalUrl = baseUrl + "/updatePassword";
    var request =  ChangePasswordRecovery(email: email, password: password);    // TODO: implement changePasswordWithOtp
    var response = await GetIt.I.get<HttpClient>().dio.post(finalUrl, data: request.toJson());
    var responsePassword = ResetPasswordResponse.fromJson(response.data);
    return Future.value(responsePassword);
  }
}