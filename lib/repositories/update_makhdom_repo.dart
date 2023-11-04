import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/model/makhdom_update_model.dart';
import 'package:abosiefienapp/model/mymakhdoms_model.dart' as mymakhdomsmodel;
import 'package:abosiefienapp/network/end_points.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class UpdateMakhdomRepo extends BaseRepo {
  Future<MakhdomUpdateModel?> requestUpdateMakhdom(mymakhdomsmodel.Data data) {
    printWarning('Iam In HistoryOfMakhdoms Repo');
    return networkManager.put<MakhdomUpdateModel>(
        Endpoints.REQUEST_UPDATE_MAKHDOM,
        body: data.toJson());
  }
}
