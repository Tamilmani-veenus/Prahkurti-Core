
import '../db_helper/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  DBManager() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;
  late DatabaseConnection _databaseConnection;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var connection =  _database;
    return await connection?.insert(table, data);
  }

  insert_data(table, data) async {
    var connection =  _database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection =  _database;
    return await connection?.query(table);
  }

  readDataById(table, itemId) async {
    var connection =  _database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var connection =  _database;
    return await connection
        ?.update(table, data, where: 'catId=? AND siteId=?', whereArgs: [data['catId'],data['siteId']]);
  }

  groupBySubcontTable()async{
    var connection =  _database;
    return await connection?.rawQuery("select id,catId,catName,wages,nos,netAmt,remarks,siteId,siteName,MrgOtHrs,MrgOtAmt,EvgOtHrs,EvgOtAmt,EvgExtrsAmt,Extra from subcontAttendanceDet group by siteId,catId");
  }



  deleteDataById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where catId=? AND siteId=?',[data['catId'],data['siteId']]);
  }

  deletelabourById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where labourId=?',[data['labourId']]);
  }

  delete(table) async {
    var connection =  _database;
    return await connection?.rawDelete("delete from $table");
  }

  directTransfer_deleteDataById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where materialId=?',[data['materialId']]);
  }


  orderBy(table, data)async{
    var connection =  _database;
    return await connection?.query(table,columns: ['headItemId','subItemId','boqCode'], where:'headItemId=?',whereArgs: [data['headItemId']]);
  }


  Update_dprItemlistTable(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'level3ItemId=?', whereArgs: [data['level3ItemId']]);
  }

  Update_dpr_NewLabourTable(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'catId=?', whereArgs: [data['catId']]);
  }

  Update_dpr_NewMaterialTable(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'MatId=?', whereArgs: [data['MatId']]);
  }

  dpr_NewMaterialTable_deleteDataByName(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where MatId=? AND Qty=?',[data['MatId'],data['Qty']]);
  }

  UpdateTableIdwise_AdvReqVou(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'PurOrdMasId=?', whereArgs: [data['PurOrdMasId']]);
  }

  UpdateTableIdwise(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  TransAckUpdateTableIdwise(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'transferDetId=?', whereArgs: [data['transferDetId']]);
  }

  companyNMrTableIdwise(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'labourId=?', whereArgs: [data['labourId']]);
  }


  dpr_NewMSRTable_deleteDataByName(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where id=?',[data['id']]);
  }


  dprLabour_deleteDataById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where catId=? AND subId=?',[data['catId'],data['subId']]);
  }

  dprLabour_UpdateDataById(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'catId=? AND subId=?', whereArgs: [data['catId'],data['subId']]);
  }

  directBill_deleteDataById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where id=?',[data['id']]);
  }
  deleteMaterialById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where materialid=?',[data['materialid']]);
  }
  deletesiteWise(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where siteId=?',[data['siteId']]);
  }

  deleteAdvReqVousiteWise(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where OrderNo=?',[data['OrderNo']]);
  }

  deletesiteById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where siteid=? AND paytype = ?',[data['siteid'], data['paytype']]);
  }

  deletestaffvouchersiteById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where siteid=?',[data['siteid']]);
  }

  deleteMaterialByIdTransBWSites(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where materialId=?',[data['materialId']]);
  }

  deleteMaterialTransReqById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where materialId=?',[data['materialId']]);
  }

  deletDPRWrkById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where woDetId=?',[data['woDetId']]);
  }

  Update_MaterialTable(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'materialid=?', whereArgs: [data['materialid']]);
  }

  Update_MaterialTransReqTable(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'materialId=?', whereArgs: [data['materialId']]);
  }


  deleteboqitemlById(table, data) async {
    var connection =  _database;
    return await connection?.rawDelete('delete from $table where Level3item_id=?',[data['Level3item_id']]);
  }

  Update_BoqTable(table, data) async {
    var connection =  _database;
    return await connection?.update(table, data, where: 'Level3item_id=?', whereArgs: [data['Level3item_id']]);
  }
}
