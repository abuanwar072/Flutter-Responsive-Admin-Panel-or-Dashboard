class ResetPasswordResponse {
  bool? status;
  String? msg;
  String? originalError;

  ResetPasswordResponse({this.status, this.msg, this.originalError});

  ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    originalError = json['originalError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg;
    data['originalError'] = originalError;
    return data;
  }
}


