// To parse this JSON data, do
//
//     final workOrdDirectEditModel = workOrdDirectEditModelFromJson(jsonString);

import 'dart:convert';

WorkOrdDirectEditModel workOrdDirectEditModelFromJson(String str) => WorkOrdDirectEditModel.fromJson(json.decode(str));

String workOrdDirectEditModelToJson(WorkOrdDirectEditModel data) => json.encode(data.toJson());

class WorkOrdDirectEditModel {
  bool? success;
  Result? result;
  String? message;

  WorkOrdDirectEditModel({
    this.success,
    this.result,
    this.message,
  });

  factory WorkOrdDirectEditModel.fromJson(Map<String, dynamic> json) => WorkOrdDirectEditModel(
    success: json["success"],
    result: Result.fromJson(json["result"]),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
    "message": message
  };
}

class Result {
  int? id;
  String? workOrderNo;
  String? entryDate;
  String? entryType;
  int? projectId;
  int? siteId;
  int? subContractorId;
  double? roundOff;
  double? workOrderAmount;
  double? netAmount;
  String? remarks;
  String? termsCondition;
  String? workStatus;
  String? mailStatus;
  String? downloadStatus;
  String? active;
  int? createdBy;
  String? createdDt;
  int? verifyBy;
  String? verifyStatus;
  String? verifyDt;
  int? approvedBy;
  String? approveStatus;
  String? approveDt;
  String? projectName;
  String? siteName;
  String? createdName;
  String? verifyName;
  String? approveName;
  String? subContractorName;
  String? headItemName;
  String? subHeadItemName;
  String? level3ItemName;
  dynamic? entryTypeName;
  List<SubcontractWorkOrderDetlink>? subcontractWorkOrderDetlink;
  List<SubcontractWorkOrderAddLessSetuplink>? subcontractWorkOrderAddLessSetuplink;

  Result({
    this.id,
    this.workOrderNo,
    this.entryDate,
    this.entryType,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.roundOff,
    this.workOrderAmount,
    this.netAmount,
    this.remarks,
    this.termsCondition,
    this.workStatus,
    this.mailStatus,
    this.downloadStatus,
    this.active,
    this.createdBy,
    this.createdDt,
    this.verifyBy,
    this.verifyStatus,
    this.verifyDt,
    this.approvedBy,
    this.approveStatus,
    this.approveDt,
    this.projectName,
    this.siteName,
    this.createdName,
    this.verifyName,
    this.approveName,
    this.subContractorName,
    this.headItemName,
    this.subHeadItemName,
    this.level3ItemName,
    this.entryTypeName,
    this.subcontractWorkOrderDetlink,
    this.subcontractWorkOrderAddLessSetuplink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workOrderNo: json["workOrderNo"],
    entryDate: json["entryDate"],
    entryType: json["entryType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    roundOff: json["roundOff"],
    workOrderAmount: json["workOrderAmount"],
    netAmount: json["netAmount"],
    remarks: json["remarks"],
    termsCondition: json["termsCondition"],
    workStatus: json["workStatus"],
    mailStatus: json["mailStatus"],
    downloadStatus: json["downloadStatus"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDt: json["verifyDt"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDt: json["approveDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    createdName: json["createdName"],
    verifyName: json["verifyName"],
    approveName: json["approveName"],
    subContractorName: json["subContractorName"],
    headItemName: json["headItemName"],
    subHeadItemName: json["subHeadItemName"],
    level3ItemName: json["level3ItemName"],
    entryTypeName: json["entryTypeName"],
    subcontractWorkOrderDetlink: List<SubcontractWorkOrderDetlink>.from(json["subcontractWorkOrderDetlink"].map((x) => SubcontractWorkOrderDetlink.fromJson(x))),
    subcontractWorkOrderAddLessSetuplink: List<SubcontractWorkOrderAddLessSetuplink>.from(json["subcontractWorkOrderAddLessSetuplink"].map((x) => SubcontractWorkOrderAddLessSetuplink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workOrderNo": workOrderNo,
    "entryDate": entryDate,
    "entryType": entryType,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "roundOff": roundOff,
    "workOrderAmount": workOrderAmount,
    "netAmount": netAmount,
    "remarks": remarks,
    "termsCondition": termsCondition,
    "workStatus": workStatus,
    "mailStatus": mailStatus,
    "downloadStatus": downloadStatus,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDt": verifyDt,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "approveDt": approveDt,
    "projectName": projectName,
    "siteName": siteName,
    "createdName": createdName,
    "verifyName": verifyName,
    "approveName": approveName,
    "subContractorName": subContractorName,
    "headItemName": headItemName,
    "subHeadItemName": subHeadItemName,
    "level3ItemName": level3ItemName,
    "entryTypeName": entryTypeName,
    "subcontractWorkOrderDetlink": List<dynamic>.from(subcontractWorkOrderDetlink!.map((x) => x.toJson())),
    "subcontractWorkOrderAddLessSetuplink": List<dynamic>.from(subcontractWorkOrderAddLessSetuplink!.map((x) => x.toJson())),
  };
}

class SubcontractWorkOrderAddLessSetuplink {
  int? id;
  int? subcontractWorkOrderMasId;
  String? workOrderNo;
  int? addLessId;
  double? percentValue;
  double? amount;

  SubcontractWorkOrderAddLessSetuplink({
    this.id,
    this.subcontractWorkOrderMasId,
    this.workOrderNo,
    this.addLessId,
    this.percentValue,
    this.amount,
  });

  factory SubcontractWorkOrderAddLessSetuplink.fromJson(Map<String, dynamic> json) => SubcontractWorkOrderAddLessSetuplink(
    id: json["id"],
    subcontractWorkOrderMasId: json["subcontractWorkOrderMasId"],
    workOrderNo: json["workOrderNo"],
    addLessId: json["addLessId"],
    percentValue: json["percentValue"],
    amount: json["amount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subcontractWorkOrderMasId": subcontractWorkOrderMasId,
    "workOrderNo": workOrderNo,
    "addLessId": addLessId,
    "percentValue": percentValue,
    "amount": amount,
  };
}

class SubcontractWorkOrderDetlink {
  int? reqDetId;
  int? subcontractWorkOrderMasId;
  int? siteId;
  int? headItemId;
  int? subItemId;
  int? level3ItemId;
  String? boqCode;
  String? itemDesc;
  double? qty;
  String? unit;
  double? rate;
  double? oldRate;
  double? amount;
  String? workRemarks;
  bool? workOrderStatus;

  SubcontractWorkOrderDetlink({
    this.reqDetId,
    this.subcontractWorkOrderMasId,
    this.siteId,
    this.headItemId,
    this.subItemId,
    this.level3ItemId,
    this.boqCode,
    this.itemDesc,
    this.qty,
    this.unit,
    this.rate,
    this.oldRate,
    this.amount,
    this.workRemarks,
    this.workOrderStatus,
  });

  factory SubcontractWorkOrderDetlink.fromJson(Map<String, dynamic> json) => SubcontractWorkOrderDetlink(
    reqDetId: json["id"],
    subcontractWorkOrderMasId: json["subcontractWorkOrderMasId"],
    siteId: json["siteId"],
    headItemId: json["headItemId"],
    subItemId: json["subItemId"],
    level3ItemId: json["level3ItemId"],
    boqCode: json["boqCode"],
    itemDesc: json["itemDescription"],
    qty: json["qty"],
    unit: json["unit"],
    rate: json["rate"],
    oldRate: json["oldRate"],
    amount: json["amount"],
    workRemarks: json["workRemarks"],
    workOrderStatus: json["workOrderStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": reqDetId,
    "subcontractWorkOrderMasId": subcontractWorkOrderMasId,
    "siteId": siteId,
    "headItemId": headItemId,
    "subItemId": subItemId,
    "level3ItemId": level3ItemId,
    "boqCode": boqCode,
    "itemDescription": itemDesc,
    "qty": qty,
    "unit": unit,
    "rate": rate,
    "oldRate": oldRate,
    "amount": amount,
    "workRemarks": workRemarks,
    "workOrderStatus": workOrderStatus,
  };
}
