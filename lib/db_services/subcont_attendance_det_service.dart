import '../db_helper/db_manager.dart';
import '../db_model/subcont_attendance_det_model.dart';

class SubContAttendatanceDetService {
  late DBManager _dbManager;

  SubContAttendatanceDetService() {
    _dbManager = DBManager();
  }

  SubContDetSave(List<SubContDetModel> subContDetModel) async {
    subContDetModel.forEach((element) async {
      return await _dbManager.insertData('subcontAttendanceDet', element.SubContDetMap());
    });
  }

  SubContDetreadAll() async {
    return  _dbManager.readData('subcontAttendanceDet');
  }

  // SubContDetUpdate(SubContDetModel subContDetModel) async {
  //   return await _dbManager.updateData(
  //       'subcontAttendanceDet', subContDetModel.SubContDetMap());
  // }

  SubContDetUpdate(List<SubContDetModel> subContDetModel) async {
    subContDetModel.forEach((element) async {
      return await _dbManager.updateData(
          'subcontAttendanceDet', element.SubContDetMap());
    });
  }

  SubContDetdeleteById(List<SubContDetModel> subContDetModel) async {
    subContDetModel.forEach((element) async {
      return await _dbManager.deleteDataById('subcontAttendanceDet', element.SubContDetMap());
    });
  }

  SubContDetdelete() async {
    return await _dbManager.delete('subcontAttendanceDet');
  }

  SubContDet_OrderBy() async {
      return  await _dbManager.groupBySubcontTable();

  }

}
