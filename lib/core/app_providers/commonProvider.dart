import 'dart:io';

import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier {
  Future<bool>? isConnected() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      rethrow;
    }
    return false;
  }
}
