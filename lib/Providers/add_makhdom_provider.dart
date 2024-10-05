import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/core/utils/custom_function.dart';
import 'package:abosiefienapp/model/dropdown_model.dart';
import 'package:abosiefienapp/model/khadem_model.dart' as khademmodel;
import 'package:abosiefienapp/model/radio_button_model.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/repositories/add_makhdom_repo.dart';
import 'package:abosiefienapp/repositories/khadem_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../core/utils/app_debug_prints.dart';
import 'login_provider.dart';

class AddMakhdomProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey();
  CustomFunctions customFunctions = CustomFunctions();
  AddMakhdomRepo addMakhdomRepo = AddMakhdomRepo();
  KhademRepo khademRepo = KhademRepo();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController addressNumberController = TextEditingController();
  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressBesideController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController studentYearController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  RadioButtonModel genderValue = RadioButtonModel(1, true);
  String? birthdate;

  List<khademmodel.Data>? allKhodam;
  int? selectedKhadem = 2;
  List<DropdownModel>? dropdownList = [];

  validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      printDone('Validated');
      UserModel? recievedUserModel = LoginProvider().user;
      printWarning('nameController =${nameController.text}');
      printWarning('phoneController =${phoneController.text}');
      printWarning('selectedKhadem =$selectedKhadem');
      addMyMakhdom(context, {
        "id": 0,
        "name": nameController.text,
        "phone": phoneController.text,
        "phone2": phone2Controller.text,
        "birthdate": birthdate,
        "addNo": addressNumberController.text == ''
            ? 0
            : addressNumberController.text,
        "addStreet": addressStreetController.text,
        "addFloor": 0,
        "addBeside": addressBesideController.text,
        "father": fatherController.text,
        "university": universityController.text,
        "faculty": facultyController.text,
        "studentYear":
            studentYearController.text == '' ? 0 : studentYearController.text,
        "khademId": selectedKhadem,
        "groupId": 0,
        "notes": notesController.text,
        "levelId": recievedUserModel!.data!.levelId,
        "genderId": genderValue.value,
        "job": "string",
        "socialId": 1,
        "lastAttendanceDate": "2023-11-21T13:20:39.152Z",
        "lastCallDate": "2023-11-21T13:20:39.152Z"
      });
    } else {
      printError('Not Validated');
      customFunctions.showError(
          message: 'برجاء إدخال البيانات المطلوبة', context: context);
    }
  }

  clearForm() {
    nameController.text = '';
    phoneController.text = '';
    phone2Controller.text = '';
    birthdate = '';
    addressNumberController.text = '';
    addressStreetController.text = '';
    addressBesideController.text = '';
    fatherController.text = '';
    universityController.text = '';
    facultyController.text = '';
    studentYearController.text = '';
    selectedKhadem = 2;
    notesController.text = '';
    genderValue.value = 1;
    notifyListeners();
  }

  changeBirthdate(DateTime? selected) {
    birthdate = intl.DateFormat('yyyy-MM-dd').format(selected!);
    printWarning('NEW BIRTHDAY $birthdate');
    notifyListeners();
  }

  void setSelectedKhadem(int? value) {
    selectedKhadem = value!;
    notifyListeners();
  }

  Future<bool> addMyMakhdom(
      BuildContext context, Map<String, dynamic> body) async {
    customFunctions.showProgress(context);
    var responseAddMakhdom = await addMakhdomRepo.requestAddMakhdom(body);
    printDone('response $responseAddMakhdom');
    notifyListeners();
    responseAddMakhdom.fold(
      (l) {
        printError(l.message);
        customFunctions.showError(message: 'لم يتم الإضافة', context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      },
      (r) {
        printInfo('Added Now');
        customFunctions.showSuccess(
            message: 'تم الإضافة بنجاح', context: context);
        clearForm();
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

  List<DropdownModel?> createListOfDropDown() {
    for (int i = 0; i <= allKhodam!.length; i++) {
      dropdownList!.add(DropdownModel(
          id: allKhodam![i].id,
          name: allKhodam![i].name,
          extratext: allKhodam![i].makhdomsCount.toString()));
    }
    notifyListeners();
    return dropdownList!;
  }

  // GET Khadem
  Future<bool> getkhadem(BuildContext context) async {
    Either<Failure, khademmodel.KhademModel?> responcekhademmodel =
        await khademRepo.requestGetKhadem();
    printDone('response $responcekhademmodel');
    notifyListeners();
    responcekhademmodel.fold(
      (Failure l) {
        printError(l.message);
        notifyListeners();
        return false;
      },
      (khademmodel.KhademModel? r) {
        allKhodam = r!.data;
        printDone('Get Khadem Now');
        notifyListeners();
        createListOfDropDown();
        return true;
      },
    );

    printError('error');
    notifyListeners();
    return false;
  }
}
