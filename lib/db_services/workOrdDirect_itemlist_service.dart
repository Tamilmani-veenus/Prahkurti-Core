import '../db_helper/db_manager.dart';
import '../db_model/wordOrder_itemlist_model.dart';
import '../db_model/workOrderGST_calculation_model.dart';

class WorkOrder_ItemlistService {
  late DBManager _dbManager;

  WorkOrder_ItemlistService() {
    _dbManager = DBManager();
  }

  workOrder_ItemlistTable_Save(
      List<WorkOrderItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('workOrdDirectItemlistTable', element.WorkOrderItemListTableMap());
    });
  }

  workOrder_ItemlistTable_readAll() async {
    return _dbManager.readData('workOrdDirectItemlistTable');
  }


  workOrder_ItemlistTable_Update(
      List<WorkOrderItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('workOrdDirectItemlistTable', element.WorkOrderItemListTableMap());
    });
  }

  workOrder_ItemlistTable_deleteById(
      List<WorkOrderItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.directBill_deleteDataById(
          'workOrdDirectItemlistTable', element.WorkOrderItemListTableMap());
    });
  }

  workOrder_ItemlistTable_delete() async {
    return await _dbManager.delete('workOrdDirectItemlistTable');
  }

  workOrder_ItemlistTable_OrderBy(
      List<WorkOrderItemListTableModel> directBillGenItemListTableModel) async {
    directBillGenItemListTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'workOrdDirectItemlistTable', element.WorkOrderItemListTableMap());
    });
  }

  //nmr weekly bill generation

  workOrderGST_ItemTable_Save(
      List<WorkOrderGSTCalTable> directBillGenGSTItemListTableModel) async {
    directBillGenGSTItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('workOrderGSTItemlistTable', element.WorkOrderGSTCalTableMap());
    });
  }

  workOrderGST_ItemlistTable_readAll() async {
    return _dbManager.readData('workOrderGSTItemlistTable');
  }

  workOrderGST_ItemlistTable_Update(
      List<WorkOrderGSTCalTable> directBillGenGSTItemListTableModel) async {
    directBillGenGSTItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('workOrderGSTItemlistTable', element.WorkOrderGSTCalTableMap());
    });
  }

  workOrderGST_ItemlistTable_delete() async {
    return await _dbManager.delete('workOrderGSTItemlistTable');
  }

}