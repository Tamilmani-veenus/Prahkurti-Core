import '../db_helper/db_manager.dart';
import '../db_model/dpr_labour_labscreen_Table_model.dart';


class DprLabour_LabScreenService {
  late DBManager _dbManager;

  DprLabour_LabScreenService() {
    _dbManager = DBManager();
  }

  DprLabour_LabScreenTable_Save(
      List<DprLabour_LabTableModel> dprLabourTableModel) async {
    dprLabourTableModel.forEach((element) async {
      return await _dbManager.insertData('dprLabourLabScreenTable', element.DprLabour_LabscreenMap());
    });
  }

  DprLabour_LabScreenTable_readAll() async {
    return _dbManager.readData('dprLabourLabScreenTable');
  }


  DprLabour_LabScreenTable_Update(
      List<DprLabour_LabTableModel> dprLabourTableModel) async {
    dprLabourTableModel.forEach((element) async {
      return await _dbManager.dprLabour_UpdateDataById('dprLabourLabScreenTable', element.DprLabour_LabscreenMap());
    });
  }

  DprLabour_LabScreenTable_deleteById(
      List<DprLabour_LabTableModel> dprLabourTableModel) async {
    dprLabourTableModel.forEach((element) async {
      return await _dbManager.dprLabour_deleteDataById(
          'dprLabourLabScreenTable', element.DprLabour_LabscreenMap());
    });
  }

  DprLabour_LabScreenTable_delete() async {
    return await _dbManager.delete('dprLabourLabScreenTable');
  }

  DprLabour_LabScreenTable_OrderBy(
      List<DprLabour_LabTableModel> dprLabourTableModel) async {
    dprLabourTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprLabourLabScreenTable', element.DprLabour_LabscreenMap());
    });
  }


}
