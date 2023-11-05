class MakhdomUpdateModel {
  String? code;
  String? errorMsg;
  Data? data;
  int? count;
  int? pageNo;
  bool? success;
  List<String>? listData;

  MakhdomUpdateModel({code, errorMsg, data, count, pageNo, success, listData});

  MakhdomUpdateModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    errorMsg = json['errorMsg'] ?? '';
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    count = json['count'] ?? 0;
    pageNo = json['pageNo'] ?? 0;
    success = json['success'] ?? false;
    listData =
        json['listData'] != null ? json['listData'].cast<String>() : [''];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['errorMsg'] = errorMsg;
    if (data != null) {
      data['data'] = this.data!.toJson();
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
  String? adress;
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
  int? oldId;
  int? genderId;
  String? job;
  int? socialId;
  List<Attendances>? attendances;
  Gender? gender;
  Group? group;
  Khadems? khadem;
  Gender? social;
  List<UserPoints>? userPoints;

  Data(
      {id,
      name,
      phone,
      phone2,
      adress,
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
      oldId,
      genderId,
      job,
      socialId,
      attendances,
      gender,
      group,
      khadem,
      social,
      userPoints});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    phone2 = json['phone2'];
    adress = json['adress'];
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
    oldId = json['oldId'];
    genderId = json['genderId'];
    job = json['job'];
    socialId = json['socialId'];
    if (json['attendances'] != null) {
      attendances = <Attendances>[];
      json['attendances'].forEach((v) {
        attendances!.add(Attendances.fromJson(v));
      });
    }
    gender = json['gender'] != null ? Gender.fromJson(json['gender']) : null;
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    khadem = json['khadem'] != null ? Khadems.fromJson(json['khadem']) : null;
    social = json['social'] != null ? Gender.fromJson(json['social']) : null;
    if (json['userPoints'] != null) {
      userPoints = <UserPoints>[];
      json['userPoints'].forEach((v) {
        userPoints!.add(UserPoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['phone2'] = phone2;
    data['adress'] = adress;
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
    data['oldId'] = oldId;
    data['genderId'] = genderId;
    data['job'] = job;
    data['socialId'] = socialId;
    if (attendances != null) {
      data['attendances'] = attendances!.map((v) => v.toJson()).toList();
    }
    if (gender != null) {
      data['gender'] = gender!.toJson();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (khadem != null) {
      data['khadem'] = khadem!.toJson();
    }
    if (social != null) {
      data['social'] = social!.toJson();
    }
    if (userPoints != null) {
      data['userPoints'] = userPoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendances {
  int? attId;
  int? makhdomeId;
  String? date;
  Time? time;
  String? makhdome;

  Attendances({attId, makhdomeId, date, time, makhdome});

  Attendances.fromJson(Map<String, dynamic> json) {
    attId = json['attId'];
    makhdomeId = json['makhdomeId'];
    date = json['date'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    makhdome = json['makhdome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['attId'] = attId;
    data['makhdomeId'] = makhdomeId;
    data['date'] = date;
    if (time != null) {
      data['time'] = time!.toJson();
    }
    data['makhdome'] = makhdome;
    return data;
  }
}

class Time {
  int? ticks;
  int? days;
  int? hours;
  int? milliseconds;
  int? microseconds;
  int? nanoseconds;
  int? minutes;
  int? seconds;
  int? totalDays;
  int? totalHours;
  int? totalMilliseconds;
  int? totalMicroseconds;
  int? totalNanoseconds;
  int? totalMinutes;
  int? totalSeconds;

  Time(
      {ticks,
      days,
      hours,
      milliseconds,
      microseconds,
      nanoseconds,
      minutes,
      seconds,
      totalDays,
      totalHours,
      totalMilliseconds,
      totalMicroseconds,
      totalNanoseconds,
      totalMinutes,
      totalSeconds});

  Time.fromJson(Map<String, dynamic> json) {
    ticks = json['ticks'];
    days = json['days'];
    hours = json['hours'];
    milliseconds = json['milliseconds'];
    microseconds = json['microseconds'];
    nanoseconds = json['nanoseconds'];
    minutes = json['minutes'];
    seconds = json['seconds'];
    totalDays = json['totalDays'];
    totalHours = json['totalHours'];
    totalMilliseconds = json['totalMilliseconds'];
    totalMicroseconds = json['totalMicroseconds'];
    totalNanoseconds = json['totalNanoseconds'];
    totalMinutes = json['totalMinutes'];
    totalSeconds = json['totalSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ticks'] = ticks;
    data['days'] = days;
    data['hours'] = hours;
    data['milliseconds'] = milliseconds;
    data['microseconds'] = microseconds;
    data['nanoseconds'] = nanoseconds;
    data['minutes'] = minutes;
    data['seconds'] = seconds;
    data['totalDays'] = totalDays;
    data['totalHours'] = totalHours;
    data['totalMilliseconds'] = totalMilliseconds;
    data['totalMicroseconds'] = totalMicroseconds;
    data['totalNanoseconds'] = totalNanoseconds;
    data['totalMinutes'] = totalMinutes;
    data['totalSeconds'] = totalSeconds;
    return data;
  }
}

class Gender {
  int? id;
  String? name;
  List<String>? makhdoms;

  Gender({id, name, makhdoms});

  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    makhdoms = json['makhdoms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['makhdoms'] = makhdoms;
    return data;
  }
}

class Group {
  int? groupId;
  String? groupName;
  List<Khadems>? khadems;
  List<String>? makhdoms;

  Group({groupId, groupName, khadems, makhdoms});

  Group.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    groupName = json['groupName'];
    if (json['khadems'] != null) {
      khadems = <Khadems>[];
      json['khadems'].forEach((v) {
        khadems!.add(Khadems.fromJson(v));
      });
    }
    makhdoms = json['makhdoms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    if (khadems != null) {
      data['khadems'] = khadems!.map((v) => v.toJson()).toList();
    }
    data['makhdoms'] = makhdoms;
    return data;
  }
}

class Khadems {
  int? id;
  String? name;
  String? phone1;
  String? phone2;
  String? adress;
  String? image;
  int? groupId;
  String? birthDate;
  int? levelId;
  List<Eftkads>? eftkads;
  String? group;
  List<String>? makhdoms;
  List<Users>? users;

  Khadems(
      {id,
      name,
      phone1,
      phone2,
      adress,
      image,
      groupId,
      birthDate,
      levelId,
      eftkads,
      group,
      makhdoms,
      users});

  Khadems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    adress = json['adress'];
    image = json['image'];
    groupId = json['groupId'];
    birthDate = json['birthDate'];
    levelId = json['levelId'];
    if (json['eftkads'] != null) {
      eftkads = <Eftkads>[];
      json['eftkads'].forEach((v) {
        eftkads!.add(Eftkads.fromJson(v));
      });
    }
    group = json['group'];
    makhdoms = json['makhdoms'].cast<String>();
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['phone1'] = phone1;
    data['phone2'] = phone2;
    data['adress'] = adress;
    data['image'] = image;
    data['groupId'] = groupId;
    data['birthDate'] = birthDate;
    data['levelId'] = levelId;
    if (eftkads != null) {
      data['eftkads'] = eftkads!.map((v) => v.toJson()).toList();
    }
    data['group'] = group;
    data['makhdoms'] = makhdoms;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Eftkads {
  int? id;
  String? eftkadDate;
  int? makhdomId;
  int? khademId;
  int? eftkadStatues;
  EftkadStatuesNavigation? eftkadStatuesNavigation;
  String? khadem;

  Eftkads(
      {id,
      eftkadDate,
      makhdomId,
      khademId,
      eftkadStatues,
      eftkadStatuesNavigation,
      khadem});

  Eftkads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eftkadDate = json['eftkadDate'];
    makhdomId = json['makhdomId'];
    khademId = json['khademId'];
    eftkadStatues = json['eftkadStatues'];
    eftkadStatuesNavigation = json['eftkadStatuesNavigation'] != null
        ? EftkadStatuesNavigation.fromJson(json['eftkadStatuesNavigation'])
        : null;
    khadem = json['khadem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['eftkadDate'] = eftkadDate;
    data['makhdomId'] = makhdomId;
    data['khademId'] = khademId;
    data['eftkadStatues'] = eftkadStatues;
    if (eftkadStatuesNavigation != null) {
      data['eftkadStatuesNavigation'] = eftkadStatuesNavigation!.toJson();
    }
    data['khadem'] = khadem;
    return data;
  }
}

class EftkadStatuesNavigation {
  int? id;
  String? code;
  String? value;
  List<String>? eftkads;

  EftkadStatuesNavigation({id, code, value, eftkads});

  EftkadStatuesNavigation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    eftkads = json['eftkads'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['value'] = value;
    data['eftkads'] = eftkads;
    return data;
  }
}

class Users {
  int? userId;
  int? khademId;
  String? userName;
  String? password;
  String? userRole;
  bool? isActive;
  int? roleId;
  int? levelId;
  String? khadem;
  Level? level;
  Role? role;

  Users(
      {userId,
      khademId,
      userName,
      password,
      userRole,
      isActive,
      roleId,
      levelId,
      khadem,
      level,
      role});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    khademId = json['khademId'];
    userName = json['userName'];
    password = json['password'];
    userRole = json['userRole'];
    isActive = json['isActive'];
    roleId = json['roleId'];
    levelId = json['levelId'];
    khadem = json['khadem'];
    level = json['level'] != null ? Level.fromJson(json['level']) : null;
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['khademId'] = khademId;
    data['userName'] = userName;
    data['password'] = password;
    data['userRole'] = userRole;
    data['isActive'] = isActive;
    data['roleId'] = roleId;
    data['levelId'] = levelId;
    data['khadem'] = khadem;
    if (level != null) {
      data['level'] = level!.toJson();
    }
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Level {
  int? id;
  String? levelName;
  List<String>? users;

  Level({id, levelName, users});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levelName = json['levelName'];
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['levelName'] = levelName;
    data['users'] = users;
    return data;
  }
}

class Role {
  int? id;
  String? roleName;
  List<RolePermissions>? rolePermissions;
  List<String>? users;

  Role({id, roleName, rolePermissions, users});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['roleName'];
    if (json['rolePermissions'] != null) {
      rolePermissions = <RolePermissions>[];
      json['rolePermissions'].forEach((v) {
        rolePermissions!.add(RolePermissions.fromJson(v));
      });
    }
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['roleName'] = roleName;
    if (rolePermissions != null) {
      data['rolePermissions'] =
          rolePermissions!.map((v) => v.toJson()).toList();
    }
    data['users'] = users;
    return data;
  }
}

class RolePermissions {
  int? id;
  int? roleId;
  int? permissionId;
  Permission? permission;
  String? role;

  RolePermissions({id, roleId, permissionId, permission, role});

  RolePermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['roleId'];
    permissionId = json['permissionId'];
    permission = json['permission'] != null
        ? Permission.fromJson(json['permission'])
        : null;
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['roleId'] = roleId;
    data['permissionId'] = permissionId;
    if (permission != null) {
      data['permission'] = permission!.toJson();
    }
    data['role'] = role;
    return data;
  }
}

class Permission {
  int? id;
  String? permissionName;
  String? permissionCategory;
  List<String>? rolePermissions;

  Permission({id, permissionName, permissionCategory, rolePermissions});

  Permission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    permissionName = json['permissionName'];
    permissionCategory = json['permissionCategory'];
    rolePermissions = json['rolePermissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['permissionName'] = permissionName;
    data['permissionCategory'] = permissionCategory;
    data['rolePermissions'] = rolePermissions;
    return data;
  }
}

class UserPoints {
  int? id;
  int? makhdomId;
  int? levelId;
  int? points;
  String? creationData;
  String? updatedDate;
  String? makhdom;

  UserPoints(
      {id, makhdomId, levelId, points, creationData, updatedDate, makhdom});

  UserPoints.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    makhdomId = json['makhdomId'];
    levelId = json['levelId'];
    points = json['points'];
    creationData = json['creationData'];
    updatedDate = json['updatedDate'];
    makhdom = json['makhdom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['makhdomId'] = makhdomId;
    data['levelId'] = levelId;
    data['points'] = points;
    data['creationData'] = creationData;
    data['updatedDate'] = updatedDate;
    data['makhdom'] = makhdom;
    return data;
  }
}
