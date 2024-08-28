import 'package:dio/dio.dart';

import '../core/app_repository/repo.dart';
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
}
