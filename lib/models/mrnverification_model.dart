// To parse this JSON data, do
//
//     final mrnVerificationResponse = mrnVerificationResponseFromJson(jsonString);

import 'dart:convert';

MrnVerificationResponse mrnVerificationResponseFromJson(String str) => MrnVerificationResponse.fromJson(json.decode(str));

String mrnVerificationResponseToJson(MrnVerificationResponse data) => json.encode(data.toJson());

class MrnVerificationResponse {
  bool? success;
  List<Result>? result;

  MrnVerificationResponse({
    this.success,
    this.result,
  });

  factory MrnVerificationResponse.fromJson(Map<String, dynamic> json) => MrnVerificationResponse(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? reqOrdNo;
  String? reqOrdDate;
  String? reqdueDate;
  String? requestType;
  int? projectId;
  int? siteId;
  String? siteName;
  String? createdName;
  String? projectName;

  Result({
    this.id,
    this.reqOrdNo,
    this.reqOrdDate,
    this.reqdueDate,
    this.requestType,
    this.projectId,
    this.siteId,
    this.siteName,
    this.createdName,
    this.projectName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    reqOrdNo: json["reqOrdNo"],
    reqOrdDate: json["reqOrdDate"],
    reqdueDate: json["reqdueDate"],
    requestType: json["requestType"],
    projectId: json["projectID"],
    siteId: json["siteID"],
    siteName: json["siteName"],
    createdName: json["createdName"],
    projectName: json["projectName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reqOrdNo": reqOrdNo,
    "reqOrdDate": reqOrdDate,
    "reqdueDate": reqdueDate,
    "requestType": requestType,
    "projectID": projectId,
    "siteID": siteId,
    "siteName": siteName,
    "createdName": createdName,
    "projectName": projectName,
  };
}
