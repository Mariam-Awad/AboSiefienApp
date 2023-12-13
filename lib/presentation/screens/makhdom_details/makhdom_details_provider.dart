import 'package:abosiefienapp/model/makhdom_update_model.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart' as mymakhdomsmodel;
import 'package:abosiefienapp/model/radio_button_model.dart';
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:abosiefienapp/repositories/update_makhdom_repo.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:abosiefienapp/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:intl/intl.dart' as intl;

class MakhdomDetailsProvider extends ChangeNotifier {
  mymakhdomsmodel.Data? recievedMakhdom;
  MyMakhdomsRepo myMakhdomsRepo = MyMakhdomsRepo();
  CustomFunctions customFunctions = CustomFunctions();
  UpdateMakhdomRepo updateMakhdomRepo = UpdateMakhdomRepo();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController addressNumberController = TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController studentYearController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  RadioButtonModel genderValue = RadioButtonModel(1, true);

  void setRecievedMakhdom(mymakhdomsmodel.Data? makhdom) {
    recievedMakhdom = makhdom ?? mymakhdomsmodel.Data();
    // notifyListeners();
    printError('recievedMakhdom $recievedMakhdom');
  }

  Future<bool> updateMyMakhdom(
      BuildContext context, mymakhdomsmodel.Data data) async {
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
        customFunctions.showSuccess(
            message: 'تم التعديل بنجاح', context: context);
        Navigator.pushNamed(context, AppRoutes.myMakhdomsRouteName);
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      }
      //  }
    } catch (error) {
      printError(error);
      customFunctions.showError(
          message: 'لم يتم حفظ التعديلات', context: context);
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

  String? convertToDate(String? datestring) {
    String apiDateString = datestring ?? '';
    DateTime apiDate = DateTime.parse(apiDateString);
    String formattedDate = intl.DateFormat('dd/MM/yyyy').format(apiDate);
    printError('formattedDate $formattedDate');
    return formattedDate;
  }

  changeBirthdate(DateTime? selected) {
    recievedMakhdom!.birthdate =
        intl.DateFormat('yyyy-MM-dd').format(selected!);
    printWarning('NEW BIRTHDAY ${recievedMakhdom!.birthdate ?? ''}');
    notifyListeners();
  }
}
