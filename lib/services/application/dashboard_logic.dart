import 'package:yupcity_admin/models/yupcity_trap_poi.dart';
import 'package:yupcity_admin/services/http_client.dart';
import 'package:get_it/get_it.dart';
import '../Environments.dart';

abstract class DashboardLogic {
  Future<List<YupcityTrapPoi>> getPois();
  Future<bool> setPoi(YupcityTrapPoi yupcityTrapPoi);
}

class LoginException implements Exception {}

class YupcityDashboardLogic extends DashboardLogic {

  @override
  Future<List<YupcityTrapPoi>> getPois() async {
    String baseUrl = Environments().getHost("Production","application");
    var finalUrlGet= baseUrl + "/traps/all";
    var responseGet = await GetIt.I.get<HttpClient>().dio.get(finalUrlGet);
    List<YupcityTrapPoi> list = [];
    responseGet.data.forEach((v) {
        list.add(YupcityTrapPoi.fromJson(v));
    });

    return Future.value(list);
  }


  @override
  Future<bool> setPoi(YupcityTrapPoi poi) async {
    String baseUrl = Environments().getHost("Production","application");
    var finalUrlGet= baseUrl + "/traps/create";
    var responseGet = await GetIt.I.get<HttpClient>().dio.post(finalUrlGet, data: poi.toJson());
    return Future.value(true);
  }

}