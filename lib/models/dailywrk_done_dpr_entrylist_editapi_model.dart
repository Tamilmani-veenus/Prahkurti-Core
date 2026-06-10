// To parse this JSON data, do
//
//     final dprEditApimodel = dprEditApimodelFromJson(jsonString);

import 'dart:convert';

DprEditApimodel dprEditApimodelFromJson(String str) => DprEditApimodel.fromJson(json.decode(str));

String dprEditApimodelToJson(DprEditApimodel data) => json.encode(data.toJson());

class DprEditApimodel {
  bool? success;
  Result? result;
  String? message;

  DprEditApimodel({
    this.success,
    this.result,
    this.message
  });

  factory DprEditApimodel.fromJson(Map<String, dynamic> json) => DprEditApimodel(
    success: json["success"],
    result: Result.fromJson(json["result"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result,
    "message": message
  };
}

class Result {
  int? id;
  String? workNo;
  String? workDate;
  String? entryType;
  String? workType;
  int? projectId;
  int? siteId;
  int? subContractorId;
  int? dprType;
  String? billStatus;
  double? totalAmount;
  String? refNo;
  String? remarks;
  int? verifyBy;
  String? verifyStatus;
  String? verifyDt;
  int? approveBy;
  String? approveDt;
  String? approveStatus;
  String? projectName;
  String? siteName;
  String? subcontractorName;
  String? createdName;
  String? verifyName;
  String? approvedName;
  String? workTypeDesc;
  String? entryTypeDesc;
  String? status;
  List<SubContractDailyWorkDet>? subContractDailyWorkDets;

  Result({
    this.id,
    this.workNo,
    this.workDate,
    this.entryType,
    this.workType,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.dprType,
    this.billStatus,
    this.totalAmount,
    this.refNo,
    this.remarks,
    this.verifyBy,
    this.verifyStatus,
    this.verifyDt,
    this.approveBy,
    this.approveDt,
    this.approveStatus,
    this.projectName,
    this.siteName,
    this.subcontractorName,
    this.createdName,
    this.verifyName,
    this.approvedName,
    this.workTypeDesc,
    this.entryTypeDesc,
    this.status,
    this.subContractDailyWorkDets,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    entryType: json["entryType"],
    workType: json["workType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    dprType: json["dprType"],
    billStatus: json["billStatus"],
    totalAmount: json["totalAmount"],
    refNo: json["refNo"],
    remarks: json["remarks"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDt: json["verifyDt"],
    approveBy: json["approveBy"],
    approveDt: json["approveDt"],
    approveStatus: json["approveStatus"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subcontractorName: json["subcontractorName"],
    createdName: json["createdName"],
    verifyName: json["verifyName"],
    approvedName: json["approvedName"],
    workTypeDesc: json["workTypeDesc"],
    entryTypeDesc: json["entryTypeDesc"],
    status: json["Status"],
    subContractDailyWorkDets: List<SubContractDailyWorkDet>.from(json["subContractDailyWorkDets"].map((x) => SubContractDailyWorkDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "workDate": workDate,
    "entryType": entryType,
    "workType": workType,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "dprType": dprType,
    "billStatus": billStatus,
    "totalAmount": totalAmount,
    "refNo": refNo,
    "remarks": remarks,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDt": verifyDt,
    "approveBy": approveBy,
    "approveDt": approveDt,
    "approveStatus": approveStatus,
    "projectName": projectName,
    "siteName": siteName,
    "subcontractorName": subcontractorName,
    "createdName": createdName,
    "verifyName": verifyName,
    "approvedName": approvedName,
    "workTypeDesc": workTypeDesc,
    "entryTypeDesc": entryTypeDesc,
    "Status": status,
    "subContractDailyWorkDets": List<dynamic>.from(subContractDailyWorkDets!.map((x) => x.toJson())),
  };
}

class SubContractDailyWorkDet {
  int? id;
  int? subContractDailyWorkMasId;
  int? headItemId;
  int? subItemId;
  String? boqCode;
  String? itemDesc;
  int? unit;
  double? rate;
  double? qty;
  double? amt;
  double? cement;
  int? level3ItemId;
  String? scaleName;
  String? workRemarks;
  int? woDetId;
  int? scaleId;
  String? billStatus;
  double? balQty;
  double? avgLabRate;
  String? workType;
  int? siteId;
  String? siteName;
  String? active;

  SubContractDailyWorkDet({
    this.id,
    this.subContractDailyWorkMasId,
    this.headItemId,
    this.subItemId,
    this.boqCode,
    this.itemDesc,
    this.unit,
    this.rate,
    this.qty,
    this.amt,
    this.cement,
    this.level3ItemId,
    this.scaleName,
    this.workRemarks,
    this.woDetId,
    this.scaleId,
    this.billStatus,
    this.balQty,
    this.avgLabRate,
    this.workType,
    this.siteId,
    this.siteName,
    this.active,
  });

  factory SubContractDailyWorkDet.fromJson(Map<String, dynamic> json) => SubContractDailyWorkDet(
    id: json["id"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    headItemId: json["headItemId"],
    subItemId: json["subItemId"],
    boqCode: json["boqcode"],
    itemDesc: json["itemdesc"],
    unit: json["unit"],
    rate: json["Rate"],
    qty: json["Qty"],
    amt: json["amount"],
    cement: json["Cement"],
    level3ItemId: json["level3ItemId"],
    scaleName: json["scaleName"],
    workRemarks: json["workRemarks"],
    woDetId: json["subContarctWorkdetid"],
    scaleId: json["scaleId"],
    billStatus: json["billStatus"],
    balQty: json["balqty"],
    avgLabRate: json["avgLabRate"],
    workType: json["workType"],
    siteId: json["siteId"],
    siteName: json["siteName"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "headItemId": headItemId,
    "subItemId": subItemId,
    "boqcode": boqCode,
    "itemdesc": itemDesc,
    "unit": unit,
    "Rate": rate,
    "Qty": qty,
    "amount": amt,
    "Cement": cement,
    "level3ItemId": level3ItemId,
    "scaleName": scaleName,
    "workRemarks": workRemarks,
    "subContarctWorkdetid": woDetId,
    "scaleId": scaleId,
    "billStatus": billStatus,
    "balqty": balQty,
    "avgLabRate": avgLabRate,
    "workType": workType,
    "siteId": siteId,
    "siteName": siteName,
    "active": active,
  };
}
