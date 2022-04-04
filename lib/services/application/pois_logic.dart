import 'package:yupcity_admin/services/http_client.dart';
import 'package:get_it/get_it.dart';
import '../Environments.dart';

abstract class PoisLogic {
  Future<String> getPois();
}

class RegisterException implements Exception {}


class YupchargePoisLogic extends PoisLogic {
  @override
  Future<String> getPois() async {
    String baseUrl = Environments().getHost("Production", "application");
    var finalUrl = baseUrl + "/traps";
    var response = await GetIt.I
        .get<HttpClient>()
        .dio
        .get(finalUrl);

    return Future.value("");
  }
}
