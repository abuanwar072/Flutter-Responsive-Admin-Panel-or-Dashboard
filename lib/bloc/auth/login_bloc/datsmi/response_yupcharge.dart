import 'package:yupcity_admin/models/user.dart';

class ResponseAuthYupcity {

  String? token;


  ResponseAuthYupcity({this.token});

  ResponseAuthYupcity.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}


