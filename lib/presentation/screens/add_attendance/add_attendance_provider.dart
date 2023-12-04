import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/attendance_settings.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/repositories/add_attendance_repo.dart';
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AddAttendanceProvider extends ChangeNotifier {
  MyMakhdomsRepo myMakhdomsRepo = MyMakhdomsRepo();
  AddAttendanceRepo addAttendanceRepo = AddAttendanceRepo();

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
    try {
      customFunctions.showProgress(context);
      MyMakhdomsModel? responseMyMakhdoms = await myMakhdomsRepo
          .requestMyMakhdoms(sortCoulmn, sortDirection, absentDate);
      printDone('response $responseMyMakhdoms');
      notifyListeners();
      if (responseMyMakhdoms != null &&
          responseMyMakhdoms.data != null &&
          responseMyMakhdoms.success == true) {
        listLength = responseMyMakhdoms.data!.length;
        allMakhdoms = responseMyMakhdoms.data!;
        items = allMakhdoms;
        fillMakhdomsAttendance();
        errorMsg = responseMyMakhdoms.errorMsg!;
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      }
    } catch (error) {
      printError(error);
      customFunctions.showError(message: errorMsg, context: context);
      customFunctions.hideProgress();
      notifyListeners();
      return false;
    }
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
    try {
      customFunctions.showProgress(context);
      var response = await addAttendanceRepo.requestAddAttendance(
          {"attendanceDate": absentDate, "makhdomsId": finalList, "points": 0});
      printDone('response $response');
      notifyListeners();
      if (response != null && response['success'] == true) {
        errorMsg = response["errorMsg"] ?? '';
        customFunctions.showSuccess(
            message: response['data'], context: context);
        customFunctions.hideProgress();
        // makhdomsAttendance = [];
        notifyListeners();
        return true;
      }
    } catch (error) {
      printError(error);
      customFunctions.showError(message: errorMsg, context: context);
      customFunctions.hideProgress();
      notifyListeners();
      return false;
    }
    customFunctions.hideProgress();
    notifyListeners();
    return false;
  }
}
