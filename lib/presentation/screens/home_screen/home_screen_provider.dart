import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier {
  UserModel? user;
  List<String> permisions = [];
  bool hasGetMakhdomsPermission = false;
  bool hasManageMakhdomsPermission = false;

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
            'managemakhdoms') {
          hasManageMakhdomsPermission = true;
          notifyListeners();
        }
        permisions.add(user!.data!.permissions![i].permissionName.toString());
      }
    }
    notifyListeners();
    return permisions;
  }
}
