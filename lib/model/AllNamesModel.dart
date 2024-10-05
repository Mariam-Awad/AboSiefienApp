import 'Data.dart';

class AllNamesModel {
  AllNamesModel({
    this.code,
    this.errorMsg,
    this.data,
    this.count,
    this.pageNo,
    this.success,
    this.listData,
  });

  AllNamesModel.fromJson(dynamic json) {
    code = json['code'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    count = json['count'];
    pageNo = json['pageNo'];
    success = json['success'];
    listData = json['listData'];
  }
  String? code;
  dynamic errorMsg;
  List<Data>? data;
  num? count;
  num? pageNo;
  bool? success;
  dynamic listData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['errorMsg'] = errorMsg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    map['pageNo'] = pageNo;
    map['success'] = success;
    map['listData'] = listData;
    return map;
  }
}
