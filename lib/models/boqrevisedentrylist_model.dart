// To parse this JSON data, do
//
//     final boqRevisedEntryListResponse = boqRevisedEntryListResponseFromJson(jsonString);

import 'dart:convert';

BoqRevisedEntryListResponse boqRevisedEntryListResponseFromJson(String str) => BoqRevisedEntryListResponse.fromJson(json.decode(str));

String boqRevisedEntryListResponseToJson(BoqRevisedEntryListResponse data) => json.encode(data.toJson());

class BoqRevisedEntryListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  BoqRevisedEntryListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory BoqRevisedEntryListResponse.fromJson(Map<String, dynamic> json) => BoqRevisedEntryListResponse(
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
  String? reviseNo;
  String? reviseDate;
  int? projectId;
  int? siteId;
  String? remarks;
  int? createdBy;
  int? approvedBy;
  String? createdByName;
  String? projectName;
  String? siteName;

  Result({
    this.id,
    this.reviseNo,
    this.reviseDate,
    this.projectId,
    this.siteId,
    this.remarks,
    this.createdBy,
    this.approvedBy,
    this.createdByName,
    this.projectName,
    this.siteName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    reviseNo: json["reviseNo"],
    reviseDate: json["reviseDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    approvedBy: json["approvedBy"],
    createdByName: json["createdByName"],
    projectName: json["projectName"],
    siteName: json["siteName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reviseNo": reviseNo,
    "reviseDate": reviseDate,
    "projectId": projectId,
    "siteId": siteId,
    "remarks": remarks,
    "createdBy": createdBy,
    "approvedBy": approvedBy,
    "createdByName": createdByName,
    "projectName": projectName,
    "siteName": siteName,
  };
}
