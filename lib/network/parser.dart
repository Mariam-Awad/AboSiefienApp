import 'package:abosiefienapp/model/attendance_model.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/model/makhdom_update_model.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class Parser {
  static parse<T>(dynamic json) {
    printWarning(json);
    switch (T) {
      case UserModel:
        return UserModel.fromJson(json);
      case MyMakhdomsModel:
        return MyMakhdomsModel.fromJson(json);
      case MakhdomUpdateModel:
        return MakhdomUpdateModel.fromJson(json);
      case AttendanceModel:
        return AttendanceModel.fromJson(json);
    }
  }
}
