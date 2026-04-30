import '../db_helper/db_manager.dart';
import '../db_model/transbet_itemlistTable_model.dart';

class Transferbet_ItemlistService {
  late DBManager _dbManager;

  Transferbet_ItemlistService() {
    _dbManager = DBManager();
  }

  Transferbet_ItemlistTable_Save(List<TransferBetItemListTableModel> transferbetItemListTableModel) async {
    transferbetItemListTableModel.forEach((element) async {
      return await _dbManager.insertData('transferbetweenItemlistTable', element.TransferBetItemListTableMap());
    });
  }

  Transferbet_ItemlistTable_readAll() async {
    return _dbManager.readData('transferbetweenItemlistTable');
  }


  Transferbet_ItemlistTable_Update(List<TransferBetItemListTableModel> transferbetItemListTableModel) async {
    transferbetItemListTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('transferbetweenItemlistTable', element.TransferBetItemListTableMap());
    });
  }

  Transferbet_ItemlistTable_deleteById(
      List<TransferBetItemListTableModel> transferbetItemListTableModel) async {
    transferbetItemListTableModel.forEach((element) async {
      return await _dbManager.directTransfer_deleteDataById(
          'transferbetweenItemlistTable', element.TransferBetItemListTableMap());
    });
  }

  Transferbet_ItemlistTable_delete() async {
    return await _dbManager.delete('transferbetweenItemlistTable');
  }


}
