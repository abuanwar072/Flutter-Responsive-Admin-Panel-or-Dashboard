class RequestLogin {
  String? email;
  String? password;

  RequestLogin({this.email, this.password});

  RequestLogin.fromJson(Map<String, dynamic> json) {
    email = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.email;
    data['password'] = this.password;
    return data;
  }
}