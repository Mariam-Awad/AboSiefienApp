import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/core/extension_method/extension_navigation.dart';
import 'package:abosiefienapp/core/utils/custom_function.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../core/route/app_routes.dart';
import '../core/shared_prefrence/app_shared_prefrence.dart';
import '../core/utils/app_debug_prints.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepo _loginRepo = LoginRepo();
  final CustomFunctions _customFunctions = CustomFunctions();
  String version = '';

  UserModel? _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  UserModel? get user => _user;

  Future<bool?> login(
      String username, String password, BuildContext context) async {
    try {
      printWarning('username $username');
      printWarning('password $password');
      _customFunctions.showProgress(context);

      final Either<Failure, UserModel?> response =
          await _loginRepo.requestLogin(username, password);
      notifyListeners();

      response.fold(
        (Failure failure) {
          printError(failure.message);
          _customFunctions.showError(
              message: failure.message, context: context);
          return false;
        },
        (UserModel? user) {
          if (user != null) {
            _storeUserToken(user.data?.token);
            _customFunctions.hideProgress();
            context.pushNamedAndRemoveUntil(
              AppRoutes.homeRouteName,
              predicate: (route) => false,
            );
            return true;
          } else {
            printError('Login failed: UserModel is null');
            _customFunctions.showError(
                message: 'Login failed. Please try again.', context: context);
            return false;
          }
        },
      );
    } finally {
      _customFunctions.hideProgress();
      notifyListeners();
    }
  }

  Future<void> _storeUserToken(String? token) async {
    if (token != null && token.isNotEmpty) {
      await AppSharedPreferences.setString(
          SharedPreferencesKeys.accessToken, token);
      printInfo('SET API TOKEN NOW');
      printDone(
          AppSharedPreferences.getString(SharedPreferencesKeys.accessToken)
              .toString());
    } else {
      printWarning('Token is null or empty');
    }
  }

  Future<void> getAPKVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    printWarning('version $version');
    notifyListeners();
  }
}
