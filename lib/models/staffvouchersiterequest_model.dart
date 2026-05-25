// To parse this JSON data, do
//
//     final staffvouchersiteRequest = staffvouchersiteRequestFromJson(jsonString);

import 'dart:convert';

StaffvouchersiteRequest staffvouchersiteRequestFromJson(String str) => StaffvouchersiteRequest.fromJson(json.decode(str));

String staffvouchersiteRequestToJson(StaffvouchersiteRequest data) => json.encode(data.toJson());

class StaffvouchersiteRequest {
  int? id;
  String? staffVocNo;
  int? employeeId;
  String? vocType;
  String? vocDate;
  int? accTypeId;
  String? payFor;
  int? paymentMode;
  String? payType;
  double? vocAmount;
  int? paidBy;
  int? companyId;
  String? remarks;
  int? bankId;
  String? chequeNo;
  String? chequeDate;
  String? nameThrough;
  int? requisitionId;
  int? accountPayee;
  int? projectId;
  int? createdBy;
  String? createdDate;
  int? accountNameId;
  List<AccStaffVocSWpayment>? accStaffVocSWpaymentS;

  StaffvouchersiteRequest({
    this.id,
    this.staffVocNo,
    this.employeeId,
    this.vocType,
    this.vocDate,
    this.accTypeId,
    this.payFor,
    this.paymentMode,
    this.payType,
    this.vocAmount,
    this.paidBy,
    this.companyId,
    this.remarks,
    this.bankId,
    this.chequeNo,
    this.chequeDate,
    this.nameThrough,
    this.requisitionId,
    this.accountPayee,
    this.projectId,
    this.createdBy,
    this.createdDate,
    this.accountNameId,
    this.accStaffVocSWpaymentS,
  });

  factory StaffvouchersiteRequest.fromJson(Map<String, dynamic> json) => StaffvouchersiteRequest(
    id: json["id"],
    staffVocNo: json["staffVocNo"],
    employeeId: json["employeeId"],
    vocType: json["vocType"],
    vocDate: json["vocDate"],
    accTypeId: json["accTypeId"],
    payFor: json["payFor"],
    paymentMode: json["paymentMode"],
    payType: json["payType"],
    vocAmount: json["vocAmount"].toDouble(),
    paidBy: json["paidBy"],
    companyId: json["companyId"],
    remarks: json["remarks"],
    bankId: json["bankId"],
    chequeNo: json["chequeNo"],
    chequeDate: json["chequeDate"],
    nameThrough: json["nameThrough"],
    requisitionId: json["requisitionId"],
    accountPayee: json["accountPayee"],
    projectId: json["projectId"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    accountNameId: json["accountNameId"],
    accStaffVocSWpaymentS: List<AccStaffVocSWpayment>.from(json["accStaffVocSWpaymentS"].map((x) => AccStaffVocSWpayment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "staffVocNo": staffVocNo,
    "employeeId": employeeId,
    "vocType": vocType,
    "vocDate": vocDate,
    "accTypeId": accTypeId,
    "payFor": payFor,
    "paymentMode": paymentMode,
    "payType": payType,
    "vocAmount": vocAmount,
    "paidBy": paidBy,
    "companyId": companyId,
    "remarks": remarks,
    "bankId": bankId,
    "chequeNo": chequeNo,
    "chequeDate": chequeDate,
    "nameThrough": nameThrough,
    "requisitionId": requisitionId,
    "accountPayee": accountPayee,
    "projectId": projectId,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "accountNameId": accountNameId,
    "accStaffVocSWpaymentS": List<dynamic>.from(accStaffVocSWpaymentS!.map((x) => x.toJson())),
  };
}

class AccStaffVocSWpayment {
  int? id;
  int? staffVocherId;
  String? payType;
  double? amount;
  double? tdsPercentage;
  double? tdsAmount;
  double? netAmount;
  int? purOrdMasId;
  int? purOrdBillMasId;
  int? workOrderId;
  int? workId;
  int? nmrWorkDetId;
  int? siteId;
  int? projectId;
  double? reqAmount;
  int? paymentReqId;
  int? nmrWorkId;

  AccStaffVocSWpayment({
    this.id,
    this.staffVocherId,
    this.payType,
    this.amount,
    this.tdsPercentage,
    this.tdsAmount,
    this.netAmount,
    this.purOrdMasId,
    this.purOrdBillMasId,
    this.workOrderId,
    this.workId,
    this.nmrWorkDetId,
    this.siteId,
    this.projectId,
    this.reqAmount,
    this.paymentReqId,
    this.nmrWorkId,
  });

  factory AccStaffVocSWpayment.fromJson(Map<String, dynamic> json) => AccStaffVocSWpayment(
    id: json["id"],
    staffVocherId: json["staffVocherId"],
    payType: json["payType"],
    amount: json["amount"],
    tdsPercentage: json["tdsPercentage"],
    tdsAmount: json["tdsAmount"].toDouble(),
    netAmount: json["netAmount"].toDouble(),
    purOrdMasId: json["purOrdMasId"],
    purOrdBillMasId: json["purOrdBillMasId"],
    workOrderId: json["workOrderId"],
    workId: json["workId"],
    nmrWorkDetId: json["nmrWorkDetId"],
    siteId: json["siteId"],
    projectId: json["projectId"],
    reqAmount: json["reqAmount"],
    paymentReqId: json["paymentReqId"],
    nmrWorkId: json["nmrWorkId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "staffVocherId": staffVocherId,
    "payType": payType,
    "amount": amount,
    "tdsPercentage": tdsPercentage,
    "tdsAmount": tdsAmount,
    "netAmount": netAmount,
    "purOrdMasId": purOrdMasId,
    "purOrdBillMasId": purOrdBillMasId,
    "workOrderId": workOrderId,
    "workId": workId,
    "nmrWorkDetId": nmrWorkDetId,
    "siteId": siteId,
    "projectId": projectId,
    "reqAmount": reqAmount,
    "paymentReqId": paymentReqId,
    "nmrWorkId": nmrWorkId,
  };
}
