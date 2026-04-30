import '../db_helper/db_manager.dart';
import '../db_model/dpr_new_massTable_model.dart';


class DprNew_MassService {
  late DBManager _dbManager;

  DprNew_MassService() {
    _dbManager = DBManager();
  }

  DprNew_Masstable_Save(
      List<DprNew_MassModel> dprNewMassTableModel) async {
    dprNewMassTableModel.forEach((element) async {
      return await _dbManager.insertData('dprNewMassTable', element.DprNew_MassMap());
    });
  }

  DprNew_Masstable_readAll() async {
    return _dbManager.readData('dprNewMassTable');
  }


  DprNew_Masstable_Update(
      List<DprNew_MassModel> dprNewMassTableModel) async {
    dprNewMassTableModel.forEach((element) async {
      return await _dbManager.Update_dprItemlistTable('dprNewMassTable', element.DprNew_MassMap());
    });
  }

  DprNew_Masstable_deleteById(
      List<DprNew_MassModel> dprNewMassTableModel) async {
    dprNewMassTableModel.forEach((element) async {
      return await _dbManager.deleteDataById(
          'dprNewMassTable', element.DprNew_MassMap());
    });
  }

  DprNew_Masstable_delete() async {
    return await _dbManager.delete('dprNewMassTable');
  }

  DprNew_Masstable_OrderBy(
      List<DprNew_MassModel> dprNewMassTableModel) async {
    dprNewMassTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprNewMassTable', element.DprNew_MassMap());
    });
  }


}
