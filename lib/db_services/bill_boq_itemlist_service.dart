import '../db_helper/db_manager.dart';
import '../db_model/billgen_boq_itemlist_model.dart';
import '../db_model/direct_bill_gst_calculation_model.dart';

class BillGenBoq_ItemlistService {
  late DBManager _dbManager;

  BillGenBoq_ItemlistService() {
    _dbManager = DBManager();
  }

  DirectBillGen_ItemlistTable_Save(
      List<BillGenBoqItemListTableModel> billGenBoqItemListTableModel) async {
    billGenBoqItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('billGenBoqItemlistTable', element.BillGenBoqItemListTableMap());
    });
  }

  DirectBillGen_ItemlistTable_readAll() async {
    return _dbManager.readData('billGenBoqItemlistTable');

  }


  Future<void> DirectBillGen_ItemlistTable_Update(
      List<BillGenBoqItemListTableModel> list) async {

    for (var element in list) {
      await _dbManager.Update_BillBoqTable(
        'billGenBoqItemlistTable',
        element.BillGenBoqItemListTableMap(),
      );
    }

    // Verify updated data
    var data = await _dbManager.readData('billGenBoqItemlistTable');

    print("===== UPDATED TABLE DATA =====");
    for (var row in data) {
      print(row);
    }
  }

  DirectBillGen_ItemlistTable_deleteById(
      List<BillGenBoqItemListTableModel> billGenBoqItemListTableModel) async {
    billGenBoqItemListTableModel.forEach((element) async {
      return await _dbManager.directBill_deleteDataById(
          'billGenBoqItemlistTable', element.BillGenBoqItemListTableMap());
    });
  }

  DirectBillGen_ItemlistTable_delete() async {
    return await _dbManager.delete('billGenBoqItemlistTable');
  }

  DirectBillGen_ItemlistTable_OrderBy(
      List<BillGenBoqItemListTableModel> billGenBoqItemListTableModel) async {
    billGenBoqItemListTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'billGenBoqItemlistTable', element.BillGenBoqItemListTableMap());
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
