import '../db_helper/db_manager.dart';
import '../db_model/dpr_new_labourTable_model.dart';

class DprNew_LabourService {
  late DBManager _dbManager;

  DprNew_LabourService() {
    _dbManager = DBManager();
  }

  DprNew_LabTable_Save(
      List<DprNew_LabourTable> dprNewLabourTableModel) async {
    dprNewLabourTableModel.forEach((element) async {
      return await _dbManager.insertData('dprNewLabourTable', element.DprNew_LabourMap());
    });
  }

  DprNew_LabTable_readAll() async {
    return _dbManager.readData('dprNewLabourTable');
  }


  DprNew_LabTable_Update(
      List<DprNew_LabourTable> dprNewLabourTableModel) async {
    dprNewLabourTableModel.forEach((element) async {
      return await _dbManager.Update_dpr_NewLabourTable('dprNewLabourTable', element.DprNew_LabourMap());
    });
  }

  DprNew_LabTable_deleteById(
      List<DprNew_LabourTable> dprNewLabourTableModel) async {
    dprNewLabourTableModel.forEach((element) async {
      return await _dbManager.deleteDataById(
          'dprNewLabourTable', element.DprNew_LabourMap());
    });
  }

  DprNew_LabTable_delete() async {
    return await _dbManager.delete('dprNewLabourTable');
  }

  DprNew_LabTable_OrderBy(
      List<DprNew_LabourTable> dprNewLabourTableModel) async {
    dprNewLabourTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprNewLabourTable', element.DprNew_LabourMap());
    });
  }


}
