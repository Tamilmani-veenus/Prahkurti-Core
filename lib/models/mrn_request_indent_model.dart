// To parse this JSON data, do
//
//     final mrNentrylist = mrNentrylistFromJson(jsonString);

import 'dart:convert';

MrNentrylist mrNentrylistFromJson(String str) => MrNentrylist.fromJson(json.decode(str));

String mrNentrylistToJson(MrNentrylist data) => json.encode(data.toJson());

class MrNentrylist {
  bool? success;
  String? message;
  List<MrnRequestResult >? result;

  MrNentrylist({
    this.success,
    this.message,
    this.result,
  });

  factory MrNentrylist.fromJson(Map<String, dynamic> json) => MrNentrylist(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null
        ? []
        : List<MrnRequestResult>.from(
        json["result"].map((x) => MrnRequestResult.fromJson(x))),  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class MrnRequestResult   {
  MrnRequestResult ({
    this.reqMasId,
    this.projectid,
    this.siteid,
    this.reqOrdNo,
    // this.reqOrdDate1,
    this.reqOrdDate,
    this.reqDueDate,
    this.project,
    this.sitename,
    this.Preparedby,
    this.purchaseType,
  });

  int? reqMasId;
  int? projectid;
  int? siteid;
  String? reqOrdNo;
  // String? reqOrdDate1;
  String? reqOrdDate;
  String? reqDueDate;
  String? project;
  String? sitename;
  String? Preparedby;
  String? purchaseType;

  factory MrnRequestResult .fromJson(Map<String, dynamic> json) => MrnRequestResult (
    reqMasId: json["id"],
    projectid: json["projectID"],
    siteid: json["siteID"],
    reqOrdNo: json["reqOrdNo"],
    // reqOrdDate1: json["req_ord_date1"],
    reqOrdDate: json["reqOrdDate"],
    reqDueDate: json["reqdueDate"],
    project: json["projectName"],
    sitename: json["siteName"],
    Preparedby: json["createdName"],
    purchaseType: json["requestType"],
  );

  Map<String, dynamic> toJson() => {
    "req_mas_id": reqMasId,
    "projectID": projectid,
    "siteID": siteid,
    "siteName": sitename,
    "reqOrdNo": reqOrdNo,
    // "req_ord_date1": reqOrdDate1,
    "reqOrdDate": reqOrdDate,
    "reqdueDate": reqDueDate,
    "projectName": project,
    "createdName": Preparedby,
    "requestType": purchaseType,
  };
}
