import '../db_helper/db_manager.dart';
import '../db_model/login_details_model.dart';

class LoginDetailsService {
  late DBManager _dbManager;

  LoginDetailsService() {
    _dbManager = DBManager();
  }


  loginDetailsTableSave(
      List<LoginDetailsModel> loginDetailsModel) async {
    loginDetailsModel.forEach((element) async {
      return await _dbManager.insertData('loginDetailsTable', element.loginDetailsModelMap());
    });
  }

  loginDetailsReadAll() async {
    return _dbManager.readData('loginDetailsTable');
  }

  loginDetailsDelete() async {
    return await _dbManager.delete('loginDetailsTable');
  }


}
