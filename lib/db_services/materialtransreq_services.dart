import '../db_helper/db_manager.dart';
import '../db_model/mattransreqdet_model.dart';

class MatTransReqDetService{

  late DBManager _dbManager;

  MatTransReqDetService() {
    _dbManager = DBManager();
  }

  MatTransReqDet_Save(List<MatTransDetItemListTableModel> matTransDetItemListTableModel) async {
    matTransDetItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('materialTransReqDet', element.MatTransDetItemListTableMap());
    });
  }

  MatTransReqDet_readAll() async {
    return _dbManager.readData('materialTransReqDet');
  }

  MatTransReqDet_Update(List<MatTransDetItemListTableModel> matTransDetItemListTableModel) async {
    matTransDetItemListTableModel.forEach((element) async {
      return await _dbManager.Update_MaterialTransReqTable('materialTransReqDet', element.MatTransDetItemListTableMap());
    });
  }

  MatTransReqDet_deleteById(List<MatTransDetItemListTableModel> matTransDetItemListTableModel) async {
    matTransDetItemListTableModel.forEach((element) async {
      return await _dbManager.deleteMaterialTransReqById('materialTransReqDet', element.MatTransDetItemListTableMap());
    });
  }

  MatTransReqDet_delete() async {
    return await _dbManager.delete('materialTransReqDet');
  }


}