import '../db_helper/db_manager.dart';
import '../db_model/inwardpending_itemlist_table_model.dart';


class InwardPending_ItemlistService {
  late DBManager _dbManager;

  InwardPending_ItemlistService() {
    _dbManager = DBManager();
  }

  InwardPending_ItemlistTable_Save(
      List<InwardPendingItemListTableModel> inwardPendingItemListTableModel) async {
    inwardPendingItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('inwardPendingItemlistTable', element.InwardPendingItemListTableMap());
    });
  }

  InwardPending_ItemlistTable_readAll() async {
    return _dbManager.readData('inwardPendingItemlistTable');
  }


  InwardPending_ItemlistTable_Update(
      List<InwardPendingItemListTableModel> inwardPendingItemListTableModel) async {
    inwardPendingItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('inwardPendingItemlistTable', element.InwardPendingItemListTableMap());
    });
  }

  InwardPending_ItemlistTable_deleteById(
      List<InwardPendingItemListTableModel> inwardPendingItemListTableModel) async {
    inwardPendingItemListTableModel.forEach((element) async {
      return await _dbManager.directBill_deleteDataById(
          'inwardPendingItemlistTable', element.InwardPendingItemListTableMap());
    });
  }

  InwardPending_ItemlistTable_delete() async {
    return await _dbManager.delete('inwardPendingItemlistTable');
  }


}
