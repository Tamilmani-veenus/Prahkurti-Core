import '../db_helper/db_manager.dart';
import '../db_model/transferbet_sitewise_itemlistTable_model.dart';


class Transferbet_Site_ItemlistService {
  late DBManager _dbManager;

  Transferbet_Site_ItemlistService() {
    _dbManager = DBManager();
  }

  Transferbet_Site_ItemlistTable_Save(
      List<TransferBet_Site_ItemListTableModel> transferbet_SiteItemListTableModel) async {
    transferbet_SiteItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('transferbetweenSiteWiseItemlistTable', element.TransferBet_Site_ItemListTableMap());
    });
  }

  Transferbet_Site_ItemlistTable_readAll() async {
    return _dbManager.readData('transferbetweenSiteWiseItemlistTable');
  }


  Transferbet_Site_ItemlistTable_Update(
      List<TransferBet_Site_ItemListTableModel> transferbet_SiteItemListTableModel) async {
    transferbet_SiteItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('transferbetweenSiteWiseItemlistTable', element.TransferBet_Site_ItemListTableMap());
    });
  }

  Transferbet_Site_ItemlistTable_deleteById(List<TransferBet_Site_ItemListTableModel> transferbet_SiteItemListTableModel) async {
    transferbet_SiteItemListTableModel.forEach((element) async {
      return await _dbManager.deleteMaterialByIdTransBWSites(
          'transferbetweenSiteWiseItemlistTable', element.TransferBet_Site_ItemListTableMap());
    });
  }


  Transferbet_Site_ItemlistTable_delete() async {
    return await _dbManager.delete('transferbetweenSiteWiseItemlistTable');
  }


}
