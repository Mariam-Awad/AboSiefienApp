import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/network/end_points.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class LoginRepo extends BaseRepo {
  Future<UserModel?> requestLogin(String email, String password) {
    printWarning('Iam In Login Repo');
    return networkManager.get<UserModel>(Endpoints.REQUEST_LOGIN,
        params: {"userName": email, "password": password});
  }
}
