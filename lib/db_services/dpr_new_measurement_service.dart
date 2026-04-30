import '../db_helper/db_manager.dart';
import '../db_model/dpr_new_measurementTable_model.dart';


class DprNew_MeasurementService {
  late DBManager _dbManager;

  DprNew_MeasurementService() {
    _dbManager = DBManager();
  }

  DprNew_MeasurementTable_Save(
      List<DprNew_MeasurementTable> dprNewMSrTableModel) async {
    dprNewMSrTableModel.forEach((element) async {
      return await _dbManager.insertData('dprNewMSRTable', element.DprNew_MeasurementMap());
    });
  }

  DprNew_MeasurementTable_readAll() async {
    return _dbManager.readData('dprNewMSRTable');
  }


  DprNew_MeasurementTable_Update(
      List<DprNew_MeasurementTable> dprNewMSrTableModel) async {
    dprNewMSrTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('dprNewMSRTable', element.DprNew_MeasurementMap());
    });
  }

  DprNew_MeasurementTable_deleteById(
      List<DprNew_MeasurementTable> dprNewMSrTableModel) async {
    dprNewMSrTableModel.forEach((element) async {
      return await _dbManager.dpr_NewMSRTable_deleteDataByName(
          'dprNewMSRTable', element.DprNew_MeasurementMap());
    });
  }

  DprNew_MeasurementTable_delete() async {
    return await _dbManager.delete('dprNewMSRTable');
  }

  DprNew_MeasurementTable_OrderBy(
      List<DprNew_MeasurementTable> dprNewMSrTableModel) async {
    dprNewMSrTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'dprNewMSRTable', element.DprNew_MeasurementMap());
    });
  }


}
