import 'dart:io';
import 'dart:math';
import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/model/radio_button_model.dart';
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

class MyMakhdomsProvider extends ChangeNotifier {
  MyMakhdomsRepo myMakhdomsRepo = MyMakhdomsRepo();
  CustomFunctions customFunctions = CustomFunctions();

// Sort and Filter
  TextEditingController searchController = TextEditingController();
  List<Data> items = [];
  RadioButtonModel sortValue = RadioButtonModel(1, true);
  int sortCoulmn = 1;
  int sortDirection = 1;
  String absentDate = '';

  int listLength = 0;
  List<Data> allMakhdoms = [];
  String errorMsg = 'حدث خطأ ما برجاء المحاولة مرة اّخرى';

  void setSelectedAbsentDate(String? value) {
    absentDate = value!;
    notifyListeners();
  }

  void clearFilterDate() {
    absentDate = '';
    //sortCoulmn = 1;
    //sortDirection = 1;  
    notifyListeners();
  }

  void setSelectedSortColumn(int? value) {
    sortCoulmn = value!;
    notifyListeners();
  }

  void setSelectedSortDir(int? value) {
    sortDirection = value!;
    notifyListeners();
  }

  Future<bool> myMakhdoms(BuildContext context) async {
    printWarning('sortCoulmn $sortCoulmn');
    printWarning('sortDirection $sortDirection');
    printWarning('absentDate $absentDate');
    try {
      customFunctions.showProgress(context);
      // MyMakhdomsModel? storedmodel = AppCache.instance.getMyMakhdomsModel();
      // if (storedmodel != null && storedmodel.data != null) {
      //   allMakhdoms = storedmodel.data!;
      //   listLength = storedmodel.data!.length;
      //   customFunctions.hideProgress();
      //   notifyListeners();
      //   return true;
      // } else {
      MyMakhdomsModel? responseMyMakhdoms = await myMakhdomsRepo
          .requestMyMakhdoms(sortCoulmn, sortDirection, absentDate);
      printDone('response $responseMyMakhdoms');
      notifyListeners();
      if (responseMyMakhdoms != null &&
          responseMyMakhdoms.data != null &&
          responseMyMakhdoms.success == true) {
        AppCache.instance.setMyMakhdomsModel(responseMyMakhdoms);
        listLength = responseMyMakhdoms.data!.length;
        allMakhdoms = responseMyMakhdoms.data!;
        items = allMakhdoms;
        errorMsg = responseMyMakhdoms.errorMsg!;
        printInfo('SET MYMAKHDOMS IN STORAGE NOW');
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      }
      //  }
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

  void sendWhatsAppMessage({
    required BuildContext context,
    required String phone,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse('')}";
      } else {
        return "https://wa.me/02$phone/?text=";
      }
    }

    if (await canLaunchUrl(Uri.parse(url()))) {
      try {
        launchUrl(Uri.parse(url()));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(
              error.toString(),
              textDirection: TextDirection.rtl,
              style: AppStylesUtil.textRegularStyle(
                  18, Colors.white, FontWeight.w400),
            )));
      }
    }
  }

  int get makhdomsListLength => listLength;

  String? convertToDate(String? datestring) {
    String apiDateString = datestring ?? '';
    DateTime apiDate = DateTime.parse(apiDateString);
    String formattedDate = intl.DateFormat('dd/MM/yyyy').format(apiDate);
    return formattedDate;
  }

  void filterSearchResults(String query) {
    items = allMakhdoms
        .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
