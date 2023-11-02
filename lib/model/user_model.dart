class UserModel {
  Data? data;
  String? code;
  String? errorMsg;
  int? count;
  int? pageNo;
  bool? success;
  List<String>? listData;

  UserModel(
      {this.data,
      this.code,
      this.errorMsg,
      this.count,
      this.pageNo,
      this.success,
      this.listData});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'] ?? '';
    errorMsg = json['errorMsg'] ?? '';
    count = json['count'] ?? 0;
    pageNo = json['pageNo'] ?? 0;
    success = json['success'] ?? false;
    listData =
        json['listData'] != null ? json['listData'].cast<String>() : [''];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
    userId = json['userId'] ?? 0;
    khademId = json['khademId'] ?? 0;
    userName = json['userName'] ?? '';
    isActive = json['isActive'] ?? false;
    roleId = json['roleId'] ?? 0;
    roleName = json['roleName'] ?? '';
    token = json['token'] ?? '';
    levelId = json['levelId'] ?? 0;
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] =  userId;
    data['khademId'] = khademId;
    data['userName'] = userName;
    data['isActive'] = isActive;
    data['roleId'] = roleId;
    data['roleName'] = roleName;
    data['token'] = token;
    data['levelId'] = levelId;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  String? permissionName;

  Permissions({this.permissionName});

  Permissions.fromJson(Map<String, dynamic> json) {
    permissionName = json['permissionName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['permissionName'] = this.permissionName;
    return data;
  }
}
