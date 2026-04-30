import '../db_helper/db_manager.dart';
import '../db_model/staffvoucherdetsite_model.dart';

class StaffvouchersitelistService{
  late DBManager _dbManager;
  StaffvouchersitelistService() {
    _dbManager = DBManager();
  }

  StaffvoucherSiteItemlist_table_Save(
      List<StaffvouchersiteDetlist> StaffvoucherSiteItemListTableModel) async {
    StaffvoucherSiteItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('staffvouchersite', element.StaffvouchersiteDetlistmodelmap());
    });
  }

  StaffvoucherSiteItemlist_table_readAll() async {
    return _dbManager.readData('staffvouchersite');
  }

  StaffvoucherSitedeleteById(List<StaffvouchersiteDetlist> StaffvoucherSiteItemListTableModel) async {
    StaffvoucherSiteItemListTableModel.forEach((element) async {
      return await _dbManager.deletestaffvouchersiteById('staffvouchersite', element.StaffvouchersiteDetlistmodelmap());
    });
  }

  StaffvoucherSiteItemlist_table_delete() async {
    return await _dbManager.delete('staffvouchersite');
  }

}