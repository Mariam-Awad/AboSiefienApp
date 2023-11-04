import 'dart:io';

import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_styles_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMakhdomsProvider extends ChangeNotifier {
  MyMakhdomsRepo myMakhdomsRepo = MyMakhdomsRepo();
  CustomFunctions customFunctions = CustomFunctions();
  int pageSize = 20;
  int pageNo = 1;
  int listLength = 0;
  List<Data> allMakhdoms = [];
  String errorMsg = 'حدث خطأ ما برجاء المحاولة مرة اّخرى';

  Future<bool> myMakhdoms(BuildContext context) async {
    printWarning('pageSize $pageSize');
    printWarning('pageNo $pageNo');
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
      MyMakhdomsModel? responseMyMakhdoms =
          await myMakhdomsRepo.requestMyMakhdoms(pageSize, pageNo);
      printDone('response $responseMyMakhdoms');
      notifyListeners();
      if (responseMyMakhdoms != null &&
          responseMyMakhdoms.data != null &&
          responseMyMakhdoms.success == true) {
        AppCache.instance.setMyMakhdomsModel(responseMyMakhdoms);
        listLength = responseMyMakhdoms.data!.length;
        allMakhdoms = responseMyMakhdoms.data!;
        errorMsg = responseMyMakhdoms.errorMsg!;
        printInfo('SET MYMAKHDOMS IN STORAGE NOW');
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      }
      //  }
    } catch (error) {
      printError(error);
      customFunctions.showError(message: errorMsg);
      customFunctions.hideProgress();
      notifyListeners();
      return false;
    }
    customFunctions.hideProgress();
    customFunctions.showError(message: 'حدث خطأ ما برجاء المحاولة مرة اّخرى');
    notifyListeners();
    return false;
  }



  void sendWhatsAppMessage({
    required BuildContext context,
    required String phone,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/+20$phone/?text=${Uri.parse('')}";
      } else {
        return "whatsapp://send?phone=+20$phone&text=";
      }
    }

    await canLaunch(url())
        ? launch(url())
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'عذراً لايوجد واتساب على جهازك!',
              textDirection: TextDirection.rtl,
              style: AppStylesUtil.textRegularStyle(
                  18, Colors.white, FontWeight.w400),
            )));
  }

  int get makhdomsListLength => listLength;
}
