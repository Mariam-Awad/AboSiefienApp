class AttendanceModel {
  String? code;
  String? errorMsg;
  List<Data>? data;
  int? count;
  int? pageNo;
  bool? success;
  List<String>? listData;

  AttendanceModel({code, errorMsg, data, count, pageNo, success, listData});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    errorMsg = json['errorMsg'] ?? '';
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'] ?? 0;
    pageNo = json['pageNo'] ?? 0;
    success = json['success'] ?? false;
    listData =
        json['listData'] != null ? json['listData'].cast<String>() : [''];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['errorMsg'] = errorMsg;
    if (data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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
  String? phone;
  String? phone2;
  String? birthdate;
  int? addNo;
  String? addStreet;
  int? addFloor;
  String? addBeside;
  String? father;
  String? university;
  String? faculty;
  int? studentYear;
  int? khademId;
  int? groupId;
  String? notes;
  int? levelId;
  int? genderId;
  String? job;
  int? socialId;
  String? lastAttendanceDate;
  String? lastCallDate;

  Data(
      {id,
      name,
      phone,
      phone2,
      birthdate,
      addNo,
      addStreet,
      addFloor,
      addBeside,
      father,
      university,
      faculty,
      studentYear,
      khademId,
      groupId,
      notes,
      levelId,
      genderId,
      job,
      socialId,
      lastAttendanceDate,
      lastCallDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    phone2 = json['phone2'];
    birthdate = json['birthdate'];
    addNo = json['addNo'];
    addStreet = json['addStreet'];
    addFloor = json['addFloor'];
    addBeside = json['addBeside'];
    father = json['father'];
    university = json['university'];
    faculty = json['faculty'];
    studentYear = json['studentYear'];
    khademId = json['khademId'];
    groupId = json['groupId'];
    notes = json['notes'];
    levelId = json['levelId'];
    genderId = json['genderId'];
    job = json['job'];
    socialId = json['socialId'];
    lastAttendanceDate = json['lastAttendanceDate'];
    lastCallDate = json['lastCallDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['phone2'] = phone2;
    data['birthdate'] = birthdate;
    data['addNo'] = addNo;
    data['addStreet'] = addStreet;
    data['addFloor'] = addFloor;
    data['addBeside'] = addBeside;
    data['father'] = father;
    data['university'] = university;
    data['faculty'] = faculty;
    data['studentYear'] = studentYear;
    data['khademId'] = khademId;
    data['groupId'] = groupId;
    data['notes'] = notes;
    data['levelId'] = levelId;
    data['genderId'] = genderId;
    data['job'] = job;
    data['socialId'] = socialId;
    data['lastAttendanceDate'] = lastAttendanceDate;
    data['lastCallDate'] = lastCallDate;
    return data;
  }
}
