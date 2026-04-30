import 'dart:convert';


List<DailywrkdonDprNewEditApiRes> dailywrkdonDprNewEditApiResFromJson(String str) => List<DailywrkdonDprNewEditApiRes>.from(json.decode(str).map((x) => DailywrkdonDprNewEditApiRes.fromJson(x)));

String dailywrkdonDprNewEditApiResToJson(List<DailywrkdonDprNewEditApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class DailywrkdonDprNewEditApiRes {
  DailywrkdonDprNewEditApiRes({
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
    this.dprEditMaterial,
    this.dprEditMeasurement,
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
  List<DprEditMaterial>? dprEditMaterial;
  List<DprEditMeasurement>? dprEditMeasurement;

  factory DailywrkdonDprNewEditApiRes.fromJson(Map<String, dynamic> json) => DailywrkdonDprNewEditApiRes(
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
    dprEditMaterial: List<DprEditMaterial>.from(json["DprEditMaterial"].map((x) => DprEditMaterial.fromJson(x))),
    dprEditMeasurement: List<DprEditMeasurement>.from(json["DprEditMeasurement"].map((x) => DprEditMeasurement.fromJson(x))),
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
    "DprEditMaterial": List<dynamic>.from(dprEditMaterial!.map((x) => x.toJson())),
    "DprEditMeasurement": List<dynamic>.from(dprEditMeasurement!.map((x) => x.toJson())),
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
    this.categoryName,
    this.nos,
    this.wages,
    this.otHrs,
    this.otAmt,
    this.amount,
  });

  int? categoryId;
  String? categoryName;
  double? nos;
  double? wages;
  double? otHrs;
  double? otAmt;
  double? amount;

  factory DprEditLab.fromJson(Map<String, dynamic> json) => DprEditLab(
    categoryId: json["CategoryId"],
    categoryName: json["CategoryName"],
    nos: json["Nos"],
    wages: json["Wages"],
    otHrs: json["OTHrs"],
    otAmt: json["OTAmt"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "CategoryId": categoryId,
    "CategoryName": categoryName,
    "Nos": nos,
    "Wages": wages,
    "OTHrs": otHrs,
    "OTAmt": otAmt,
    "Amount": amount,
  };
}

class DprEditMaterial {
  DprEditMaterial({
    this.materialId,
    this.materialName,
    this.unit,
    this.qty,
  });

  int?  materialId;
  String? materialName;
  String? unit;
  double? qty;

  factory DprEditMaterial.fromJson(Map<String, dynamic> json) => DprEditMaterial(
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    unit: json["Unit"],
    qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Unit": unit,
    "Qty": qty,
  };
}

class DprEditMeasurement {
  DprEditMeasurement({
    this.workDesc,
    this.n,
    this.l,
    this.b,
    this.d,
    this.qty,
  });

  String? workDesc;
  double? n;
  double? l;
  double? b;
  double? d;
  double? qty;

  factory DprEditMeasurement.fromJson(Map<String, dynamic> json) => DprEditMeasurement(
    workDesc: json["WorkDesc"],
    n: json["N"],
    l: json["L"],
    b: json["B"],
    d: json["D"],
    qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "WorkDesc": workDesc,
    "N": n,
    "L": l,
    "B": b,
    "D": d,
    "Qty": qty,
  };
}

