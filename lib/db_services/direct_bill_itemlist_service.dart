import '../db_helper/db_manager.dart';
import '../db_model/direct_bill_gst_calculation_model.dart';
import '../db_model/directbill_gen_itemlist_model.dart';

class DirectBillGen_ItemlistService {
  late DBManager _dbManager;

  DirectBillGen_ItemlistService() {
    _dbManager = DBManager();
  }

  Future DirectBillGen_ItemlistTable_Save(
      List<DirectBillGenItemListTableModel> list) async {

    for (var element in list) {
      await _dbManager.insertData(
        'directBillGenItemlistTable',
        element.DirectBillGenItemListTableMap(),
      );
    }
  }

  DirectBillGen_ItemlistTable_readAll() async {
    return _dbManager.readData('directBillGenItemlistTable');
  }


  Future DirectBillGen_ItemlistTable_Update(
      List<DirectBillGenItemListTableModel> list) async {

    for (var element in list) {
      await _dbManager.UpdateTableIdwise(
        'directBillGenItemlistTable',
        element.DirectBillGenItemListTableMap(),
      );
    }
  }

  Future DirectBillGen_ItemlistTable_deleteById(
      List<DirectBillGenItemListTableModel> list) async {

    for (var element in list) {
      await _dbManager.directBill_deleteDataById(
        'directBillGenItemlistTable',
        element.DirectBillGenItemListTableMap(),
      );
    }
  }

  DirectBillGen_ItemlistTable_delete() async {
    return await _dbManager.delete('directBillGenItemlistTable');
  }

  billgen_DeleteApiRows() async {
    return await _dbManager.deleteApiRows('directBillGenItemlistTable');
  }

  DirectBillGen_ItemlistTable_OrderBy(
      List<DirectBillGenItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'directBillGenItemlistTable', element.DirectBillGenItemListTableMap());
    });
  }

  //nmr weekly bill generation

  DirectBillGST_ItemTable_Save(
      List<DirectBillGSTCalTable> directBillGenGSTItemListTableModel) async {
    directBillGenGSTItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('directBillGenGSTItemlistTable', element.DirectBillGSTCalTableMap());
    });
  }

  DirectBillGST_ItemlistTable_readAll() async {
    return _dbManager.readData('directBillGenGSTItemlistTable');
  }

  DirectBillGST_ItemlistTable_Update(
      List<DirectBillGSTCalTable> directBillGenGSTItemListTableModel) async {
    directBillGenGSTItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('directBillGenGSTItemlistTable', element.DirectBillGSTCalTableMap());
    });
  }

  DirectBillGST_ItemlistTable_delete() async {
    return await _dbManager.delete('directBillGenGSTItemlistTable');
  }

}
