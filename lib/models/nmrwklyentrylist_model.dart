// To parse this JSON data, do
//
//     final nmrEntryList = nmrEntryListFromJson(jsonString);

import 'dart:convert';

NmrEntryList nmrEntryListFromJson(String str) => NmrEntryList.fromJson(json.decode(str));

String nmrEntryListToJson(NmrEntryList data) => json.encode(data.toJson());

class NmrEntryList {
  bool? success;
  String? message;
  List<Result>? result;

  NmrEntryList({
    this.success,
    this.message,
    this.result
  });

  factory NmrEntryList.fromJson(Map<String, dynamic> json) => NmrEntryList(
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
  String? workNo;
  String? entryDate;
  String? fromDate;
  String? toDate;
  String? billNo;
  String? verifyStatus;
  String? projectName;
  String? siteName;
  String? subContractorName;
  String? createdName;
  String? status;

  Result({
    this.id,
    this.workNo,
    this.entryDate,
    this.fromDate,
    this.toDate,
    this.billNo,
    this.verifyStatus,
    this.projectName,
    this.siteName,
    this.subContractorName,
    this.createdName,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    entryDate: json["entryDate"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    billNo: json["billNo"],
    verifyStatus: json["verifyStatus"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractorName: json["subContractorName"],
    createdName: json["createdName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "entryDate": entryDate,
    "fromDate": fromDate,
    "toDate": toDate,
    "billNo": billNo,
    "verifyStatus": verifyStatus,
    "projectName": projectName,
    "siteName": siteName,
    "subContractorName": subContractorName,
    "createdName": createdName,
    "status": status,
  };
}
