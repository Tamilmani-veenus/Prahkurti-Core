import '../db_helper/db_manager.dart';

import '../db_model/transfer_ackdet_tablemodel.dart';




class TransferAck_DetService {
  late DBManager _dbManager;

  TransferAck_DetService() {
    _dbManager = DBManager();
  }

  TransferAck_DetTable_Save(
      List<TransferAckDetTableModel> transferAckDetTableModel) async {
    transferAckDetTableModel.forEach((element) async {
      return await _dbManager.insertData('transferAcknowDetTableTable', element.TransferAckDetTableMap());
    });
  }

  TransferAck_DetTable_readAll() async {
    return _dbManager.readData('transferAcknowDetTableTable');
  }


  TransferAck_DetTable_Update(
      List<TransferAckDetTableModel> transferAckDetTableModel) async {
    transferAckDetTableModel.forEach((element) async {
      return await _dbManager.TransAckUpdateTableIdwise('transferAcknowDetTableTable', element.TransferAckDetTableMap());
    });
  }

  TransferAck_Det_deleteById(
      List<TransferAckDetTableModel> transferAckDetTableModel) async {
    transferAckDetTableModel.forEach((element) async {
      return await _dbManager.deleteDataById(
          'transferAcknowDetTableTable', element.TransferAckDetTableMap());
    });
  }

  TransferAck_Dettable_delete() async {
    return await _dbManager.delete('transferAcknowDetTableTable');
  }

  TransferAck_Dettable_OrderBy(
      List<TransferAckDetTableModel> transferAckDetTableModel) async {
    transferAckDetTableModel.forEach((element) async {
      return await _dbManager.orderBy(
          'transferAcknowDetTableTable', element.TransferAckDetTableMap());
    });
  }


}
