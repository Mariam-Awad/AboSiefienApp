import 'package:dartz/dartz.dart';

import '../core/app_repository/repo.dart';
import '../core/errors/exceptions.dart';
import '../core/errors/failures.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_debug_prints.dart';

class AddClassAttendanceRepo extends Repository {
  Future<Either<Failure, dynamic>> requestAddAttendance(
      Map<String, dynamic>? body) {
    return exceptionHandler(
      () async {
        printWarning('Iam In AddAttendance Repo');
        final Map<String, dynamic> response =
            await dioHelper.postData(Endpoints.REQUEST_ADD_ATTENDANCE, body);
        if (response['success'] == true) {
          return response['data'];
        }
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }
}
