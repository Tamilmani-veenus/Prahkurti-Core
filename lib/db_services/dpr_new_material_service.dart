import '../db_helper/db_manager.dart';
import '../db_model/dpr_new_materialTable_model.dart';

class DprNew_MaterialService {
  late DBManager _dbManager;

  DprNew_MaterialService() {
    _dbManager = DBManager();
  }

  DprNew_MaterialTable_Save(
      List<DprNew_MaterialTable> dprNewMatTableModel) async {
    dprNewMatTableModel.forEach((element) async {
      return await _dbManager.insertData('dprNewMaterialTable', element.DprNew_MaterialTableMap());
    });
  }

  DprNew_MaterialTable_readAll() async {
    return _dbManager.readData('dprNewMaterialTable');
  }


  DprNew_MaterialTable_Update(
      List<DprNew_MaterialTable> dprNewMatTableModel) async {
    dprNewMatTableModel.forEach((element) async {
      return await _dbManager.Update_dpr_NewMaterialTable('dprNewMaterialTable', element.DprNew_MaterialTableMap());
    });
  }

  DprNew_MaterialTable_deleteById(
      List<DprNew_MaterialTable> dprNewMatTableModel) async {
    dprNewMatTableModel.forEach((element) async {
      return await _dbManager.dpr_NewMaterialTable_deleteDataByName(
          'dprNewMaterialTable', element.DprNew_MaterialTableMap());
    });
  }

  DprNew_MaterialTable_delete() async {
    return await _dbManager.delete('dprNewMaterialTable');
  }

  DprNew_MaterialTable_OrderBy(
      List<DprNew_MaterialTable> dprNewMatTableModel) async {
    dprNewMatTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprNewMaterialTable', element.DprNew_MaterialTableMap());
    });
  }


}
