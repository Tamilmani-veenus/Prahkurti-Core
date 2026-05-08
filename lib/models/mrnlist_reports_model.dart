// To parse this JSON data, do
//
//     final mrnListReportsResponse = mrnListReportsResponseFromJson(jsonString);

import 'dart:convert';

MrnListReportsResponse mrnListReportsResponseFromJson(String str) => MrnListReportsResponse.fromJson(json.decode(str));

String mrnListReportsResponseToJson(MrnListReportsResponse data) => json.encode(data.toJson());

class MrnListReportsResponse {
  bool? success;
  String? message;
  List<Result>? result;

  MrnListReportsResponse({
    this.success,
    this.message,
    this.result,
  });

  factory MrnListReportsResponse.fromJson(Map<String, dynamic> json) => MrnListReportsResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null? [] :List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? reqNo;
  String? reqDate;
  int? projectId;
  String? projectName;
  int? siteId;
  String? siteName;
  String? requestType;
  String? remarks;
  String? status;

  Result({
    this.id,
    this.reqNo,
    this.reqDate,
    this.projectId,
    this.projectName,
    this.siteId,
    this.siteName,
    this.requestType,
    this.remarks,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    reqNo: json["reqNo"],
    reqDate: json["reqDate"],
    projectId: json["projectId"],
    projectName: json["projectName"],
    siteId: json["siteId"],
    siteName: json["siteName"],
    requestType: json["requestType"],
    remarks: json["remarks"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reqNo": reqNo,
    "reqDate": reqDate,
    "projectId": projectId,
    "projectName": projectName,
    "siteId": siteId,
    "siteName": siteName,
    "requestType": requestType,
    "remarks": remarks,
    "status": status,
  };
}
