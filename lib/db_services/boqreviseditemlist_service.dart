import '../db_helper/db_manager.dart';
import '../db_model/boqreviseditemlist_model.dart';

class BoqItemlistService{
  late DBManager _dbManager;
  BoqItemlistService() {
    _dbManager = DBManager();
  }


  BoqItem_table_Save(
      List<BoqItemlist> boqitemlistTableModel) async {
    boqitemlistTableModel.forEach((element) async {
      return await _dbManager.insertData('boqitemListTable', element.BoqItemlistmodelmap());
    });
  }

  BoqItemlist_table_readAll() async {
    return _dbManager.readData('boqitemListTable');
  }

  itemdeleteById(List<BoqItemlist> boqitemlistTableModel) async {
    boqitemlistTableModel.forEach((element) async {
      return await _dbManager.deleteboqitemlById('boqitemListTable', element.BoqItemlistmodelmap());
    });
  }

  BoqItemlist_table_delete() async {
    return await _dbManager.delete('boqitemListTable');
  }

  BoqItemlist_table_Update(
      List<BoqItemlist> boqitemlistTableModel) async {
    boqitemlistTableModel.forEach((element) async {
      return await _dbManager.Update_BoqTable('boqitemListTable', element.BoqItemlistmodelmap());
    });
  }


}