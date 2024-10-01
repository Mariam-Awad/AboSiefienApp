import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/repositories/add_class_attendance_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_colors_util.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart' as intl;

class AddAttendanceProvider extends ChangeNotifier {
  AddClassAttendanceRepo addClassAttendanceRepo = AddClassAttendanceRepo();
  CustomFunctions customFunctions = CustomFunctions();

  String errorMsg = '';

  final GlobalKey<FormState> attendanceformKey = GlobalKey();
  TextEditingController pointsController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String attendanceDate = '';

  List localAttendanceMakhdoms = [];
  String scanResult = '';

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
    AppCache.instance.setAttendanceMakhdomList(localAttendanceMakhdoms);
  }

  removeMakhdom(int code) {
    printWarning('IN Removw');
    for (int i = 0; i < localAttendanceMakhdoms.length; i++) {
      if (localAttendanceMakhdoms[i] == code) {
        localAttendanceMakhdoms.remove(localAttendanceMakhdoms[i]);
        notifyListeners();
        AppCache.instance.setAttendanceMakhdomList(localAttendanceMakhdoms);
      }
    }
  }

  removeAllList() {
    localAttendanceMakhdoms = [];
    AppCache.instance.removeAllLocalAttendanceMakhdoms();
    notifyListeners();
  }

  Future<bool> addAttendance(BuildContext context) async {
    convertToDate();
    try {
      customFunctions.showProgress(context);
      var response = await addClassAttendanceRepo.requestAddAttendance({
        "attendanceDate": attendanceDate,
        "makhdomsId": localAttendanceMakhdoms,
        "points": 0
      });
      printDone('response $response');
      notifyListeners();
      if (response != null && response['success'] == true) {
        errorMsg = response["errorMsg"] ?? '';
        customFunctions.showSuccess(
            message: response['data'], context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return true;
      } else if (response != null && response['success'] == false) {
        customFunctions.showError(
            message: response["errorMsg"].toString(), context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      }
    } catch (error) {
      printError(error);
      customFunctions.showError(
          message: 'حدث خطأ ما برجاء المحاولة مرة اخري', context: context);
      customFunctions.hideProgress();
      notifyListeners();
      return false;
    }
    customFunctions.hideProgress();
    notifyListeners();
    return false;
  }

  Future<void> scanCode() async {
    String barCodeScanRes;
    try{
      barCodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancle', true, ScanMode.QR);
    } on PlatformException{
      barCodeScanRes = 'حدث خطأ ما برجاء المحاولة مرة اخري';
    }
    scanResult = barCodeScanRes;
    codeController.text = barCodeScanRes;
    printDone('scanResult $scanResult');
    notifyListeners();
  }
}
