import '../db_helper/db_manager.dart';
import '../db_model/punch_out_db_model.dart';


class PunchOutDbService {
  late DBManager _dbManager;

  PunchOutDbService() {
    _dbManager = DBManager();
  }

  punchOutTableSave(PunchOutDbModel punchOutDbModel) async {
    return await _dbManager.insertData('punchOut', punchOutDbModel.punchOutDbModelMap());
  }

  punchOutReadAll() async {
    return _dbManager.readData('punchOut');
  }

  punchOutDelete() async {
    return await _dbManager.delete('punchOut');
  }


}
