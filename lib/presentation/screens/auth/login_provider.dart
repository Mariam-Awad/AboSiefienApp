import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/repositories/login_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  LoginRepo loginRepo = LoginRepo();
  CustomFunctions customFunctions = CustomFunctions();

  Future<bool> login(
      String username, String password, BuildContext context) async {
    printWarning('username $username');
    printWarning('password $password');
    customFunctions.showProgress(context);
    UserModel? response = await loginRepo.requestLogin(username, password);
    printDone('response $response');
    if (response != null && response.data != null) {
      try {
        if (response.success == true) {
          AppCache.instance.setApiToken(response.data!.token);
          printInfo('SET API TOKEN NOW');
          customFunctions.hideProgress();
          return true;
        }
      } catch (error) {
        printError(error);
        customFunctions.showError(message: response.errorMsg!);
        customFunctions.hideProgress();
        return false;
      }
    }
    customFunctions.hideProgress();
    return false;
  }
}
