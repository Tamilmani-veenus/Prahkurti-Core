// To parse this JSON data, do
//
//     final advanceReqvoucherSaveApiReq = advanceReqvoucherSaveApiReqFromJson(jsonString);

import 'dart:convert';

AdvanceReqvoucherSaveApiReq advanceReqvoucherSaveApiReqFromJson(String str) => AdvanceReqvoucherSaveApiReq.fromJson(json.decode(str));

String advanceReqvoucherSaveApiReqToJson(AdvanceReqvoucherSaveApiReq data) => json.encode(data.toJson());

class AdvanceReqvoucherSaveApiReq {
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
  String? verifyStatus;
  String? approveStatus;
  List<AccountAdvanceReqVoucherSwPayment>? accountAdvanceReqVoucherSwPayments;

  AdvanceReqvoucherSaveApiReq({
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
    this.verifyStatus,
    this.approveStatus,
    this.accountAdvanceReqVoucherSwPayments,
  });

  factory AdvanceReqvoucherSaveApiReq.fromJson(Map<String, dynamic> json) => AdvanceReqvoucherSaveApiReq(
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
    verifyStatus: json["verifyStatus"],
    approveStatus: json["approveStatus"],
    accountAdvanceReqVoucherSwPayments: List<AccountAdvanceReqVoucherSwPayment>.from(json["accountAdvanceReqVoucherSWPayments"].map((x) => AccountAdvanceReqVoucherSwPayment.fromJson(x))),
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
    "approveStatus": approveStatus,
    "verifyStatus": verifyStatus,
    "accountAdvanceReqVoucherSWPayments": List<dynamic>.from(accountAdvanceReqVoucherSwPayments!.map((x) => x.toJson())),
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
  };
}
