import '../db_helper/db_manager.dart';
import '../db_model/directbill_gen_itemlist_model.dart';

class DirectBillGen_ItemlistService {
  late DBManager _dbManager;

  DirectBillGen_ItemlistService() {
    _dbManager = DBManager();
  }

  DirectBillGen_ItemlistTable_Save(
      List<DirectBillGenItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('directBillGenItemlistTable', element.DirectBillGenItemListTableMap());
    });
  }

  DirectBillGen_ItemlistTable_readAll() async {
    return _dbManager.readData('directBillGenItemlistTable');
  }


  DirectBillGen_ItemlistTable_Update(
      List<DirectBillGenItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('directBillGenItemlistTable', element.DirectBillGenItemListTableMap());
    });
  }

  DirectBillGen_ItemlistTable_deleteById(
      List<DirectBillGenItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.directBill_deleteDataById(
          'directBillGenItemlistTable', element.DirectBillGenItemListTableMap());
    });
  }

  DirectBillGen_ItemlistTable_delete() async {
    return await _dbManager.delete('directBillGenItemlistTable');
  }

  DirectBillGen_ItemlistTable_OrderBy(
      List<DirectBillGenItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'directBillGenItemlistTable', element.DirectBillGenItemListTableMap());
    });
  }


}
