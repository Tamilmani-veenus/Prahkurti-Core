import 'package:sqflite/sqflite.dart';

import '../db_helper/db_manager.dart';
import '../db_model/advReqvoucher_itemlistTable_model.dart';

class AdvreqVoucher_ItemlistService {
  late DBManager _dbManager;

  AdvreqVoucher_ItemlistService() {
    _dbManager = DBManager();
  }

AdvreqVoucher_ItemlistTable_Save(
      List<AdvReqVoucherItemListTableModel> items) async {
    final db = await _dbManager.database;

    for (var item in items) {
      await db?.insert(
        'advanceReqvoucherItemlistTable',
        item.AdvReqVoucherItemListTableMap(),
        conflictAlgorithm: ConflictAlgorithm.replace, // prevents duplicates
      );
    }
  }


  AdvreqVoucher_ItemlistTable_readAll() async {
    return _dbManager.readData('advanceReqvoucherItemlistTable');
  }


  AdvreqVoucher_ItemlistTable_Update(
      List<AdvReqVoucherItemListTableModel> advreqVoucher_ItemlistTableModel) async {
    advreqVoucher_ItemlistTableModel.forEach((element) async {
      return await _dbManager.UpdateTableIdwise('advanceReqvoucherItemlistTable', element.AdvReqVoucherItemListTableMap());
    });
  }

  AdvreqVoucher_ItemlistTable_deleteById(
      List<AdvReqVoucherItemListTableModel> advreqVoucher_ItemlistTableModel) async {
    advreqVoucher_ItemlistTableModel.forEach((element) async {
      return await _dbManager.deletesiteWise(
          'advanceReqvoucherItemlistTable', element.AdvReqVoucherItemListTableMap());
    });
  }

  AdvreqVoucher_ItemlistTable_delete() async {
    return await _dbManager.delete('advanceReqvoucherItemlistTable');
  }


}
