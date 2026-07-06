// To parse this JSON data, do
//
//     final advReqvoucherentrylistResapi = advReqvoucherentrylistResapiFromJson(jsonString);

import 'dart:convert';

AdvReqvoucherentrylistResapi advReqvoucherentrylistResapiFromJson(String str) => AdvReqvoucherentrylistResapi.fromJson(json.decode(str));

String advReqvoucherentrylistResapiToJson(AdvReqvoucherentrylistResapi data) => json.encode(data.toJson());

class AdvReqvoucherentrylistResapi {
  bool? success;
  List<Result>? result;
  String? message;

  AdvReqvoucherentrylistResapi({
    this.success,
    this.result,
    this.message,
  });

  factory AdvReqvoucherentrylistResapi.fromJson(Map<String, dynamic> json) => AdvReqvoucherentrylistResapi(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["messsage"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? id;
  String? advanceReqVoucherNo;
  String? advanceReqVoucherDate;
  String? advanceReqVoucherType;
  int? projectId;
  int? companyId;
  int? accountTypeId;
  int? accountNameId;
  String? payForType;
  int? payModeId;
  String? paymentType;
  int? advanceReqVoucherAmount;
  int? paidBy;
  String? remarks;
  int? companyBankId;
  String? chequeNo;
  String? chequeDate;
  String? nameThrough;
  double? actualVoucherAmount;
  int? createdBy;
  String? createdDt;
  int? verifyBy;
  String? verifyStatus;
  String? verifyDt;
  int? approvedBy;
  String? approveStatus;
  String? approveDt;
  String? projectName;
  String? companyName;
  String? accountName;
  String? accountTypeName;
  String? accountVoucherType;
  String? accountPayForName;
  String? payModeName;
  String? createdName;
  String? paidByName;
  String? verifiedName;
  String? approvedName;
  String? status;
  String? accountAdvanceReqVoucherSwPayments;
  List<dynamic>? supplierAdvanceDetails;
  List<dynamic>? subContractorAdvanceDetails;

  Result({
    this.id,
    this.advanceReqVoucherNo,
    this.advanceReqVoucherDate,
    this.advanceReqVoucherType,
    this.projectId,
    this.companyId,
    this.accountTypeId,
    this.accountNameId,
    this.payForType,
    this.payModeId,
    this.paymentType,
    this.advanceReqVoucherAmount,
    this.paidBy,
    this.remarks,
    this.companyBankId,
    this.chequeNo,
    this.chequeDate,
    this.nameThrough,
    this.actualVoucherAmount,
    this.createdBy,
    this.createdDt,
    this.verifyBy,
    this.verifyStatus,
    this.verifyDt,
    this.approvedBy,
    this.approveStatus,
    this.approveDt,
    this.projectName,
    this.companyName,
    this.accountName,
    this.accountTypeName,
    this.accountVoucherType,
    this.accountPayForName,
    this.payModeName,
    this.createdName,
    this.paidByName,
    this.verifiedName,
    this.approvedName,
    this.status,
    this.accountAdvanceReqVoucherSwPayments,
    this.supplierAdvanceDetails,
    this.subContractorAdvanceDetails,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    advanceReqVoucherNo: json["advanceReqVoucherNo"],
    advanceReqVoucherDate: json["advanceReqVoucherDate"],
    advanceReqVoucherType: json["advanceReqVoucherType"],
    projectId: json["projectId"],
    companyId: json["companyId"],
    accountTypeId: json["accountTypeId"],
    accountNameId: json["accountNameId"],
    payForType: json["payForType"],
    payModeId: json["payModeId"],
    paymentType: json["paymentType"],
    advanceReqVoucherAmount: json["advanceReqVoucherAmount"],
    paidBy: json["paidBy"],
    remarks: json["remarks"],
    companyBankId: json["companyBankId"],
    chequeNo: json["chequeNo"],
    chequeDate: json["chequeDate"],
    nameThrough: json["nameThrough"],
    actualVoucherAmount: json["actualVoucherAmount"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDt: json["verifyDt"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDt: json["approveDt"],
    projectName: json["projectName"],
    companyName: json["companyName"],
    accountName: json["accountName"],
    accountTypeName: json["accountTypeName"],
    accountVoucherType: json["accountVoucherType"],
    accountPayForName: json["accountPayForName"],
    payModeName: json["payModeName"],
    createdName: json["createdName"],
    paidByName: json["paidByName"],
    verifiedName: json["verifiedName"],
    approvedName: json["approvedName"],
    status: json["status"],
    accountAdvanceReqVoucherSwPayments: json["accountAdvanceReqVoucherSWPayments"],
    supplierAdvanceDetails: List<dynamic>.from(json["supplierAdvanceDetails"].map((x) => x)),
    subContractorAdvanceDetails: List<dynamic>.from(json["subContractorAdvanceDetails"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "advanceReqVoucherNo": advanceReqVoucherNo,
    "advanceReqVoucherDate": advanceReqVoucherDate,
    "advanceReqVoucherType": advanceReqVoucherType,
    "projectId": projectId,
    "companyId": companyId,
    "accountTypeId": accountTypeId,
    "accountNameId": accountNameId,
    "payForType": payForType,
    "payModeId": payModeId,
    "paymentType": paymentType,
    "advanceReqVoucherAmount": advanceReqVoucherAmount,
    "paidBy": paidBy,
    "remarks": remarks,
    "companyBankId": companyBankId,
    "chequeNo": chequeNo,
    "chequeDate": chequeDate,
    "nameThrough": nameThrough,
    "actualVoucherAmount": actualVoucherAmount,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDt": verifyDt,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "approveDt": approveDt,
    "projectName": projectName,
    "companyName": companyName,
    "accountName": accountName,
    "accountTypeName": accountTypeName,
    "accountVoucherType": accountVoucherType,
    "accountPayForName": accountPayForName,
    "payModeName": payModeName,
    "createdName": createdName,
    "paidByName": paidByName,
    "verifiedName": verifiedName,
    "approvedName": approvedName,
    "status": status,
    "accountAdvanceReqVoucherSWPayments": accountAdvanceReqVoucherSwPayments,
    "supplierAdvanceDetails": List<dynamic>.from(supplierAdvanceDetails!.map((x) => x)),
    "subContractorAdvanceDetails": List<dynamic>.from(subContractorAdvanceDetails!.map((x) => x)),
  };
}
