// ! THIS EXCEPTION OCCURS WHEN THE SERVER IS DOWN AND STATUS CODE IS 500
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}
