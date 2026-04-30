import '../db_helper/db_manager.dart';
import '../db_model/sitevoucherdet_model.dart';

class SitevoucherlistService{
  late DBManager _dbManager;
  SitevoucherlistService() {
    _dbManager = DBManager();
  }

  SitevoucherItemlist_table_Save(
      List<SitevoucherDetlist> SitevoucherItemListTableModel) async {
    SitevoucherItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('sitevoucherListTable', element.SitevoucherDetlistmodelmap());
    });
  }

  SitevoucherItemlist_table_readAll() async {
    return _dbManager.readData('sitevoucherListTable');
  }

  SitevoucherdeleteById(List<SitevoucherDetlist> consumItemListTableModel) async {
    consumItemListTableModel.forEach((element) async {
      return await _dbManager.deletesiteById('sitevoucherListTable', element.SitevoucherDetlistmodelmap());
    });
  }

  SitevoucherItemlist_table_delete() async {
    return await _dbManager.delete('sitevoucherListTable');
  }


}