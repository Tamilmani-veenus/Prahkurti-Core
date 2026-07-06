// To parse this JSON data, do
//
//     final advReqEditApiRes = advReqEditApiResFromJson(jsonString);

import 'dart:convert';

AdvReqEditApiRes advReqEditApiResFromJson(String str) => AdvReqEditApiRes.fromJson(json.decode(str));

String advReqEditApiResToJson(AdvReqEditApiRes data) => json.encode(data.toJson());

class AdvReqEditApiRes {
  bool? success;
  String? message;
  Result? result;

  AdvReqEditApiRes({
    this.success,
    this.message,
    this.result,
  });

  factory AdvReqEditApiRes.fromJson(Map<String, dynamic> json) => AdvReqEditApiRes(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?null:result!.toJson(),
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
  double? advanceReqVoucherAmount;
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
  int? approvedBy;
  String? approveStatus;
  String? projectName;
  String? companyName;
  String? accountName;
  String? accountTypeName;
  String? accountVoucherType;
  String? accountPayForName;
  String? createdName;
  String? status;
  List<AccountAdvanceReqVoucherSwPayment>? accountAdvanceReqVoucherSwPayments;
  List<RAdvanceDetail>? supplierAdvanceDetails;
  List<RAdvanceDetail>? subContractorAdvanceDetails;

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
    this.approvedBy,
    this.approveStatus,
    this.projectName,
    this.companyName,
    this.accountName,
    this.accountTypeName,
    this.accountVoucherType,
    this.accountPayForName,
    this.createdName,
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
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    projectName: json["projectName"],
    companyName: json["companyName"],
    accountName: json["accountName"],
    accountTypeName: json["accountTypeName"],
    accountVoucherType: json["accountVoucherType"],
    accountPayForName: json["accountPayForName"],
    createdName: json["createdName"],
    status: json["status"],
    accountAdvanceReqVoucherSwPayments: List<AccountAdvanceReqVoucherSwPayment>.from(json["accountAdvanceReqVoucherSWPayments"].map((x) => AccountAdvanceReqVoucherSwPayment.fromJson(x))),
    supplierAdvanceDetails: List<RAdvanceDetail>.from(json["supplierAdvanceDetails"].map((x) => RAdvanceDetail.fromJson(x))),
    subContractorAdvanceDetails: List<RAdvanceDetail>.from(json["subContractorAdvanceDetails"].map((x) => RAdvanceDetail.fromJson(x))),
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
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "projectName": projectName,
    "companyName": companyName,
    "accountName": accountName,
    "accountTypeName": accountTypeName,
    "accountVoucherType": accountVoucherType,
    "accountPayForName": accountPayForName,
    "createdName": createdName,
    "status": status,
    "accountAdvanceReqVoucherSWPayments": List<dynamic>.from(accountAdvanceReqVoucherSwPayments!.map((x) => x.toJson())),
    "supplierAdvanceDetails": List<dynamic>.from(supplierAdvanceDetails!.map((x) => x.toJson())),
    "subContractorAdvanceDetails": List<dynamic>.from(subContractorAdvanceDetails!.map((x) => x.toJson())),
  };
}

class AccountAdvanceReqVoucherSwPayment {
  int? id;
  int? advanceReqVoucherId;
  String? payType;
  int? siteId;
  int? purOrdmasId;
  int? purOrdBillmasId;
  int? workOrderId;
  int? workId;
  double? tdsPercentage;
  double? tdsAmount;
  double? amount;
  double? netAmount;
  double? actualNetAmount;
  String? siteName;
  String? payTypeDesc;

  AccountAdvanceReqVoucherSwPayment({
    this.id,
    this.advanceReqVoucherId,
    this.payType,
    this.siteId,
    this.purOrdmasId,
    this.purOrdBillmasId,
    this.workOrderId,
    this.workId,
    this.tdsPercentage,
    this.tdsAmount,
    this.amount,
    this.netAmount,
    this.actualNetAmount,
    this.siteName,
    this.payTypeDesc,
  });

  factory AccountAdvanceReqVoucherSwPayment.fromJson(Map<String, dynamic> json) => AccountAdvanceReqVoucherSwPayment(
    id: json["id"],
    advanceReqVoucherId: json["advanceReqVoucherId"],
    payType: json["payType"],
    siteId: json["siteId"],
    purOrdmasId: json["purOrdmasId"],
    purOrdBillmasId: json["purOrdBillmasId"],
    workOrderId: json["workOrderId"],
    workId: json["workId"],
    tdsPercentage: json["tdsPercentage"],
    tdsAmount: json["tdsAmount"],
    amount: json["amount"],
    netAmount: json["netAmount"],
    actualNetAmount: json["actualNetAmount"],
    siteName: json["siteName"],
    payTypeDesc: json["payTypeDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "advanceReqVoucherId": advanceReqVoucherId,
    "payType": payType,
    "siteId": siteId,
    "purOrdmasId": purOrdmasId,
    "purOrdBillmasId": purOrdBillmasId,
    "workOrderId": workOrderId,
    "workId": workId,
    "tdsPercentage": tdsPercentage,
    "tdsAmount": tdsAmount,
    "amount": amount,
    "netAmount": netAmount,
    "actualNetAmount": actualNetAmount,
    "siteName": siteName,
    "payTypeDesc": payTypeDesc,
  };
}

class RAdvanceDetail {
  int? swPayId;
  int? purOrdMasId;
  String? billNo;
  String? poNo;
  String? siteName;
  int? siteId;
  String? projectName;
  int? projectId;
  double? netAmt;
  double? paidAmt;
  double? advanceAmt;
  double? bAmount;
  double? amount;
  int? tdsPer;
  int? tdsAmt;
  double? totAmt;
  double? billAmt;
  String? payType;
  String? paymentTypeName;

  RAdvanceDetail({
    this.swPayId,
    this.purOrdMasId,
    this.billNo,
    this.poNo,
    this.siteName,
    this.siteId,
    this.projectName,
    this.projectId,
    this.netAmt,
    this.paidAmt,
    this.advanceAmt,
    this.bAmount,
    this.amount,
    this.tdsPer,
    this.tdsAmt,
    this.totAmt,
    this.billAmt,
    this.payType,
    this.paymentTypeName,
  });

  factory RAdvanceDetail.fromJson(Map<String, dynamic> json) => RAdvanceDetail(
    swPayId: json["swPayId"],
    purOrdMasId: json["purOrdMasId"],
    billNo: json["billNo"],
    poNo: json["poNo"],
    siteName: json["siteName"],
    siteId: json["siteId"],
    projectName: json["projectName"],
    projectId: json["projectId"],
    netAmt: json["netAmt"],
    paidAmt: json["paidAmt"],
    advanceAmt: json["advanceAmt"],
    bAmount: json["bAmount"],
    amount: json["amount"],
    tdsPer: json["tdsPer"],
    tdsAmt: json["tdsAmt"],
    totAmt: json["totAmt"],
    billAmt: json["billAmt"],
    payType: json["payType"],
    paymentTypeName: json["paymentTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "swPayId": swPayId,
    "purOrdMasId": purOrdMasId,
    "billNo": billNo,
    "poNo": poNo,
    "siteName": siteName,
    "siteId": siteId,
    "projectName": projectName,
    "projectId": projectId,
    "netAmt": netAmt,
    "paidAmt": paidAmt,
    "advanceAmt": advanceAmt,
    "bAmount": bAmount,
    "amount": amount,
    "tdsPer": tdsPer,
    "tdsAmt": tdsAmt,
    "totAmt": totAmt,
    "billAmt": billAmt,
    "payType": payType,
    "paymentTypeName": paymentTypeName,
  };
}

