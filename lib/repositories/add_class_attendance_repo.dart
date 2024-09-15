import 'package:dartz/dartz.dart';

import '../core/app_repository/repo.dart';
import '../core/errors/exceptions.dart';
import '../core/errors/failures.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_debug_prints.dart';

class AddClassAttendanceRepo extends Repository {
  Future<Either<Failure, Map<String, dynamic>>> requestAddAttendance(
      Map<String, dynamic>? body) {
    return exceptionHandler(
      () async {
        printWarning('Iam In AddAttendance Repo');
        final Map<String, dynamic> response = await dioHelper.getDataWithQuery(
            endPont: Endpoints.REQUEST_ADD_ATTENDANCE, query: body!);
        if (response['success'] == true) {
          return response;
        }
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }
}
