// To parse this JSON data, do
//
//     final sitewisePaymentList = sitewisePaymentListFromJson(jsonString);

import 'dart:convert';

SitewisePaymentList sitewisePaymentListFromJson(String str) => SitewisePaymentList.fromJson(json.decode(str));

String sitewisePaymentListToJson(SitewisePaymentList data) => json.encode(data.toJson());

class SitewisePaymentList {
  bool? success;
  String? message;
  List<Result>? result;

  SitewisePaymentList({
    this.success,
    this.message,
    this.result,
  });

  factory SitewisePaymentList.fromJson(Map<String, dynamic> json) => SitewisePaymentList(
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
  int? purOrdMasId;
  String? billNo;
  String? poNo;
  String? projectName;
  int? projectId;
  String? siteName;
  int? siteId;
  double? netamt;
  double? billAmount;
  double? advanceAmt;
  double? balanceAmount;
  double? amount;

  Result({
    this.purOrdMasId,
    this.billNo,
    this.poNo,
    this.projectName,
    this.projectId,
    this.siteName,
    this.siteId,
    this.netamt,
    this.billAmount,
    this.advanceAmt,
    this.balanceAmount,
    this.amount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    purOrdMasId: json["purOrdMasId"],
    billNo: json["billNo"],
    poNo: json["PoNo"] ?? json["poNo"],
    projectName: json["projectName"],
    projectId: json["projectId"],
    siteName: json["siteName"],
    siteId: json["siteId"],
    netamt: json["netamt"],
    billAmount: json["billAmount"],
    advanceAmt: json["advanceAmt"],
    balanceAmount: json["balanceAmount"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "purOrdMasId": purOrdMasId,
    "billNo": billNo,
    "PoNo": poNo,
    "projectName": projectName,
    "projectId": projectId,
    "siteName": siteName,
    "siteId": siteId,
    "netamt": netamt,
    "billAmount": billAmount,
    "advanceAmt": advanceAmt,
    "balanceAmount": balanceAmount,
    "amount": amount,
  };
}
