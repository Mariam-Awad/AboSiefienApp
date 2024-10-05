import 'package:abosiefienapp/core/errors/failures.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import '../core/app_repository/repo.dart';
import '../core/errors/exceptions.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_debug_prints.dart';

class MyMakhdomsRepo extends Repository {
  Future<Either<Failure, MyMakhdomsModel?>> requestMyMakhdoms(
      int sortColumn, int sortDirection, String absentDate) {
    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    return exceptionHandler(
      () async {
        printWarning('Iam In HistoryOfMakhdoms Repo');
        final Map<String, dynamic> response = await dioHelper
            .getDataWithQuery(endPont: Endpoints.REQUEST_MY_MAKHDOMS, query: {
          "sortCoulmn": sortColumn,
          "sortDirection": sortDirection,
          "absentDate": formattedDate,
        });
        if (response['success'] == true) {
          return MyMakhdomsModel.fromJson(response);
        }
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }

  Future<Either<Failure, dynamic>> requestUpdateMakhdom(Data data) {
    return exceptionHandler(
      () async {
        printWarning('Iam In HistoryOfMakhdoms Repo');

        final Map<String, dynamic> response = await dioHelper.putData(
          Endpoints.REQUEST_UPDATE_MAKHDOM,
          {
            "id": data.id,
            "name": data.name,
            "phone": data.phone,
            "phone2": data.phone2,
            "adress": data.addBeside,
            "birthdate": data.birthdate,
            "addNo": data.addNo.toString(),
            "addStreet": data.addStreet,
            "addFloor": data.addFloor,
            "addBeside": data.addBeside,
            "father": data.father,
            "university": data.university,
            "faculty": data.faculty,
            "studentYear": data.studentYear,
            "khademId": data.khademId,
            "groupId": data.groupId,
            "notes": data.notes,
            "levelId": data.levelId,
            "oldId": data.levelId,
            "genderId": data.genderId,
            "job": data.job,
            "socialId": data.socialId,
          },
        );
        if (response['success'] == true) {
          return response['data'];
        }
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }

  // Future requestUpdateMakhdom(Data data) {
  //   printWarning('Iam In HistoryOfMakhdoms Repo');
  //   return networkManager.put<dynamic>(
  //       Endpoints.REQUEST_UPDATE_MAKHDOM, data.toJson());
  // }
}
