// To parse this JSON data, do
//
//     final sitevoucherSaveRequest = sitevoucherSaveRequestFromJson(jsonString);

import 'dart:convert';

SitevoucherSaveRequest sitevoucherSaveRequestFromJson(String str) => SitevoucherSaveRequest.fromJson(json.decode(str));

String sitevoucherSaveRequestToJson(SitevoucherSaveRequest data) => json.encode(data.toJson());

class SitevoucherSaveRequest {
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
  List<AccountSiteVoucherSwPayment>? accountSiteVoucherSwPayments;

  SitevoucherSaveRequest({
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
    this.accountSiteVoucherSwPayments,
  });

  factory SitevoucherSaveRequest.fromJson(Map<String, dynamic> json) => SitevoucherSaveRequest(
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
    tdsAmount: json["tdsAmount"],
    amount: json["amount"],
    netAmount: json["netAmount"],
    reqAmount: json["reqAmount"],
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
  };
}
