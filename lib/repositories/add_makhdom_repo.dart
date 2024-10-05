import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../core/app_repository/repo.dart';
import '../core/errors/exceptions.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_debug_prints.dart';

class AddMakhdomRepo extends Repository {
  Future<Either<Failure, dynamic>> requestAddMakhdom(
      Map<String, dynamic>? body) {
    return exceptionHandler(
      () async {
        printWarning('Iam In History Of Makhdoms Repo');
        final Map<String, dynamic> response =
            await dioHelper.postData(Endpoints.REQUEST_ADD_MAKHDOM, body);
        if (response['success'] == true) {
          return response['data'];
        }
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }
}
