import 'package:abosiefienapp/model/khadem_model.dart';
import 'package:dartz/dartz.dart';

import '../core/app_repository/repo.dart';
import '../core/errors/exceptions.dart';
import '../core/errors/failures.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_debug_prints.dart';

class KhademRepo extends Repository {
  Future<Either<Failure, KhademModel?>> requestGetKhadem() {
    return exceptionHandler(
      () async {
        printWarning('Iam In Khadem Repo');
        final Map<String, dynamic> response = await dioHelper.getData(
          endPont: Endpoints.REQUEST_GET_KHADEM,
        );
        if (response['success'] == true) {
          return KhademModel.fromJson(response);
        }
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }
}
