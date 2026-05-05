import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var dierctory = await getApplicationDocumentsDirectory();
    var path = join(dierctory.path, 'cms_erp_db');
    var db = await openDatabase(path, version: 3, onCreate: _createDatabase,onUpgrade: _upgradeDatabase);
    return db;
  }


  Future<void> _createDatabase(Database database, int version) async {

    String subcontDetTable = "CREATE TABLE subcontAttendanceDet (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,catId INTEGER,catName TEXT,wages REAL,nos TEXT,netAmt REAL,remarks TEXT,siteId INTEGER,siteName TEXT,MrgOtHrs REAL,MrgOtAmt REAL,EvgOtHrs REAL,EvgOtAmt REAL,EvgExtrsAmt REAL,Extra REAL,reqDetId INTEGER)";
    await database.execute(subcontDetTable);

    String dprItemListTable = "CREATE TABLE dprItemListTable (id INTEGER PRIMARY KEY UNIQUE,headItemId INTEGER,subItemId INTEGER,level3ItemId INTEGER,woDetId INTEGER,boqCode INTEGER,itemDesc TEXT,unit TEXT,rate REAL,qty REAL,amt REAL,balQty REAL)";
    await database.execute(dprItemListTable);

    String dprNewMassTable = "CREATE TABLE dprNewMassTable (id INTEGER PRIMARY KEY UNIQUE,autoNo TEXT,date TEXT,projectId INTEGER,projectName TEXT,sitetId INTEGER,sitetName TEXT,entryType TEXT,subcontId INTEGER,subcontName TEXT,refNo TEXT,prepBy TEXT,remarks TEXT)";
    await database.execute(dprNewMassTable);

    String dprNewDetTable = "CREATE TABLE dprNewDetTable (id INTEGER PRIMARY KEY UNIQUE,headItemId INTEGER,subItemId INTEGER,level3ItemId INTEGER,woDetId INTEGER,itemDesc TEXT,units TEXT,rate REAL,qty REAL,amt REAL,balQty REAL,boqCode Text)";
    await database.execute(dprNewDetTable);

    String dprNewLabourTable = "CREATE TABLE dprNewLabourTable (id INTEGER PRIMARY KEY UNIQUE,catId INTEGER,catName TEXT,wages REAL,nos TEXT,otHrs TEXT,otAmt REAL,netAmt REAL,remarks TEXT)";
    await database.execute(dprNewLabourTable);

    String dprNewMaterialTable = "CREATE TABLE dprNewMaterialTable (id INTEGER PRIMARY KEY UNIQUE,MatId INTEGER,Name TEXT,Scale Text,Qty REAL)";
    await database.execute(dprNewMaterialTable);

    String dprNewMSRTable = "CREATE TABLE dprNewMSRTable (id INTEGER PRIMARY KEY UNIQUE,Name TEXT,nos Text,length REAL,breath REAL,depth REAL,qty REAL)";
    await database.execute(dprNewMSRTable);

    String dprLabourLabScreenTable = "CREATE TABLE dprLabourLabScreenTable (id INTEGER PRIMARY KEY UNIQUE,catId INTEGER,catName TEXT,subId INTEGER,subName Text,wages REAL,nos TEXT,otHrs TEXT,otAmt REAL,netAmt REAL,remarks TEXT)";
    await database.execute(dprLabourLabScreenTable);

    String dprLabourDetTable = "CREATE TABLE dprLabourDetTable (id INTEGER PRIMARY KEY UNIQUE,headItemId INTEGER,subItemId INTEGER,level3ItemId INTEGER,woDetId INTEGER,itemDesc TEXT,units TEXT,rate REAL,qty REAL,amt REAL,balQty REAL,boqCode Text)";
    await database.execute(dprLabourDetTable);

    String directBillGenItemlistTable = "CREATE TABLE directBillGenItemlistTable (id INTEGER PRIMARY KEY UNIQUE,Name TEXT,unit TEXT,qty REAL,rate REAL,amount REAL)";
    await database.execute(directBillGenItemlistTable);

    String inwardPendingItemlistTable = "CREATE TABLE inwardPendingItemlistTable (id INTEGER PRIMARY KEY UNIQUE,poDetId INTEGER,materialId INTEGER,materialName TEXT,unit TEXT,poQty REAL,balQty REAL,rate REAL,inwQty REAL,amdCheck INTEGER,addQty REAL,lessQty REAL,scaleId INTEGER)";
    await database.execute(inwardPendingItemlistTable);

    String transferbetweenItemlistTable = "CREATE TABLE transferbetweenItemlistTable (id INTEGER PRIMARY KEY UNIQUE,materialId INTEGER,materialName TEXT,scale TEXT,stockQty REAL,Qty REAL,balQty REAL,reqDetId INTEGER,rate REAL,amount REAL,scaleId INTEGER,transReqDetId INTEGER,reqMasDetId INTEGER)";
    await database.execute(transferbetweenItemlistTable);

    String transferbetweenSiteWiseItemlistTable = "CREATE TABLE transferbetweenSiteWiseItemlistTable (id INTEGER PRIMARY KEY UNIQUE,materialId INTEGER,materialName TEXT,scale TEXT,stockQty REAL,Qty REAL,balQty REAL,reqDetId INTEGER,StSDetId INTEGER,rate REAL,amount REAL)";
    await database.execute(transferbetweenSiteWiseItemlistTable);

    String advanceReqvoucherItemlistTable = "CREATE TABLE advanceReqvoucherItemlistTable (id INTEGER PRIMARY KEY UNIQUE,siteId INTEGER,siteName TEXT,paymentType TEXT,amount REAL,tds_percent REAL,tds_amount REAL,netAmount REAL)";
    await database.execute(advanceReqvoucherItemlistTable);


    String sitevoucherListTable = "CREATE TABLE sitevoucherListTable (id INTEGER PRIMARY KEY UNIQUE,siteid INTEGER,paytype TEXT,sitename TEXT,amt REAL,TdsPer REAL,TdsAmt REAL,NetAmt REAL,reqDetId INTEGER)";
    await database.execute(sitevoucherListTable);

    String staffvouchersite = "CREATE TABLE staffvouchersite (id INTEGER PRIMARY KEY UNIQUE,siteid INTEGER,projectid INTEGER,paytype TEXT,sitename TEXT,projectname TEXT,amt REAL,TdsPer REAL,TdsAmt REAL,NetAmt REAL)";
    await database.execute(staffvouchersite);

    String materialApprovalListTable = "CREATE TABLE materialApprovalListTable (id INTEGER PRIMARY KEY UNIQUE,materialid INTEGER,reqDetId INTEGER,materialname TEXT,scale TEXT,balqty REAL,reqqty REAL,appqty REAL,apptype TEXT,tranfromprjid TEXT,tranfromprjname TEXT,remarks TEXT,desc TEXT,scaleId INTEGER)";
    await database.execute(materialApprovalListTable);

    String materialListTable = "CREATE TABLE materialListTable (id INTEGER PRIMARY KEY UNIQUE,materialid INTEGER,material TEXT,scale TEXT,balqty REAL,qty REAL,reqQty REAL,stockqty REAL,remarks TEXT,desc TEXT,scaleId INTEGER,reqDetId INTEGER)";
    await database.execute(materialListTable);

    String consumItemListTable = "CREATE TABLE consumItemListTable (id INTEGER PRIMARY KEY UNIQUE,materialid INTEGER,material TEXT,scale TEXT,stockqty REAL,usageqty REAL,scaleId INTEGER,reqDetId INTEGER)";
    await database.execute(consumItemListTable);

    String boqitemListTable = "CREATE TABLE boqitemListTable (id INTEGER PRIMARY KEY UNIQUE,HdNme_Id INTEGER,SbNme_Id INTEGER,Level3item_id INTEGER,itemdesc TEXT,Unit TEXT,Rate REAL,Qty REAL,Amt REAL)";
    await database.execute(boqitemListTable);

    String transferAcknowDetTableTable = "CREATE TABLE transferAcknowDetTableTable (id INTEGER PRIMARY KEY UNIQUE,transferDetId INTEGER,materialName Text,materialId INTEGER,scale TEXT,transQty REAL,ackQty REAL,detRemarks TEXT)";
    await database.execute(transferAcknowDetTableTable);

    String companyNMRDetTable = "CREATE TABLE companyNMRDetTable (id INTEGER PRIMARY KEY UNIQUE,labourId INTEGER,labourName Text,Labour_No TEXT,categaryName TEXT,wages REAL,shift TEXT,status TEXT,busfare REAL,othrs REAL,advance REAL,detRemarks TEXT)";
    await database.execute(companyNMRDetTable);

    String advReqVoucherSitewisePayTable = "CREATE TABLE advReqVoucherSitewisePayTable (id INTEGER PRIMARY KEY UNIQUE,PurOrdMasId  INTEGER,OrderNo Text,Project TEXT,ProjectId INTEGER,SiteName TEXT,SiteId INTEGER,DPRAmt REAL,AdvanceAmt REAL,BAmount REAL,Amount REAL,paymentType TEXT)";
    await database.execute(advReqVoucherSitewisePayTable);

    String loginDetailsTable = "CREATE TABLE loginDetailsTable (id INTEGER PRIMARY KEY UNIQUE,userId INTEGER,userName Text,userType TEXT,userActive TEXT,userAppActive INTEGER,empId INTEGER,empName TEXT)";
    await database.execute(loginDetailsTable);

    String siteLocation = "CREATE TABLE siteLocation (id INTEGER PRIMARY KEY UNIQUE,siteId INTEGER,siteName Text,locid INTEGER,pinStatus TEXT,radius INTEGER,longitude TEXT,latitude TEXT)";
    await database.execute(siteLocation);

    String punchIn = "CREATE TABLE punchIn (id INTEGER PRIMARY KEY UNIQUE,empId Text,dateIn Text,entryMode Text,locId TEXT,userId TEXT,deviceName TEXT,punchTimeIn TEXT,imagePath TEXT)";
    await database.execute(punchIn);

    String punchOut = "CREATE TABLE punchOut (id INTEGER PRIMARY KEY UNIQUE,empId Text,date Text,timeOut Text,entryMode TEXT,userId TEXT,deviceName TEXT,locId TEXT)";
    await database.execute(punchOut);

    String materialTransReqDetTable = "CREATE TABLE materialTransReqDet (id INTEGER PRIMARY KEY UNIQUE,reqDetId INTEGER,materialId INTEGER,materialName TEXT,scale TEXT,stockQty REAL,Qty REAL,trQty REAL,detRemarks TEXT)";
    await database.execute(materialTransReqDetTable);

  }
  Future<void> _upgradeDatabase(Database database, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await database.execute('''CREATE TABLE materialTransReqDet (
        id INTEGER PRIMARY KEY UNIQUE,
        reqDetId INTEGER,
        materialId INTEGER,
        materialName TEXT,
        scale TEXT,
        stockQty REAL,
        Qty REAL,
        detRemarks TEXT
      )''');
    }
    if (oldVersion < 3) {
      await database.execute(
          "ALTER TABLE materialListTable ADD COLUMN scaleId INTEGER"
      );
      await database.execute(
          "ALTER TABLE materialListTable ADD COLUMN reqDetId INTEGER"
      );
      await database.execute(
          "ALTER TABLE materialApprovalListTable ADD COLUMN scaleId INTEGER"
      );
      await database.execute(
          "ALTER TABLE consumItemListTable ADD COLUMN scaleId INTEGER"
      );
      await database.execute(
          "ALTER TABLE consumItemListTable ADD COLUMN reqDetId INTEGER"
      );
      await database.execute(
          "ALTER TABLE transferbetweenItemlistTable ADD COLUMN scaleId INTEGER"
      );
      await database.execute(
          "ALTER TABLE transferbetweenItemlistTable ADD COLUMN transReqDetId INTEGER"
      );
      await database.execute(
          "ALTER TABLE transferbetweenItemlistTable ADD COLUMN reqMasDetId INTEGER"
      );
      await database.execute(
          "ALTER TABLE inwardPendingItemlistTable ADD COLUMN scaleId INTEGER"
      );
      await database.execute(
          "ALTER TABLE transferbetweenSiteWiseItemlistTable ADD COLUMN StSDetId INTEGER"
      );
      await database.execute(
          "ALTER TABLE subcontAttendanceDet ADD COLUMN reqDetId INTEGER"
      );
      await database.execute(
          "ALTER TABLE materialListTable ADD COLUMN reqQty INTEGER"
      );
      await database.execute(
          "ALTER TABLE materialTransReqDet ADD COLUMN trQty INTEGER"
      );
      await database.execute(
          "ALTER TABLE sitevoucherListTable ADD COLUMN reqDetId INTEGER"
      );
    }


  }
}
