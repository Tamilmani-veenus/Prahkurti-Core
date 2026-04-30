import 'dart:convert';


List<DailywrkdonDprLabourEditApiRes> dailywrkdonDprLabourEditApiResFromJson(String str) => List<DailywrkdonDprLabourEditApiRes>.from(json.decode(str).map((x) => DailywrkdonDprLabourEditApiRes.fromJson(x)));

String dailywrkdonDprLabourEditApiResToJson(List<DailywrkdonDprLabourEditApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class DailywrkdonDprLabourEditApiRes {
  DailywrkdonDprLabourEditApiRes({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.projectName,
    this.siteName,
    this.subContName,
    this.refNo,
    this.entryType,
    this.entryTypeName,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.dprEditDet,
    this.dprEditLab,
  });

  int?  workId;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContId;
  String? projectName;
  String? siteName;
  String? subContName;
  String? refNo;
  String? entryType;
  String? entryTypeName;
  String? remarks;
  int?  preparedby;
  String? preparedbyName;
  List<DprEditDet>? dprEditDet;
  List<DprEditLab>? dprEditLab;

  factory DailywrkdonDprLabourEditApiRes.fromJson(Map<String, dynamic> json) => DailywrkdonDprLabourEditApiRes(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subContName: json["SubContName"],
    refNo: json["RefNo"],
    entryType: json["EntryType"],
    entryTypeName: json["EntryTypeName"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    dprEditDet: List<DprEditDet>.from(json["DprEditDet"].map((x) => DprEditDet.fromJson(x))),
    dprEditLab: List<DprEditLab>.from(json["DprEditLab"].map((x) => DprEditLab.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SubContName": subContName,
    "RefNo": refNo,
    "EntryType": entryType,
    "EntryTypeName": entryTypeName,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "DprEditDet": List<dynamic>.from(dprEditDet!.map((x) => x.toJson())),
    "DprEditLab": List<dynamic>.from(dprEditLab!.map((x) => x.toJson())),
  };
}

class DprEditDet {
  DprEditDet({
    this.headItemId,
    this.subItemId,
    this.level3ItemId,
    this.woDetId,
    this.boqCode,
    this.itemDesc,
    this.unit,
    this.qty,
    this.rate,
    this.amt,
    this.balQty,
    this.detRemarks,
  });

  int? headItemId;
  int? subItemId;
  int? level3ItemId;
  int? woDetId;
  String? boqCode;
  String? itemDesc;
  String? unit;
  double? qty;
  double? rate;
  double? amt;
  double? balQty;
  String? detRemarks;

  factory DprEditDet.fromJson(Map<String, dynamic> json) => DprEditDet(
    headItemId: json["HeadItemId"],
    subItemId: json["SubItemId"],
    level3ItemId: json["Level3ItemId"],
    woDetId: json["WODetId"],
    boqCode: json["BoqCode"],
    itemDesc: json["ItemDesc"],
    unit: json["Unit"],
    qty: json["Qty"],
    rate: json["Rate"],
    amt: json["Amt"],
    balQty: json["BalQty"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "HeadItemId": headItemId,
    "SubItemId": subItemId,
    "Level3ItemId": level3ItemId,
    "WODetId": woDetId,
    "BoqCode": boqCode,
    "ItemDesc": itemDesc,
    "Unit": unit,
    "Qty": qty,
    "Rate": rate,
    "Amt": amt,
    "BalQty": balQty,
    "DetRemarks": detRemarks,
  };
}

class DprEditLab {
  DprEditLab({
    this.categoryId,
    this.SubContId,
    this.categoryName,
    this.SubContName,
    this.nos,
    this.wages,
    this.otHrs,
    this.otAmt,
    this.amount,
  });

  int? categoryId;
  String? categoryName;
  int? SubContId;
  String? SubContName;
  double? nos;
  double? wages;
  double? otHrs;
  double? otAmt;
  double? amount;

  factory DprEditLab.fromJson(Map<String, dynamic> json) => DprEditLab(
    categoryId: json["CategoryId"],
    SubContId: json["SubContId"],
    categoryName: json["CategoryName"],
    SubContName: json["SubContName"],
    nos: json["Nos"],
    wages: json["Wages"],
    otHrs: json["OTHrs"],
    otAmt: json["OTAmt"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "CategoryId": categoryId,
    "SubContId": SubContId,
    "CategoryName": categoryName,
    "SubContName": SubContName,
    "Nos": nos,
    "Wages": wages,
    "OTHrs": otHrs,
    "OTAmt": otAmt,
    "Amount": amount,
  };
}

