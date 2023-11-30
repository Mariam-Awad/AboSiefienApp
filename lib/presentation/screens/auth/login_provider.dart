import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/repositories/login_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginProvider extends ChangeNotifier {
  LoginRepo loginRepo = LoginRepo();
  CustomFunctions customFunctions = CustomFunctions();
  String version = '';

  Future<bool> login(
      String username, String password, BuildContext context) async {
    printWarning('username $username');
    printWarning('password $password');
    customFunctions.showProgress(context);
    UserModel? response = await loginRepo.requestLogin(username, password);
    notifyListeners();
    printDone('response $response');
    if (response != null && response.data != null) {
      try {
        if (response.success == true) {
          AppCache.instance.setUserModel(response);
          printInfo('SET API TOKEN NOW');
          customFunctions.hideProgress();
          notifyListeners();
          return true;
        }
      } catch (error) {
        printError(error);
        customFunctions.showError(
            message: response.errorMsg!, context: context);
        customFunctions.hideProgress();
        notifyListeners();
        return false;
      }
    }
    customFunctions.hideProgress();
    notifyListeners();
    return false;
  }

  getAPKVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    printWarning('version $version');
    printWarning('buildNumber $buildNumber');
  }
}
