

import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/model/user_model.dart';
import 'package:abosiefienapp/network/end_points.dart';

class LoginRepo extends BaseRepo {

  Future<UserModel?> requestLogin(String email,String password) {
    return networkManager
        .post<UserModel>(Endpoints.REQUEST_LOGIN, body: {"userName": email,"password":password});
  }

}