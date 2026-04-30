// To parse this JSON data, do
//
//     final mrnPreApprovalResponse = mrnPreApprovalResponseFromJson(jsonString);

import 'dart:convert';

MrnPreApprovalResponse mrnPreApprovalResponseFromJson(String str) => MrnPreApprovalResponse.fromJson(json.decode(str));

String mrnPreApprovalResponseToJson(MrnPreApprovalResponse data) => json.encode(data.toJson());

class MrnPreApprovalResponse {
  bool? success;
  List<Result>? result;

  MrnPreApprovalResponse({
    this.success,
    this.result,
  });

  factory MrnPreApprovalResponse.fromJson(Map<String, dynamic> json) => MrnPreApprovalResponse(
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
  String? verifyName;
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
    this.verifyName,
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
    verifyName: json["verifyName"],
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
    "verifyName": verifyName,
    "projectName": projectName,
  };
}
