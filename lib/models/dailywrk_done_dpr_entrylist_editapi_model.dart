import 'dart:convert';

List<DailywrkDoneDprEntrylistEditApiResmodel> dailywrkDoneDprEntrylistEditApiResmodelFromJson(String str) => List<DailywrkDoneDprEntrylistEditApiResmodel>.from(json.decode(str).map((x) => DailywrkDoneDprEntrylistEditApiResmodel.fromJson(x)));

String dailywrkDoneDprEntrylistEditApiResmodelToJson(List<DailywrkDoneDprEntrylistEditApiResmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailywrkDoneDprEntrylistEditApiResmodel {
  DailywrkDoneDprEntrylistEditApiResmodel({
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
  });

  int? workId;
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
  int? preparedby;
  String? preparedbyName;
  List<DprEditDet>? dprEditDet;

  factory DailywrkDoneDprEntrylistEditApiResmodel.fromJson(Map<String, dynamic> json) => DailywrkDoneDprEntrylistEditApiResmodel(
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
    this.rate,
    this.qty,
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
  double? rate;
  double? qty;
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
    rate: json["Rate"].toDouble(),
    qty: json["Qty"].toDouble(),
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
    "Rate": rate,
    "Qty": qty,
    "Amt": amt,
    "BalQty": balQty,
    "DetRemarks": detRemarks,
  };
}
