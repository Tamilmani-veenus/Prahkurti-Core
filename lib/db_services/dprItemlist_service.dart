import '../db_helper/db_manager.dart';
import '../db_model/dprItemListTable_model.dart';

class DprItemlistService {
  late DBManager _dbManager;

  DprItemlistService() {
    _dbManager = DBManager();
  }

  DprItemlist_table_Save(
      List<DprItemListTableModel> dprItemListTableModel) async {
    dprItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('dprItemListTable', element.DprItemListTableModelMap());
    });
  }

  DprItemlist_table_readAll() async {
    return _dbManager.readData('dprItemListTable');
  }


  DprItemlist_table_Update(
      List<DprItemListTableModel> dprItemListTableModel) async {
    dprItemListTableModel.forEach((element) async {
      return await _dbManager.Update_dprItemlistTable('dprItemListTable', element.DprItemListTableModelMap());
    });
  }

  DprItemlist_table_deleteById(
      List<DprItemListTableModel> dprItemListTableModel) async {
    dprItemListTableModel.forEach((element) async {
      return await _dbManager.deletDPRWrkById(
          'dprItemListTable', element.DprItemListTableModelMap());
    });
  }

  DprItemlist_table_delete() async {
    return await _dbManager.delete('dprItemListTable');
  }

  DprItemlist_table_OrderBy(
      List<DprItemListTableModel> dprItemListTableModel) async {
    dprItemListTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprItemListTable', element.DprItemListTableModelMap());
    });
  }


}
