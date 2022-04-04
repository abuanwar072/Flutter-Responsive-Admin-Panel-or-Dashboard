class YupcityUser {
  String? sId;
  String? username;
  String? email;
  String? telephone;
  String? password;
  int? iV;

  YupcityUser(
      {this.sId,
        this.username,
        this.email,
        this.telephone,
        this.password,
        this.iV});

  YupcityUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    telephone = json['telephone'];
    password = json['password'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['password'] = this.password;
    data['__v'] = this.iV;
    return data;
  }
}