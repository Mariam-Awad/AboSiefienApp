import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

void showError({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.red.shade900,
    textColor: Colors.white,
    fontSize: 14.sp,
  );
}

void showSuccess({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.green.shade900,
    textColor: Colors.white,
    fontSize: 14.sp,
  );
}

void showLoading(BuildContext context) {
  showDialog(
      barrierColor: Colors.white.withOpacity(.35),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.canPop(context);
}

void closeKeyBoard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void closeBottomSheet(BuildContext context) {
  Navigator.canPop(context);
}
