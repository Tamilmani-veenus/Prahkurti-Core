// To parse this JSON data, do
//
//     final sitevocentrylist = sitevocentrylistFromJson(jsonString);

import 'dart:convert';

Sitevocentrylist sitevocentrylistFromJson(String str) => Sitevocentrylist.fromJson(json.decode(str));

String sitevocentrylistToJson(Sitevocentrylist data) => json.encode(data.toJson());

class Sitevocentrylist {
  bool? success;
  List<Result>? result;
  String? message;

  Sitevocentrylist({
    this.success,
    this.result,
    this.message,
  });

  factory Sitevocentrylist.fromJson(Map<String, dynamic> json) => Sitevocentrylist(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? siteVoucherNo;
  String? siteVoucherDate;
  double? siteVoucherAmount;
  String? projectName;
  String? accountName;
  String? accountTypeName;
  String? payModeName;
  String? createdName;
  String? status;

  Result({
    this.id,
    this.siteVoucherNo,
    this.siteVoucherDate,
    this.siteVoucherAmount,
    this.projectName,
    this.accountName,
    this.accountTypeName,
    this.payModeName,
    this.createdName,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    siteVoucherNo: json["siteVoucherNo"],
    siteVoucherDate: json["siteVoucherDate"],
    siteVoucherAmount: json["siteVoucherAmount"],
    projectName: json["projectName"],
    accountName: json["accountName"],
    accountTypeName: json["accountTypeName"],
    payModeName: json["payModeName"],
    createdName: json["createdName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "siteVoucherNo": siteVoucherNo,
    "siteVoucherDate": siteVoucherDate,
    "siteVoucherAmount": siteVoucherAmount,
    "projectName": projectName,
    "accountName": accountName,
    "accountTypeName": accountTypeName,
    "payModeName": payModeName,
    "createdName": createdName,
    "status": status,
  };
}
