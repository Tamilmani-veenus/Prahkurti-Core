import '../db_helper/db_manager.dart';
import '../db_model/manpower_det_model.dart';

class ManPowerDetService {
  late DBManager _dbManager;

  ManPowerDetService() {
    _dbManager = DBManager();
  }

  ManPowerDetSave(List<ManPowerDetModel> manPowerDetModel) async {
    manPowerDetModel.forEach((element) async {
      return await _dbManager.insertData('manPowerDet', element.ManPowerDetMap());
    });
  }

  ManPowerDetreadAll() async {
    return  _dbManager.readData('manPowerDet');
  }

  ManPowerDetUpdate(List<ManPowerDetModel> manPowerDetModel) async {
    manPowerDetModel.forEach((element) async {
      return await _dbManager.Update_dpr_NewLabourTable(
          'manPowerDet', element.ManPowerDetMap());
    });
  }
  ManPowerDetdeleteById(List<ManPowerDetModel> manPowerDetModel) async {
    manPowerDetModel.forEach((element) async {
      return await _dbManager.deleteDataByCatId('manPowerDet', element.ManPowerDetMap());
    });
  }

  ManPowerDetdelete() async {
    return await _dbManager.delete('manPowerDet');
  }

  // SubContDet_OrderBy() async {
  //   return  await _dbManager.groupBySubcontTable();
  //
  // }

}
