import '../db_helper/db_manager.dart';
import '../db_model/siteLocation_DB_Model.dart';

class SiteLocationService {
  late DBManager _dbManager;

  SiteLocationService() {
    _dbManager = DBManager();
  }

  siteLocationTableSave(
      List<SiteLocationDBModel> sitelocationModel) async {
    sitelocationModel.forEach((element) async {
      return await _dbManager.insertData('siteLocation', element.siteLocationDBModelMap());
    });
  }

  siteLocationReadAll() async {
    return _dbManager.readData('siteLocation');
  }


  siteLocationDelete() async {
    return await _dbManager.delete('siteLocation');
  }


}
