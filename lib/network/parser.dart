import 'package:abosiefienapp/model/user_model.dart';

class Parser {
  static parse<T>(dynamic json) {
    switch (T) {
      case UserModel:
        return UserModel.fromJson(json);
    }
  }
}
