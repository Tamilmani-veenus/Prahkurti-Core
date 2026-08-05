import '../db_helper/db_manager.dart';
import '../db_model/workOrderBoqGST_Cal_model.dart';
import '../db_model/workOrderBoqItemlist_model.dart';

class WorkOrderBoqItemlistService{
  late DBManager _dbManager;
  WorkOrderBoqItemlistService() {
    _dbManager = DBManager();
  }


  WorkOrdBoqItem_table_Save(
      List<WorkOrderBoqItemlist> boqitemlistTableModel) async {
    boqitemlistTableModel.forEach((element) async {
      return await _dbManager.insertData('workOrderboqitemListTable', element.WorkOrderBoqItemlistmodelmap());
    });
  }

  WorkOrdBoqItemlist_table_readAll() async {
    return _dbManager.readData('workOrderboqitemListTable');
  }

  itemdeleteById(List<WorkOrderBoqItemlist> boqitemlistTableModel) async {
    boqitemlistTableModel.forEach((element) async {
      return await _dbManager.deleteboqitemlById('workOrderboqitemListTable', element.WorkOrderBoqItemlistmodelmap());
    });
  }

  WorkOrdBoqItemlist_table_delete() async {
    return await _dbManager.delete('workOrderboqitemListTable');
  }

  WorkOrdBoqItemlist_table_Update(
      List<WorkOrderBoqItemlist> boqitemlistTableModel) async {
    boqitemlistTableModel.forEach((element) async {
      return await _dbManager.Update_BoqTable('workOrderboqitemListTable', element.WorkOrderBoqItemlistmodelmap());
    });
  }

  workOrderGST_ItemTable_Save(
      List<WorkOrderBoqGSTCalTable> directBillGenGSTItemListTableModel) async {
    directBillGenGSTItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('workOrderBoqGSTItemlistTable', element.WorkOrderBoqGSTCalTableMap());
    });
  }

  workOrderGST_ItemlistTable_readAll() async {
    return _dbManager.readData('workOrderBoqGSTItemlistTable');
  }

  workOrderGST_ItemlistTable_Update(
      List<WorkOrderBoqGSTCalTable> directBillGenGSTItemListTableModel) async {
    directBillGenGSTItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('workOrderBoqGSTItemlistTable', element.WorkOrderBoqGSTCalTableMap());
    });
  }

  workOrderGST_ItemlistTable_delete() async {
    return await _dbManager.delete('workOrderBoqGSTItemlistTable');
  }


}