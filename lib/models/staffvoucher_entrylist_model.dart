// To parse this JSON data, do
//
//     final staffvoucherentrylist = staffvoucherentrylistFromJson(jsonString);

import 'dart:convert';

Staffvoucherentrylist staffvoucherentrylistFromJson(String str) => Staffvoucherentrylist.fromJson(json.decode(str));

String staffvoucherentrylistToJson(Staffvoucherentrylist data) => json.encode(data.toJson());

class Staffvoucherentrylist {
  bool? success;
  String? message;
  List<Result>? result;

  Staffvoucherentrylist({
    this.success,
    this.message,
    this.result
  });

  factory Staffvoucherentrylist.fromJson(Map<String, dynamic> json) => Staffvoucherentrylist(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? staffVocNo;
  String? vocDate;
  String? employeeName;
  String? accountType;
  String? accountName;
  String? payFor;
  double? amount;
  int? employeeId;
  String? vocType;
  int? accTypeId;
  int? paymentMode;
  String? payType;
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

  Result({
    this.id,
    this.staffVocNo,
    this.vocDate,
    this.employeeName,
    this.accountType,
    this.accountName,
    this.payFor,
    this.amount,
    this.employeeId,
    this.vocType,
    this.accTypeId,
    this.paymentMode,
    this.payType,
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
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    staffVocNo: json["staffVocNo"],
    vocDate: json["vocDate"],
    employeeName: json["employeeName"],
    accountType: json["accountType"],
    accountName: json["accountName"],
    payFor: json["payFor"],
    amount: json["amount"],
    employeeId: json["employeeId"],
    vocType: json["vocType"],
    accTypeId: json["accTypeId"],
    paymentMode: json["paymentMode"],
    payType: json["payType"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "staffVocNo": staffVocNo,
    "vocDate": vocDate,
    "employeeName": employeeName,
    "accountType": accountType,
    "accountName": accountName,
    "payFor": payFor,
    "amount": amount,
    "employeeId": employeeId,
    "vocType": vocType,
    "accTypeId": accTypeId,
    "paymentMode": paymentMode,
    "payType": payType,
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
  };
}
