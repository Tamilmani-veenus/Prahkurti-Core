import '../db_helper/db_manager.dart';
import '../db_model/companynmr_atd_labourlist_dbmodel.dart';


class CompanyNMR_DetService {
  late DBManager _dbManager;

  CompanyNMR_DetService() {
    _dbManager = DBManager();
  }

  CompanyNMR_DetTable_Save(
      List<CompanyNMRDetTableModel> companyNMRDetTableModel) async {
    companyNMRDetTableModel.forEach((element) async {
      return await _dbManager.insertData('companyNMRDetTable', element.CompanyNMRDetTableMap());
    });
  }

  CompanyNMR_DetTable_readAll() async {
    return _dbManager.readData('companyNMRDetTable');
  }


  CompanyNMR_DetTable_Update(
      List<CompanyNMRDetTableModel> companyNMRDetTableModel) async {
    companyNMRDetTableModel.forEach((element) async {
      return await _dbManager.companyNMrTableIdwise('companyNMRDetTable', element.CompanyNMRDetTableMap());
    });
  }

  CompanyNMR_Det_deleteById(
      List<CompanyNMRDetTableModel> companyNMRDetTableModel) async {
    companyNMRDetTableModel.forEach((element) async {
      return await _dbManager.deletelabourById(
          'companyNMRDetTable', element.CompanyNMRDetTableMap());
    });
  }

  CompanyNMR_Dettable_delete() async {
    return await _dbManager.delete('companyNMRDetTable');
  }

  CompanyNMR_Dettable_OrderBy(
      List<CompanyNMRDetTableModel> companyNMRDetTableModel) async {
    companyNMRDetTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'companyNMRDetTable', element.CompanyNMRDetTableMap());
    });
  }


}
