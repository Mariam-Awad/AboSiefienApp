import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastM {
  static show(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.grey[700],
      timeInSecForIosWeb: 5,
    );
  }

  static showTryCatchMessage({BuildContext? context}) {
    Fluttertoast.showToast(
      msg: 'try catch',
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
  }
}
