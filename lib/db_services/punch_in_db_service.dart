import '../db_helper/db_manager.dart';
import '../db_model/punch_in_db_model.dart';

class PunchInDbService {
  late DBManager _dbManager;

  PunchInDbService() {
    _dbManager = DBManager();
  }

  punchInTableSave(PunchInDbModel punchInDbModel) async {
      return await _dbManager.insertData('punchIn', punchInDbModel.punchInDbModelMap());
  }

  punchInReadAll() async {
    return _dbManager.readData('punchIn');
  }

  punchInDelete() async {
    return await _dbManager.delete('punchIn');
  }


}
