import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFunctions {
  bool loaderVisible = false;
  CancelFunc? cancelFunc;

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

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void showProgress(BuildContext context) {
    closeKeyboard(context);
    cancelFunc?.call();

    cancelFunc = BotToast.showCustomLoading(
      toastBuilder: (context) => const CircularProgressIndicator(
        color: Colors.blue,
        backgroundColor: Colors.black26,
      ),
    );
    loaderVisible = true;
  }

  void hideProgress() {
    cancelFunc?.call();
    loaderVisible = false;
  }

  void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void closeBottomSheet(BuildContext context) {
    Navigator.canPop(context);
  }

  void showToast(String msg, IconData icon, Color color) {
    BotToast.showCustomText(
      duration: const Duration(seconds: 2),
      onlyOne: true,
      align: const Alignment(0, 0.8),
      toastBuilder: (_) => Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FaIcon(icon, color: color),
              SizedBox(width: 16.w),
              Flexible(
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 15, color: color, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


