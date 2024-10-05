import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/core/extension_method/extension_navigation.dart';
import 'package:abosiefienapp/core/utils/custom_function.dart';
import 'package:abosiefienapp/model/makhdom_update_model.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart' as mymakhdomsmodel;
import 'package:abosiefienapp/model/radio_button_model.dart';
import 'package:abosiefienapp/repositories/my_makhdoms_repo.dart';
import 'package:abosiefienapp/repositories/update_makhdom_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../core/route/app_routes.dart';
import '../core/utils/app_debug_prints.dart';

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

  Future<bool?> updateMyMakhdom(
      BuildContext context, mymakhdomsmodel.Data data) async {
    printWarning('data $data');

    customFunctions.showProgress(context);
    Either<Failure, MakhdomUpdateModel?> responseUpdateMyMakhdom =
        await updateMakhdomRepo.requestUpdateMakhdom(data);
    printDone('response $responseUpdateMyMakhdom');
    responseUpdateMyMakhdom.fold(
      (l) {
        printError(l.message);
        customFunctions.showError(
            message: 'لم يتم حفظ التعديلات', context: context);
        customFunctions.showError(
            message: 'لم يتم حفظ التعديلات', context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      },
      (r) {
        customFunctions.showSuccess(
            message: 'تم التعديل بنجاح', context: context);
        context.pushNamed(routeName: AppRoutes.myMakhdomsRouteName);
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      },
    );
    notifyListeners();

    //  }
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
