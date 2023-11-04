import 'package:abosiefienapp/model/makhdom_update_model.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart' as mymakhdomsmodel;
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:abosiefienapp/repositories/update_makhdom_repo.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:flutter/material.dart';
import 'package:abosiefienapp/shared/custom_function.dart';

class MakhdomDetailsProvider extends ChangeNotifier {
  mymakhdomsmodel.Data? recievedMakhdom;
  MyMakhdomsRepo myMakhdomsRepo = MyMakhdomsRepo();
  CustomFunctions customFunctions = CustomFunctions();
  UpdateMakhdomRepo updateMakhdomRepo = UpdateMakhdomRepo();

  void setRecievedMakhdom(mymakhdomsmodel.Data? makhdom) {
    recievedMakhdom = makhdom ?? mymakhdomsmodel.Data();
    // notifyListeners();
    printError('recievedMakhdom $recievedMakhdom');
  }

  Future<bool> updateMyMakhdom(BuildContext context, mymakhdomsmodel.Data data) async {
    printWarning('data $data');
    try {
      customFunctions.showProgress(context);
      MakhdomUpdateModel? responseUpdateMyMakhdom =
          await updateMakhdomRepo.requestUpdateMakhdom(data);
      printDone('response $responseUpdateMyMakhdom');
      notifyListeners();
      if (responseUpdateMyMakhdom != null &&
          responseUpdateMyMakhdom.success == true) {
        printInfo('Updated Now');
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      }
      //  }
    } catch (error) {
      printError(error);
      customFunctions.showError(message: 'لم يتم حفظ التعديلات');
      customFunctions.hideProgress();
      notifyListeners();
      return false;
    }
    customFunctions.hideProgress();
    customFunctions.showError(message: 'حدث خطأ ما برجاء المحاولة مرة اّخرى');
    notifyListeners();
    return false;
  }
}
