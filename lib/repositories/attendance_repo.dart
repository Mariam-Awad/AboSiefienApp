import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/model/attendance_model.dart';
import 'package:abosiefienapp/network/end_points.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class AttendanceRepo extends BaseRepo {
  Future<AttendanceModel?> requestAttendance(String absentDate) {
    printWarning('Iam In AttendanceRepo');
    return networkManager.get<AttendanceModel>(Endpoints.REQUEST_ATTENDANCE,
        params: {"absentDate": absentDate});
  }
}
