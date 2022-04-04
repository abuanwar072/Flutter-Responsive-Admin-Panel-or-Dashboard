class RequestRegister {

  String? name;
  String? email;
  String? telephone;
  String? password;

  RequestRegister({this.name,this.email,this.telephone,this.password});

  RequestRegister.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['username'];
    telephone = json['telephone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = name;
    data['telephone'] = telephone;
    data['password'] = password;
    return data;
  }
}