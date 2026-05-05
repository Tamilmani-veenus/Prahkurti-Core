// To parse this JSON data, do
//
//     final sitevouchereditResponse = sitevouchereditResponseFromJson(jsonString);

import 'dart:convert';

SitevouchereditResponse sitevouchereditResponseFromJson(String str) => SitevouchereditResponse.fromJson(json.decode(str));

String sitevouchereditResponseToJson(SitevouchereditResponse data) => json.encode(data.toJson());

class SitevouchereditResponse {
  bool? success;
  String? message;
  Result? result;

  SitevouchereditResponse({
    this.success,
    this.message,
    this.result,
  });

  factory SitevouchereditResponse.fromJson(Map<String, dynamic> json) => SitevouchereditResponse(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result,
  };
}

class Result {
  int? id;
  String? siteVoucherNo;
  String? siteVoucherDate;
  String? siteVoucherType;
  int? projectId;
  int? companyId;
  int? accountTypeId;
  int? accountNameId;
  double? siteVoucherAmount;
  String? payForType;
  int? paidBy;
  int? payModeId;
  int? paidFrom;
  String? paymentType;
  String? nameThrough;
  String? remarks;
  int? companyBankId;
  String? cheQueNo;
  int? accountPayee;
  String? cheQueDate;
  int? requisitionId;
  int? createdBy;
  String? createdDt;
  String? projectName;
  String? companyName;
  String? accountName;
  String? accountTypeName;
  String? accountPayForName;
  String? payModeName;
  String? createdName;
  String? paidByName;
  String? status;
  List<AccountSiteVoucherSwPayment>? accountSiteVoucherSwPayments;

  Result({
    this.id,
    this.siteVoucherNo,
    this.siteVoucherDate,
    this.siteVoucherType,
    this.projectId,
    this.companyId,
    this.accountTypeId,
    this.accountNameId,
    this.siteVoucherAmount,
    this.payForType,
    this.paidBy,
    this.payModeId,
    this.paidFrom,
    this.paymentType,
    this.nameThrough,
    this.remarks,
    this.companyBankId,
    this.cheQueNo,
    this.accountPayee,
    this.cheQueDate,
    this.requisitionId,
    this.createdBy,
    this.createdDt,
    this.projectName,
    this.companyName,
    this.accountName,
    this.accountTypeName,
    this.accountPayForName,
    this.payModeName,
    this.createdName,
    this.paidByName,
    this.status,
    this.accountSiteVoucherSwPayments,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    siteVoucherNo: json["siteVoucherNo"],
    siteVoucherDate: json["siteVoucherDate"],
    siteVoucherType: json["siteVoucherType"],
    projectId: json["projectId"],
    companyId: json["companyId"],
    accountTypeId: json["accountTypeId"],
    accountNameId: json["accountNameId"],
    siteVoucherAmount: json["siteVoucherAmount"],
    payForType: json["payForType"],
    paidBy: json["paidBy"],
    payModeId: json["payModeId"],
    paidFrom: json["paidFrom"],
    paymentType: json["paymentType"],
    nameThrough: json["nameThrough"],
    remarks: json["remarks"],
    companyBankId: json["companyBankId"],
    cheQueNo: json["cheQueNo"],
    accountPayee: json["accountPayee"],
    cheQueDate: json["cheQueDate"],
    requisitionId: json["requisitionId"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    projectName: json["projectName"],
    companyName: json["companyName"],
    accountName: json["accountName"],
    accountTypeName: json["accountTypeName"],
    accountPayForName: json["accountPayForName"],
    payModeName: json["payModeName"],
    createdName: json["createdName"],
    paidByName: json["paidByName"],
    status: json["status"],
    accountSiteVoucherSwPayments: List<AccountSiteVoucherSwPayment>.from(json["accountSiteVoucherSWPayments"].map((x) => AccountSiteVoucherSwPayment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "siteVoucherNo": siteVoucherNo,
    "siteVoucherDate": siteVoucherDate,
    "siteVoucherType": siteVoucherType,
    "projectId": projectId,
    "companyId": companyId,
    "accountTypeId": accountTypeId,
    "accountNameId": accountNameId,
    "siteVoucherAmount": siteVoucherAmount,
    "payForType": payForType,
    "paidBy": paidBy,
    "payModeId": payModeId,
    "paidFrom": paidFrom,
    "paymentType": paymentType,
    "nameThrough": nameThrough,
    "remarks": remarks,
    "companyBankId": companyBankId,
    "cheQueNo": cheQueNo,
    "accountPayee": accountPayee,
    "cheQueDate": cheQueDate,
    "requisitionId": requisitionId,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "projectName": projectName,
    "companyName": companyName,
    "accountName": accountName,
    "accountTypeName": accountTypeName,
    "accountPayForName": accountPayForName,
    "payModeName": payModeName,
    "createdName": createdName,
    "paidByName": paidByName,
    "status": status,
    "accountSiteVoucherSWPayments": List<dynamic>.from(accountSiteVoucherSwPayments!.map((x) => x.toJson())),
  };
}

class AccountSiteVoucherSwPayment {
  int? id;
  int? siteVoucherId;
  String? payType;
  int? projectId;
  int? siteId;
  int? purOrdmasId;
  int? purOrdBillmasId;
  int? workOrderId;
  int? workId;
  int? nmrWorkDetId;
  int? nmrWorkId;
  int? paymentReqId;
  double? tdsPercentage;
  double? tdsAmount;
  double? amount;
  double? netAmount;
  double? reqAmount;
  String? projectName;
  String? siteName;
  String? paytypeDesc;

  AccountSiteVoucherSwPayment({
    this.id,
    this.siteVoucherId,
    this.payType,
    this.projectId,
    this.siteId,
    this.purOrdmasId,
    this.purOrdBillmasId,
    this.workOrderId,
    this.workId,
    this.nmrWorkDetId,
    this.nmrWorkId,
    this.paymentReqId,
    this.tdsPercentage,
    this.tdsAmount,
    this.amount,
    this.netAmount,
    this.reqAmount,
    this.projectName,
    this.siteName,
    this.paytypeDesc,
  });

  factory AccountSiteVoucherSwPayment.fromJson(Map<String, dynamic> json) => AccountSiteVoucherSwPayment(
    id: json["id"],
    siteVoucherId: json["siteVoucherId"],
    payType: json["payType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    purOrdmasId: json["purOrdmasId"],
    purOrdBillmasId: json["purOrdBillmasId"],
    workOrderId: json["workOrderId"],
    workId: json["workId"],
    nmrWorkDetId: json["nmrWorkDetId"],
    nmrWorkId: json["nmrWorkId"],
    paymentReqId: json["paymentReqId"],
    tdsPercentage: json["tdsPercentage"],
    tdsAmount: json["tdsAmount"].toDouble(),
    amount: json["amount"],
    netAmount: json["netAmount"].toDouble(),
    reqAmount: json["reqAmount"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    paytypeDesc: json["paytypeDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "siteVoucherId": siteVoucherId,
    "payType": payType,
    "projectId": projectId,
    "siteId": siteId,
    "purOrdmasId": purOrdmasId,
    "purOrdBillmasId": purOrdBillmasId,
    "workOrderId": workOrderId,
    "workId": workId,
    "nmrWorkDetId": nmrWorkDetId,
    "nmrWorkId": nmrWorkId,
    "paymentReqId": paymentReqId,
    "tdsPercentage": tdsPercentage,
    "tdsAmount": tdsAmount,
    "amount": amount,
    "netAmount": netAmount,
    "reqAmount": reqAmount,
    "projectName": projectName,
    "siteName": siteName,
    "paytypeDesc": paytypeDesc,
  };
}
