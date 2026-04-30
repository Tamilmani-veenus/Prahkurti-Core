import '../db_helper/db_manager.dart';
import '../db_model/dpr_labour_detTable_model.dart';



class DprLabour_DetService {
  late DBManager _dbManager;

  DprLabour_DetService() {
    _dbManager = DBManager();
  }

  DprLabour_DetTable_Save(
      List<DprLabour_DetTable> dprLabourDetTableModel) async {
    dprLabourDetTableModel.forEach((element) async {
      return await _dbManager.insertData('dprLabourDetTable', element.DprLabour_DetTableMap());
    });
  }

  DprLabour_DetTable_readAll() async {
    return _dbManager.readData('dprLabourDetTable');
  }


  DprLabour_DetTable_Update(
      List<DprLabour_DetTable> dprLabourDetTableModel) async {
    dprLabourDetTableModel.forEach((element) async {
      return await _dbManager.Update_dprItemlistTable('dprLabourDetTable', element.DprLabour_DetTableMap());
    });
  }

  DprLabour_Det_deleteById(
      List<DprLabour_DetTable> dprLabourDetTableModel) async {
    dprLabourDetTableModel.forEach((element) async {
      return await _dbManager.deleteDataById(
          'dprLabourDetTable', element.DprLabour_DetTableMap());
    });
  }

  DprLabour_Dettable_delete() async {
    return await _dbManager.delete('dprLabourDetTable');
  }

  DprLabour_Dettable_OrderBy(
      List<DprLabour_DetTable> dprLabourDetTableModel) async {
    dprLabourDetTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprLabourDetTable', element.DprLabour_DetTableMap());
    });
  }


}
