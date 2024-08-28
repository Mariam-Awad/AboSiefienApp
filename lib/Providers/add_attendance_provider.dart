import 'dart:convert';

import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/core/utils/custom_function.dart';
import 'package:abosiefienapp/repositories/add_class_attendance_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../core/shared_prefrence/app_shared_prefrence.dart';
import '../core/utils/app_debug_prints.dart';

class AddAttendanceProvider extends ChangeNotifier {
  AddClassAttendanceRepo addClassAttendanceRepo = AddClassAttendanceRepo();
  CustomFunctions customFunctions = CustomFunctions();

  String errorMsg = '';

  final GlobalKey<FormState> attendanceformKey = GlobalKey();
  TextEditingController pointsController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String attendanceDate = '';

  List localAttendanceMakhdoms = [];

  String get localAttendanceMakhdomsEncode =>
      jsonEncode(localAttendanceMakhdoms);

  validate(BuildContext context) {
    if (attendanceformKey.currentState!.validate() && attendanceDate != '') {
      printWarning('Code Is: ${int.parse(codeController.text)}');
      addMakhdom(int.parse(codeController.text));
    } else {
      printError('Not Validated');
      customFunctions.showError(
          message: 'برجاء إدخال البيانات المطلوبة', context: context);
    }
  }

  void setSelectedAttendanceDate(String? value) {
    attendanceDate = value!;
    notifyListeners();
  }

  convertToDate() {
    DateTime dayToday = DateTime.now();
    String finalFormatedDate =
        intl.DateFormat('yyyy-MM-dd').format(dayToday).toString();
    printDone('finalFormatedDate $finalFormatedDate');
    attendanceDate = finalFormatedDate;
    notifyListeners();
  }

  addMakhdom(int code) {
    localAttendanceMakhdoms.add(code);
    notifyListeners();
    AppSharedPreferences.setString(
        SharedPreferencesKeys.KEY_LOCAL_ATTENDANCE_MAKHDOM_LIST,
        localAttendanceMakhdomsEncode);
  }

  removeMakhdom(int code) {
    printWarning('IN Removw');
    for (int i = 0; i < localAttendanceMakhdoms.length; i++) {
      if (localAttendanceMakhdoms[i] == code) {
        localAttendanceMakhdoms.remove(localAttendanceMakhdoms[i]);
        notifyListeners();
        AppSharedPreferences.setString(
            SharedPreferencesKeys.KEY_LOCAL_ATTENDANCE_MAKHDOM_LIST,
            localAttendanceMakhdomsEncode);
      }
    }
  }

  removeAllList() {
    localAttendanceMakhdoms = [];
    AppSharedPreferences.remove(
        SharedPreferencesKeys.KEY_LOCAL_ATTENDANCE_MAKHDOM_LIST);

    notifyListeners();
  }

  Future<bool> addAttendance(BuildContext context) async {
    convertToDate();

    customFunctions.showProgress(context);
    Either<Failure, dynamic> response =
        await addClassAttendanceRepo.requestAddAttendance({
      "attendanceDate": attendanceDate,
      "makhdomsId": localAttendanceMakhdoms,
      "points": 0
    });
    printDone('response $response');
    notifyListeners();
    response.fold(
      (Failure l) {
        printError(l.message);
        customFunctions.showError(
            message: 'حدث خطأ ما برجاء المحاولة مرة اخري', context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      },
      (r) {
        if (r != null && r['success'] == true) {
          errorMsg = r["errorMsg"] ?? '';
          customFunctions.showSuccess(message: r['data'], context: context);
          customFunctions.hideProgress();
          notifyListeners();
          return true;
        } else if (r != null && r['success'] == false) {
          customFunctions.showError(
              message: r["errorMsg"].toString(), context: context);
          customFunctions.hideProgress();
          notifyListeners();
          return false;
        }
      },
    );

    customFunctions.hideProgress();
    notifyListeners();
    return false;
  }
}
