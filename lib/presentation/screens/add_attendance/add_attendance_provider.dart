import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class AddAttendanceProvider extends ChangeNotifier {
  MyMakhdomsRepo myMakhdomsRepo = MyMakhdomsRepo();
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

  convertToDate() {
    DateTime apiDate = DateTime.now();
    printWarning('apiDate $apiDate');
    absentDate = apiDate.toString();
    notifyListeners();
  }
}
