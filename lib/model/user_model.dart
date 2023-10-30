class UserModel {
  String? code;
  String? errorMsg;
  Data? data;
  int? count;
  int? pageNo;
  bool? success;
  List<String>? listData;

  UserModel(
      {this.code,
      this.errorMsg,
      this.data,
      this.count,
      this.pageNo,
      this.success,
      this.listData});

  UserModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    errorMsg = json['errorMsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    count = json['count'];
    pageNo = json['pageNo'];
    success = json['success'];
    listData = json['listData'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['errorMsg'] = this.errorMsg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['count'] = this.count;
    data['pageNo'] = this.pageNo;
    data['success'] = this.success;
    data['listData'] = this.listData;
    return data;
  }
}

class Data {
  int? userId;
  int? khademId;
  String? userName;
  bool? isActive;
  int? roleId;
  String? roleName;
  String? token;
  int? levelId;
  List<Permissions>? permissions;

  Data(
      {this.userId,
      this.khademId,
      this.userName,
      this.isActive,
      this.roleId,
      this.roleName,
      this.token,
      this.levelId,
      this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    khademId = json['khademId'];
    userName = json['userName'];
    isActive = json['isActive'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    token = json['token'];
    levelId = json['levelId'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['khademId'] = this.khademId;
    data['userName'] = this.userName;
    data['isActive'] = this.isActive;
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    data['token'] = this.token;
    data['levelId'] = this.levelId;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  String? permissionName;

  Permissions({this.permissionName});

  Permissions.fromJson(Map<String, dynamic> json) {
    permissionName = json['permissionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['permissionName'] = this.permissionName;
    return data;
  }
}
