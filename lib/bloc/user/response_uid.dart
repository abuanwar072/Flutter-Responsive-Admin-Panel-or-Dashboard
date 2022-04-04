class ResponseUidData {
  bool? status;
  String? msg;
  List<UID_SID>? data;

  ResponseUidData({this.status, this.msg, this.data});

  ResponseUidData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <UID_SID>[];
      json['data'].forEach((v) {
        data!.add(new UID_SID.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UID_SID {
  bool? isActive;
  String? sId;
  String? uid;

  UID_SID({this.isActive, this.sId, this.uid});

  UID_SID.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    sId = json['_id'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    return data;
  }
}
