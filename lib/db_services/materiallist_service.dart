import '../db_helper/db_manager.dart';
import '../db_model/materiallist_model.dart';

class MateriallistService{
  late DBManager _dbManager;

  MateriallistService() {
    _dbManager = DBManager();
  }

  Material_table_Save(
      List<Materiallist> materiallistTableModel) async {
    materiallistTableModel.forEach((element) async {
      return await _dbManager.insertData('materialListTable', element.Materiallistmodelmap());
    });
  }

  MaterialItemlist_table_readAll() async {
    return _dbManager.readData('materialListTable');
  }


  materialdeleteById(List<Materiallist> materiallistTableModel) async {
    materiallistTableModel.forEach((element) async {
      return await _dbManager.deleteMaterialById('materialListTable', element.Materiallistmodelmap());
    });
  }

  MaterialItemlist_table_delete() async {
    return await _dbManager.delete('materialListTable');
  }

  MaterialItemlist_table_Update(
      List<Materiallist> materiallistTableModel) async {
    materiallistTableModel.forEach((element) async {
      return await _dbManager.Update_MaterialTable('materialListTable', element.Materiallistmodelmap());
    });
  }
}