import 'dart:io';
import 'package:yupcity_admin/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AuthInterceptor extends Interceptor {

  var localStorage = GetIt.I.get<LocalStorageService>();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
    if (options.method == "POST" && options.path == "/users") {
      return;
    }

    if (options.method == "POST" && options.path.endsWith("/api-token-auth")) {
      return;
    }

    //TODO: Put the paths you want the interceptor to ignore
    if (!options.path.contains("/login")) {
      var token = localStorage.getToken();
      if (localStorage.getApp() == "stockagile") {
        options.headers[HttpHeaders.authorizationHeader] = "Token ${token}";
      }
      else {
        options.headers[HttpHeaders.authorizationHeader] = "Bearer ${token}";
        // options.headers[HttpHeaders.authorizationHeader] = "Bearer ${user.token}";
      }
    }

    return;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }

  /* @override
  onRequest(RequestOptions options) async {
    if (options.method == "POST" && options.path == "/users") {
      return options;
    }
    
    if (options.method == "POST" && options.path.endsWith("/api-token-auth")) {
        return options;
    }

    //TODO: Put the paths you want the interceptor to ignore
    if (!options.path.contains("/login")) {
      var localStorage = GetIt.I.get<LocalStorageService>();
      var token = localStorage.getToken();
      if (localStorage.getApp() == "stockagile") {
        options.headers[HttpHeaders.authorizationHeader] = "Token ${token}";
      }
      else {
        options.headers[HttpHeaders.authorizationHeader] = "Bearer ${token}";
        // options.headers[HttpHeaders.authorizationHeader] = "Bearer ${user.token}";
      }
    }

    return options;
  } */
}
