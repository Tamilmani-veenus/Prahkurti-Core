import '../db_helper/db_manager.dart';
import '../db_model/subcont_attendance_det_model.dart';
import '../utilities/apiconstant.dart';

class SubContAttendatanceDetService {
  late DBManager _dbManager;

  SubContAttendatanceDetService() {
    _dbManager = DBManager();
  }

  Future<List<SubContDetModel>> SubContDetSave(
      List<SubContDetModel> subContDetModel) async {

    for (final element in subContDetModel) {

      final insertedId = await _dbManager.insertData(
        'subcontAttendanceDet',
        element.SubContDetMap(),
      );

      element.id = insertedId;
    }

    return subContDetModel;
  }

  SubContDetreadAll() async {
    return  _dbManager.readData('subcontAttendanceDet');
  }

  // SubContDetUpdate(SubContDetModel subContDetModel) async {
  //   return await _dbManager.updateData(
  //       'subcontAttendanceDet', subContDetModel.SubContDetMap());
  // }

  Future<void> SubContDetUpdate(List<SubContDetModel> subContDetModel) async {
    for (final element in subContDetModel) {
      final updateId = element.id ?? element.reqDetId;
      print("Updating ID: ${updateId}");
      print(element.SubContDetMap());

      int result;

      if (!AppClient.isVrindhavana) {
        result = await _dbManager.updateData(
          'subcontAttendanceDet',
          element.SubContDetMap(),
        );
      } else {
        result = await _dbManager.UpdateTableIdSubcontwise(
          'subcontAttendanceDet',
          element.SubContDetMap(),
        );
      }

      print("Update Result: $result");
    }
  }

  SubContDetdeleteById(List<SubContDetModel> subContDetModel) async {
    subContDetModel.forEach((element) async {
      if(!AppClient.isVrindhavana) {
        return await _dbManager.deleteDataById('subcontAttendanceDet', element.SubContDetMap());
      }else{
        return await _dbManager.deleteDataId(
            'subcontAttendanceDet', element.SubContDetMap());
      }
    });
  }

  SubContDetdelete() async {
    return await _dbManager.delete('subcontAttendanceDet');
  }

  SubContDet_OrderBy() async {
    return  await _dbManager.groupBySubcontTable();

  }

}
