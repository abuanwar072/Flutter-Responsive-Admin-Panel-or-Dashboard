class RequestOtpRecovery {
  String? email;

  int? otp;

  String? password;

  RequestOtpRecovery({this.email,this.otp,this.password});

  RequestOtpRecovery.fromJson(Map<String, dynamic> json) {
    otp = json['OTP'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['OTP'] = otp;
    return data;
  }
}