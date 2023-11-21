class KhademModel {
  List<Data>? data;
  String? code;
  Null? errorMsg;
  int? count;
  int? pageNo;
  bool? success;
  Null? listData;

  KhademModel({data, code, errorMsg, count, pageNo, success, listData});

  KhademModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
    errorMsg = json['errorMsg'];
    count = json['count'];
    pageNo = json['pageNo'];
    success = json['success'];
    listData = json['listData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['errorMsg'] = errorMsg;
    data['count'] = count;
    data['pageNo'] = pageNo;
    data['success'] = success;
    data['listData'] = listData;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? phone1;
  String? birthDate;
  int? levelId;
  int? makhdomsCount;

  Data({id, name, phone1, birthDate, levelId, makhdomsCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone1 = json['phone1'];
    birthDate = json['birthDate'];
    levelId = json['levelId'];
    makhdomsCount = json['makhdomsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone1'] = phone1;
    data['birthDate'] = birthDate;
    data['levelId'] = levelId;
    data['makhdomsCount'] = makhdomsCount;
    return data;
  }
}
