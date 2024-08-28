import 'package:abosiefienapp/model/makhdom_update_model.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart' as mymakhdomsmodel;
import 'package:dartz/dartz.dart';

import '../core/app_repository/repo.dart';
import '../core/errors/exceptions.dart';
import '../core/errors/failures.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_debug_prints.dart';

class UpdateMakhdomRepo extends Repository {
  Future<Either<Failure, MakhdomUpdateModel?>> requestUpdateMakhdom(
      mymakhdomsmodel.Data data) {
    printWarning('Iam In HistoryOfMakhdoms Repo');
    return exceptionHandler(
      () async {
        final Map<String, dynamic> response = await dioHelper.putData(
          Endpoints.REQUEST_UPDATE_MAKHDOM,
          data.toJson(),
        );
        if (response != null) {
          return MakhdomUpdateModel.fromJson(response['data']);
        }
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }
}
