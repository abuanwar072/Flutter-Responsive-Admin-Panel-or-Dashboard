class YupcityTrapPoi {
  String? sId;
  String? center;
  String? centerDescription;
  double? lat;
  double? lon;
  int? iV;

  YupcityTrapPoi(
      {this.sId,
        this.center,
        this.centerDescription,
        this.lat,
        this.lon,
        this.iV});

  YupcityTrapPoi.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    center = json['center'];
    centerDescription = json['center_description'];
    lat = json['lat'];
    lon = json['lon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['center'] = this.center;
    data['center_description'] = this.centerDescription;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['__v'] = this.iV;
    return data;
  }
}