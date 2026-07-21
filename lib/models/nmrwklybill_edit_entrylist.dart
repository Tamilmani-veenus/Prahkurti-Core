// To parse this JSON data, do
//
//     final nmrEditResponse = nmrEditResponseFromJson(jsonString);

import 'dart:convert';

NmrEditResponse nmrEditResponseFromJson(String str) => NmrEditResponse.fromJson(json.decode(str));

String nmrEditResponseToJson(NmrEditResponse data) => json.encode(data.toJson());

class NmrEditResponse {
  bool? success;
  String? message;
  Result? result;

  NmrEditResponse({
    this.success,
    this.message,
    this.result,
  });

  factory NmrEditResponse.fromJson(Map<String, dynamic> json) => NmrEditResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?null:result!.toJson(),
  };
}

class Result {
  int? id;
  String? workNo;
  String? entryDate;
  int? projectId;
  int? siteId;
  int? subContractorId;
  String? fromDate;
  String? toDate;
  String? billNo;
  double? billAmount;
  double? netBillAmount;
  double? foodAmount;
  double? bankCharges;
  double? debitAmount;
  String? debitRemarks;
  double? creditAmount;
  String? creditRemarks;
  double? advanceAmount;
  double? actualAdvanceAmount;
  double? roundOff;
  double? netPayAmount;
  double? balanceAmount;
  String? remarks;
  String? projectName;
  String? siteName;
  String? subContractorName;
  String? createdName;
  String? status;
  dynamic appSts;
  dynamic verSts;
  List<SubContractorNmrBillDet>? subContractorNmrBillDetS;
  List<SubContractorNmrBillAddLessSetup>? subContractorNmrBillAddLessSetupS;

  Result({
    this.id,
    this.workNo,
    this.entryDate,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.fromDate,
    this.toDate,
    this.billNo,
    this.billAmount,
    this.netBillAmount,
    this.foodAmount,
    this.bankCharges,
    this.debitAmount,
    this.debitRemarks,
    this.creditAmount,
    this.creditRemarks,
    this.advanceAmount,
    this.actualAdvanceAmount,
    this.roundOff,
    this.netPayAmount,
    this.balanceAmount,
    this.remarks,
    this.projectName,
    this.siteName,
    this.subContractorName,
    this.createdName,
    this.status,
    this.appSts,
    this.verSts,
    this.subContractorNmrBillDetS,
    this.subContractorNmrBillAddLessSetupS,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    entryDate: json["entryDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    billNo: json["billNo"],
    billAmount: json["billAmount"],
    netBillAmount: json["netBillAmount"],
    foodAmount: json["foodAmount"],
    bankCharges: json["bankCharges"],
    debitAmount: json["debitAmount"],
    debitRemarks: json["debitRemarks"],
    creditAmount: json["creditAmount"],
    creditRemarks: json["creditRemarks"],
    advanceAmount: json["advanceAmount"],
    actualAdvanceAmount: json["actualAdvanceAmount"],
    roundOff: json["roundOff"],
    netPayAmount: json["netPayAmount"].toDouble(),
    balanceAmount: json["balanceAmount"],
    remarks: json["remarks"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractorName: json["subContractorName"],
    createdName: json["createdName"],
    status: json["status"],
    appSts: json["appSts"],
    verSts: json["verSts"],
    subContractorNmrBillDetS: List<SubContractorNmrBillDet>.from(json["subContractorNMRBillDetS"].map((x) => SubContractorNmrBillDet.fromJson(x))),
    subContractorNmrBillAddLessSetupS: List<SubContractorNmrBillAddLessSetup>.from(json["subContractorNMRBillAddLessSetupS"].map((x) => SubContractorNmrBillAddLessSetup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "entryDate": entryDate,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "fromDate": fromDate,
    "toDate": toDate,
    "billNo": billNo,
    "billAmount": billAmount,
    "netBillAmount": netBillAmount,
    "foodAmount": foodAmount,
    "bankCharges": bankCharges,
    "debitAmount": debitAmount,
    "debitRemarks": debitRemarks,
    "creditAmount": creditAmount,
    "creditRemarks": creditRemarks,
    "advanceAmount": advanceAmount,
    "actualAdvanceAmount": actualAdvanceAmount,
    "roundOff": roundOff,
    "netPayAmount": netPayAmount,
    "balanceAmount": balanceAmount,
    "remarks": remarks,
    "projectName": projectName,
    "siteName": siteName,
    "subContractorName": subContractorName,
    "createdName": createdName,
    "status": status,
    "appSts": appSts,
    "verSts": verSts,
    "subContractorNMRBillDetS": List<dynamic>.from(subContractorNmrBillDetS!.map((x) => x.toJson())),
    "subContractorNMRBillAddLessSetupS": List<dynamic>.from(subContractorNmrBillAddLessSetupS!.map((x) => x.toJson())),
  };
}

class SubContractorNmrBillAddLessSetup {
  int? id;
  int? addLessId;
  int? subContractorNmrBillMasId;
  double? percentValue;
  double? amount;

  SubContractorNmrBillAddLessSetup({
    this.id,
    this.addLessId,
    this.subContractorNmrBillMasId,
    this.percentValue,
    this.amount,
  });

  factory SubContractorNmrBillAddLessSetup.fromJson(Map<String, dynamic> json) => SubContractorNmrBillAddLessSetup(
    id: json["id"],
    addLessId: json["addLessId"],
    subContractorNmrBillMasId: json["subContractorNMRBillMasId"],
    percentValue: json["percentValue"],
    amount: json["amount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addLessId": addLessId,
    "subContractorNMRBillMasId": subContractorNmrBillMasId,
    "percentValue": percentValue,
    "amount": amount,
  };
}

class SubContractorNmrBillDet {
  int? id;
  int? subContractorNmrBillMasId;
  int? projectId;
  int? siteId;
  int? subContractorId;
  int? categoryId;
  double? nmrAmount;
  double? totalNos;
  double? totalOtAmount;
  String? siteName;
  String? categoryName;
  String? subContractorName;

  SubContractorNmrBillDet({
    this.id,
    this.subContractorNmrBillMasId,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.categoryId,
    this.nmrAmount,
    this.totalNos,
    this.totalOtAmount,
    this.siteName,
    this.categoryName,
    this.subContractorName,
  });

  factory SubContractorNmrBillDet.fromJson(Map<String, dynamic> json) => SubContractorNmrBillDet(
    id: json["id"],
    subContractorNmrBillMasId: json["subContractorNMRBillMasId"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    categoryId: json["categoryId"],
    nmrAmount: json["nmrAmount"],
    totalNos: json["totalNos"],
    totalOtAmount: json["totalOTAmount"],
    siteName: json["siteName"],
    categoryName: json["categoryName"],
    subContractorName: json["subContractorName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractorNMRBillMasId": subContractorNmrBillMasId,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "categoryId": categoryId,
    "nmrAmount": nmrAmount,
    "totalNos": totalNos,
    "totalOTAmount": totalOtAmount,
    "siteName": siteName,
    "categoryName": categoryName,
    "subContractorName": subContractorName,
  };
}
