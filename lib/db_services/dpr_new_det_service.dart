import '../db_helper/db_manager.dart';
import '../db_model/dpr_new_detTable_model.dart';



class DprNew_DetService {
  late DBManager _dbManager;

  DprNew_DetService() {
    _dbManager = DBManager();
  }

  DprNew_DetTable_Save(
      List<DprNew_DetTable> dprNewDetTableModel) async {
    dprNewDetTableModel.forEach((element) async {
      return await _dbManager.insertData('dprNewDetTable', element.DprNew_DetTableMap());
    });
  }

  DprNew_DetTable_readAll() async {
    return _dbManager.readData('dprNewDetTable');
  }


  DprNew_DetTable_Update(
      List<DprNew_DetTable> dprNewDetTableModel) async {
    dprNewDetTableModel.forEach((element) async {
      return await _dbManager.Update_dprItemlistTable('dprNewDetTable', element.DprNew_DetTableMap());
    });
  }

  DprNew_Det_deleteById(
      List<DprNew_DetTable> dprNewDetTableModel) async {
    dprNewDetTableModel.forEach((element) async {
      return await _dbManager.deleteDataById(
          'dprNewDetTable', element.DprNew_DetTableMap());
    });
  }

  DprNew_Dettable_delete() async {
    return await _dbManager.delete('dprNewDetTable');
  }

  DprNew_Dettable_OrderBy(
      List<DprNew_DetTable> dprNewDetTableModel) async {
    dprNewDetTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprNewDetTable', element.DprNew_DetTableMap());
    });
  }


}
