import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/network/end_points.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class AddMakhdomRepo extends BaseRepo {

  Future<dynamic> requestAddMakhdom(Map<String, dynamic>? body) {
    printWarning('Iam In HistoryOfMakhdoms Repo');
    return networkManager
        .post<dynamic>(Endpoints.REQUEST_ADD_MAKHDOM, body: body!); 
  }

}
