import '../db_helper/db_manager.dart';
import '../db_model/materialapprlist_model.dart';

class MaterialapprlistService{
  late DBManager _dbManager;

  MaterialapprlistService() {
    _dbManager = DBManager();
  }
  MaterialApproval_table_Save(
      List<Materialapprlist> MaterialapprlistTableModel) async {
    MaterialapprlistTableModel.forEach((element) async {
      return await _dbManager.insertData('materialApprovalListTable', element.Materialapprlistmodelmap());
    });
  }

  Material_ApprovalItemlist_table_readAll() async {
    return _dbManager.readData('materialApprovalListTable');
  }


  materialApprovaldeleteById(List<Materialapprlist> MaterialapprlistTableModel) async {
    MaterialapprlistTableModel.forEach((element) async {
      return await _dbManager.deleteMaterialById('materialApprovalListTable', element.Materialapprlistmodelmap());
    });
  }

  Material_ApprovalItemlist_table_delete() async {
    return await _dbManager.delete('materialApprovalListTable');
  }

  Material_ApprovalItemlist_table_Update(
      List<Materialapprlist> MaterialapprlistTableModel) async {
    MaterialapprlistTableModel.forEach((element) async {
      return await _dbManager.Update_MaterialTable('materialApprovalListTable', element.Materialapprlistmodelmap());
    });
  }
}