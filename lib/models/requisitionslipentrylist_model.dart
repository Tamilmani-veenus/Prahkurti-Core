// To parse this JSON data, do
//
//     final requisitonSlipEntrylistResponse = requisitonSlipEntrylistResponseFromJson(jsonString);

import 'dart:convert';

List<RequisitonSlipEntrylistResponse> requisitonSlipEntrylistResponseFromJson(String str) => List<RequisitonSlipEntrylistResponse>.from(json.decode(str).map((x) => RequisitonSlipEntrylistResponse.fromJson(x)));

String requisitonSlipEntrylistResponseToJson(List<RequisitonSlipEntrylistResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequisitonSlipEntrylistResponse {
  RequisitonSlipEntrylistResponse({
    this.requestionId,
    this.requestionNo,
    this.employee,
    this.eDate,
    this.project,
    this.reqType,
    this.status,
  });

  int? requestionId;
  String? requestionNo;
  String? employee;
  String? eDate;
  String? project;
  String? reqType;
  String? status;

  factory RequisitonSlipEntrylistResponse.fromJson(Map<String, dynamic> json) => RequisitonSlipEntrylistResponse(
    requestionId: json["RequestionId"],
    requestionNo: json["Requestion_No"],
    employee: json["employee"],
    eDate: json["EDate"],
    project: json["Project"],
    reqType: json["ReqType"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "RequestionId": requestionId,
    "Requestion_No": requestionNo,
    "employee": employee,
    "EDate": eDate,
    "Project": project,
    "ReqType": reqType,
    "Status": status,
  };
}