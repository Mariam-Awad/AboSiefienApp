import 'dart:convert';

import 'package:abosiefienapp/model/user_model.dart';
import 'package:flutter/material.dart';

import '../core/shared_prefrence/app_shared_prefrence.dart';
import '../core/utils/app_debug_prints.dart';

class HomeScreenProvider extends ChangeNotifier {
  UserModel? user;
  List<String> permisions = [];
  bool hasGetMakhdomsPermission = false;
  bool hasManageMakhdomsPermission = false;
  bool hasaddclassattendancePermission = false;
  bool hasaaddattendancePermission = false;
  bool hasaaddMakhdomPermission = false;

  void getStoredUser(BuildContext context) async {
    final userJson =
        AppSharedPreferences.getString(SharedPreferencesKeys.userModel);

    if (userJson != null && userJson.isNotEmpty) {
      try {
        final userMap = jsonDecode(userJson);

        if (userMap is Map<String, dynamic>) {
          user = UserModel.fromJson(userMap);
          print('user data for ${user?.data?.levelId}');

          getPermisions();
        } else {
          printError('Retrieved data is not a valid JSON object.');
        }

        notifyListeners();
      } catch (e) {
        printError('Failed to parse user data: $e');
      }
    } else {
      printWarning('No user data found in SharedPreferences.');
    }
  }

  List<String> getPermisions() {
    if (user != null && user!.data != null && user!.data!.permissions != null) {
      for (int i = 0; i < user!.data!.permissions!.length; i++) {
        String permissionName =
            user!.data!.permissions![i].permissionName.toString();

        if (permissionName == 'getmakhdoms') {
          hasGetMakhdomsPermission = true;
        } else if (permissionName == 'manage_makhdom') {
          hasManageMakhdomsPermission = true;
        } else if (permissionName == 'add_classattendance') {
          hasaddclassattendancePermission = true;
        } else if (permissionName == 'add_attendance') {
          hasaaddattendancePermission = true;
        } else if (permissionName == 'add_makhdom') {
          hasaaddMakhdomPermission = true;
        }

        permisions.add(permissionName);
      }
    }
    notifyListeners();
    return permisions;
  }
}
