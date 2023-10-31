import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class Parser {
  static parse<T>(dynamic json) {
    printWarning(json);
    switch (T) {
      case UserModel:
        return UserModel.fromJson(json);
    }
  }
}
