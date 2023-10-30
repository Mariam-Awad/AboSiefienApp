import 'package:abosiefienapp/cache/app_cache.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/repositories/login_repo.dart';
import 'package:abosiefienapp/shared/custom_function.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  LoginRepo loginRepo = LoginRepo();

  Future<bool> login(
      String username, String password, BuildContext context) async {
    showLoading(context);
    UserModel? response = await loginRepo.requestLogin(username, password);
    if (response != null && response.data != null) {
      try {
        if (response.success == true) {
          AppCache.instance.setApiToken(response.data!.token);
          hideLoading(context);
          return true;
        }
      } catch (error) {
        printError(error);
        showError(message: response.errorMsg!);
        hideLoading(context);
        return false;
      }
    }
    return false;
  }
}
