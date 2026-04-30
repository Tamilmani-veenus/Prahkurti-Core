
import '../db_helper/db_manager.dart';
import '../db_model/consumptionitemlist_model.dart';

class ConsumptionItemlistService{
  late DBManager _dbManager;

  ConsumptionItemlistService() {
    _dbManager = DBManager();
  }

  ConsumItemlist_table_Save(
      List<ConsumptionItemlist> consumItemListTableModel) async {
    consumItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('consumItemListTable', element.ConsumItemlistmodelmap());
    });
  }

  ConumItemlist_table_readAll() async {
    return _dbManager.readData('consumItemListTable');
  }

  ConumItemlist_table_Update(
      List<ConsumptionItemlist> consumItemListTableModel) async {
    consumItemListTableModel.forEach((element) async {
      return await _dbManager.Update_MaterialTable('consumItemListTable', element.ConsumItemlistmodelmap());
    });
  }
  consumdeleteById(List<ConsumptionItemlist> consumItemListTableModel) async {
    consumItemListTableModel.forEach((element) async {
      return await _dbManager.deleteMaterialById('consumItemListTable', element.ConsumItemlistmodelmap());
    });
  }

  ConsumItemlist_table_delete() async {
    return await _dbManager.delete('consumItemListTable');
  }

}