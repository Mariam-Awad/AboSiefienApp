import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/network/end_points.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class AddAttendanceRepo extends BaseRepo {
  Future<dynamic> requestAddAttendance(Map<String, dynamic>? body) {
    printWarning('Iam In AddAttendance Repo');
    return networkManager.post<dynamic>(Endpoints.REQUEST_ADD_ATTENDANCE,
        body: body!);
  }
}
