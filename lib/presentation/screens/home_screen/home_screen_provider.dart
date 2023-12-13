import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier {
  UserModel? user;
  List<String> permisions = [];
  bool hasGetMakhdomsPermission = false;
  bool hasManageMakhdomsPermission = false;
  bool hasaddclassattendancePermission = false;
  bool hasaaddattendancePermission = false;
  bool hasaaddMakhdomPermission = false;

  void getStoredUser() {
    user = AppCache.instance.getUserModel();
    getPermisions();
    notifyListeners();
  }

  List<String> getPermisions() {
    if (user != null && user!.data != null && user!.data!.permissions != null) {
      for (int i = 0; i < user!.data!.permissions!.length; i++) {
        if (user!.data!.permissions![i].permissionName.toString() ==
            'getmakhdoms') {
          hasGetMakhdomsPermission = true;
          notifyListeners();
        } else if (user!.data!.permissions![i].permissionName.toString() ==
            'manage_makhdom') {
          hasManageMakhdomsPermission = true;
          notifyListeners();
        } else if (user!.data!.permissions![i].permissionName.toString() ==
            'add_classattendance') {
          hasaddclassattendancePermission = true;
          notifyListeners();
        } else if (user!.data!.permissions![i].permissionName.toString() ==
            'add_attendance') {
          hasaaddattendancePermission = true;
          notifyListeners();
        } else if (user!.data!.permissions![i].permissionName.toString() ==
            'add_makhdom') {
          hasaaddMakhdomPermission = true;
          notifyListeners();
        }
        permisions.add(user!.data!.permissions![i].permissionName.toString());
      }
    }
    notifyListeners();
    return permisions;
  }
}
