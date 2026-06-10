// To parse this JSON data, do
//
//     final nmrItemlist = nmrItemlistFromJson(jsonString);

import 'dart:convert';

NmrItemlist nmrItemlistFromJson(String str) => NmrItemlist.fromJson(json.decode(str));

String nmrItemlistToJson(NmrItemlist data) => json.encode(data.toJson());

class NmrItemlist {
  bool? success;
  String? message;
  List<Result>? result;

  NmrItemlist({
    this.success,
    this.message,
    this.result,
  });

  factory NmrItemlist.fromJson(Map<String, dynamic> json) => NmrItemlist(
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
  String? projectName;
  int? projectId;
  String? siteName;
  int? siteId;
  int? categoryId;
  String? categoryName;
  double? nmrAmount;
  double? totalNos;
  double? rate;
  double? totalOtAmount;
  double? netAmt;

  Result({
    this.projectName,
    this.projectId,
    this.siteName,
    this.siteId,
    this.categoryId,
    this.categoryName,
    this.nmrAmount,
    this.totalNos,
    this.rate,
    this.totalOtAmount,
    this.netAmt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    projectName: json["ProjectName"],
    projectId: json["ProjectId"],
    siteName: json["SiteName"],
    siteId: json["SiteId"],
    categoryId: json["CategoryId"],
    categoryName: json["CategoryName"],
    nmrAmount: json["NMRAMT"],
    totalNos: json["totnos"],
    rate: json["Rate"],
    totalOtAmount: json["total_otamt"],
    netAmt: json["NetAmt"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectName": projectName,
    "ProjectId": projectId,
    "SiteName": siteName,
    "SiteId": siteId,
    "CategoryId": categoryId,
    "CategoryName": categoryName,
    "NMRAMT": nmrAmount,
    "totnos": totalNos,
    "Rate": rate,
    "total_otamt": totalOtAmount,
    "NetAmt": netAmt,
  };
}
