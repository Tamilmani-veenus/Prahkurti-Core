// To parse this JSON data, do
//
//     final staffvouchereditResponse = staffvouchereditResponseFromJson(jsonString);

import 'dart:convert';

StaffvouchereditResponse staffvouchereditResponseFromJson(String str) => StaffvouchereditResponse.fromJson(json.decode(str));

String staffvouchereditResponseToJson(StaffvouchereditResponse data) => json.encode(data.toJson());

class StaffvouchereditResponse {
  bool? success;
  String? message;
  Result? result;

  StaffvouchereditResponse({
    this.success,
    this.message,
    this.result,
  });

  factory StaffvouchereditResponse.fromJson(Map<String, dynamic> json) => StaffvouchereditResponse(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class Result {
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
  int? verifyBy;
  String? verifyStatus;
  String? verifyDate;
  int? createdBy;
  String? createdDate;
  int? accountNameId;
  String? projectName;
  dynamic companyName;
  dynamic accountName;
  String? accTypeName;
  dynamic payModeName;
  int? payMode;
  String? createdName;
  dynamic paidByName;
  String? payForName;
  dynamic status;
  dynamic bankName;
  List<AccStaffVocSWpayment>? accStaffVocSWpaymentS;

  Result({
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
    this.verifyBy,
    this.verifyStatus,
    this.verifyDate,
    this.createdBy,
    this.createdDate,
    this.accountNameId,
    this.projectName,
    this.companyName,
    this.accountName,
    this.accTypeName,
    this.payModeName,
    this.payMode,
    this.createdName,
    this.paidByName,
    this.payForName,
    this.status,
    this.bankName,
    this.accStaffVocSWpaymentS,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    staffVocNo: json["staffVocNo"],
    employeeId: json["employeeId"],
    vocType: json["vocType"],
    vocDate: json["vocDate"],
    accTypeId: json["accTypeId"],
    payFor: json["payFor"],
    paymentMode: json["paymentMode"],
    payType: json["payType"],
    vocAmount: json["vocAmount"],
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
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDate: json["verifyDate"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    accountNameId: json["accountNameId"],
    projectName: json["projectName"],
    companyName: json["companyName"],
    accTypeName: json["accountTypeName"],
    accountName: json["accountName"],
    payModeName: json["payModeName"],
    payMode: json["paymentMode"],
    createdName: json["createdName"],
    paidByName: json["paidByName"],
    payForName: json["payForName"],
    status: json["status"],
    bankName: json["bankName"],
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
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDate": verifyDate,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "accountNameId": accountNameId,
    "projectName": projectName,
    "companyName": companyName,
    "accountTypeName": accTypeName,
    "accountName": accountName,
    "payModeName": payModeName,
    "paymentMode": payMode,
    "createdName": createdName,
    "paidByName": paidByName,
    "payForName": payForName,
    "status": status,
    "bankName":bankName,
    "accStaffVocSWpaymentS": List<dynamic>.from(accStaffVocSWpaymentS!.map((x) => x.toJson())),
  };
}

class AccStaffVocSWpayment {
  int? id;
  int? staffVocherId;
  dynamic payType;
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
  String? projectName;
  String? siteName;
  String? payTypeName;

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
    this.projectName,
    this.siteName,
    this.payTypeName,
  });

  factory AccStaffVocSWpayment.fromJson(Map<String, dynamic> json) => AccStaffVocSWpayment(
    id: json["id"],
    staffVocherId: json["staffVocherId"],
    payType: json["payType"],
    amount: json["amount"],
    tdsPercentage: json["tdsPercentage"],
    tdsAmount: json["tdsAmount"],
    netAmount: json["netAmount"],
    purOrdMasId: json["purOrdMasId"],
    purOrdBillMasId: json["purOrdBillMasId"],
    workOrderId: json["workOrderId"],
    workId: json["workId"],
    nmrWorkDetId: json["nmrWorkDetId"],
    siteId: json["siteId"],
    projectId: json["projectId"],
    reqAmount: json["reqAmount"].toDouble(),
    paymentReqId: json["paymentReqId"],
    nmrWorkId: json["nmrWorkId"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    payTypeName: json["payTypeName"],
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
    "projectName": projectName,
    "siteName": siteName,
    "payTypeName": payTypeName,
  };
}
