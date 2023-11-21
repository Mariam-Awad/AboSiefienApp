import 'package:abosiefienapp/base/base-repo.dart';
import 'package:abosiefienapp/model/khadem_model.dart';
import 'package:abosiefienapp/network/end_points.dart';
import 'package:abosiefienapp/utils/app_debug_prints.dart';

class KhademRepo extends BaseRepo {
  Future<KhademModel?> requestGetKhadem() {
    printWarning('Iam In Khadem Repo');
    return networkManager.get<KhademModel>(Endpoints.REQUEST_GET_KHADEM);
  }
}
