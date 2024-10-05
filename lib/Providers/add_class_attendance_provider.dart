import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/core/utils/custom_function.dart';
import 'package:abosiefienapp/model/attendance_settings.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/repositories/add_class_attendance_repo.dart';
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../core/utils/app_debug_prints.dart';

class AddClassAttendanceProvider extends ChangeNotifier {
  MyMakhdomsRepo myMakhdomsRepo = MyMakhdomsRepo();
  AddClassAttendanceRepo addClassAttendanceRepo = AddClassAttendanceRepo();

  CustomFunctions customFunctions = CustomFunctions();

  //Sort and Filter
  TextEditingController searchController = TextEditingController();
  List<Data> items = [];
  int sortCoulmn = 1;
  int sortDirection = 1;
  String absentDate = '';

  int listLength = 0;
  List<Data> allMakhdoms = [];
  String errorMsg = 'حدث خطأ ما برجاء المحاولة مرة اّخرى';
  List<AttendanceSetting> makhdomsAttendance = [];
  List finalList = [];

  Future<bool> myMakhdoms(BuildContext context) async {
    convertToDate();
    printWarning('sortCoulmn $sortCoulmn');
    printWarning('sortDirection $sortDirection');
    printWarning('absentDate $absentDate');

    customFunctions.showProgress(context);
    Either<Failure, MyMakhdomsModel?> responseMyMakhdoms = await myMakhdomsRepo
        .requestMyMakhdoms(sortCoulmn, sortDirection, absentDate);
    printDone('response $responseMyMakhdoms');
    notifyListeners();
    responseMyMakhdoms.fold(
      (Failure l) {
        printError(l.message);
        customFunctions.showError(message: errorMsg, context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      },
      (MyMakhdomsModel? r) {
        listLength = r!.data!.length;
        allMakhdoms = r.data!;
        items = allMakhdoms;
        fillMakhdomsAttendance();
        errorMsg = r.errorMsg!;
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      },
    );

    customFunctions.hideProgress();
    customFunctions.showError(
        message: 'حدث خطأ ما برجاء المحاولة مرة اّخرى', context: context);
    notifyListeners();
    return false;
  }

  fillMakhdomsAttendance() {
    makhdomsAttendance = [];
    notifyListeners();
    for (int i = 0; i < items.length; i++) {
      makhdomsAttendance
          .add(AttendanceSetting(value: false, makhdomId: items[i].id!));
      notifyListeners();
      printWarning('obj in makhdomsAttendance ${makhdomsAttendance[i].value}');
    }
    printError('LENGTH ${items.length}');
    notifyListeners();
  }

  rePareListToSend() {
    for (int i = 0; i < makhdomsAttendance.length; i++) {
      if (makhdomsAttendance[i].value == true) {
        finalList.add(makhdomsAttendance[i].makhdomId);
      }
      notifyListeners();
    }
    printDone('Final List $finalList');
  }

  changeSwitchValue(int index, bool newVal) {
    makhdomsAttendance[index].value = newVal;
    notifyListeners();
  }

  void filterSearchResults(String query) {
    items = allMakhdoms
        .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  convertToDate() {
    DateTime dayToday = DateTime.now();
    String finalFormatedDate =
        intl.DateFormat('yyyy-MM-dd').format(dayToday).toString();
    printDone('finalFormatedDate $finalFormatedDate');
    absentDate = finalFormatedDate;
    notifyListeners();
  }

  clearSearchController() {
    searchController.text = '';
    notifyListeners();
  }

  Future<bool> addAttendance(BuildContext context) async {
    convertToDate();
    rePareListToSend();

    customFunctions.showProgress(context);
    Either<Failure, dynamic> response = await addClassAttendanceRepo
        .requestAddAttendance({
      "attendanceDate": absentDate,
      "makhdomsId": finalList,
      "points": 0
    });
    printDone('response $response');
    response.fold(
      (Failure l) {
        printError(l.message);
        customFunctions.showError(message: errorMsg, context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      },
      (r) {
        errorMsg = r["errorMsg"] ?? '';
        customFunctions.showSuccess(message: r['data'], context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      },
    );

    customFunctions.hideProgress();
    notifyListeners();
    return false;
  }
}
