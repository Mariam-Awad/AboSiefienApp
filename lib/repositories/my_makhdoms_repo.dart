import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart';
import 'package:abosiefienapp/network/end_points.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class MyMakhdomsRepo extends BaseRepo {
  Future<MyMakhdomsModel?> requestMyMakhdoms(int pageSize, int pageNo) {
    printWarning('Iam In HistoryOfMakhdoms Repo');
    return networkManager.get<MyMakhdomsModel>(Endpoints.REQUEST_MY_MAKHDOMS,
        params: {"pagesize": pageSize, "pageno": pageNo});
  }
}
