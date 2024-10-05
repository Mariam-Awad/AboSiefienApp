import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../core/app_repository/repo.dart';
import '../core/errors/exceptions.dart';
import '../core/errors/failures.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_debug_prints.dart';

class CheckBoxAddAttendanceRepository extends Repository {
  Future<List<Map<String, dynamic>>> getFakeData() async {
    Dio dio = Dio();
    printWarning('Iam In CheckBoxAddAttendanceRepository ');

    var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data);

    return data;
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getAllNames() async {
    return exceptionHandler(
      () async {
        final Map<String, dynamic> response =
            await dioHelper.getData(endPont: Endpoints.allNames);

        printWarning(
            'Response from server: $response'); // تحقق من البيانات المسترجعة

        if (response['success'] == true) {
          // تأكد من أن البيانات تأتي بالشكل المتوقع
          if (response['data'] != null && response['data'] is List) {
            final data = List<Map<String, dynamic>>.from(response['data']);
            printDone('Data fetched successfully with length: ${data.length}');
            print('Fetched data: $data'); // طباعة البيانات المسترجعة

            return data;
          } else {
            printError(
                'Data is not a valid List<Map<String, dynamic>> format.');
            throw ServerException(exceptionMessage: 'Invalid data format');
          }
        }

        printError('Server returned an error: ${response['msg']}');
        throw ServerException(exceptionMessage: response['msg']);
      },
    );
  }
}
