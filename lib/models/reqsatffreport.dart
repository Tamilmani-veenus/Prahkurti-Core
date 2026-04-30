// To parse this JSON data, do
//
//     final staffLeaveReport = staffLeaveReportFromJson(jsonString);

import 'dart:convert';

List<StaffLeaveReport> staffLeaveReportFromJson(String str) => List<StaffLeaveReport>.from(json.decode(str).map((x) => StaffLeaveReport.fromJson(x)));

String staffLeaveReportToJson(List<StaffLeaveReport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffLeaveReport {
  int? requestionId;
  String? requestionNo;
  String? eDate;
  String? employee;
  String? reqType;
  String? status;
  String? perFrmDate;
  String? perToDate;
  String? perFrmTime;
  String? perToTime;
  String? perReason;
  double? perTotHours;
  String? leaveFrmDate;
  String? leaveToDate;
  String? leaveReason;
  String? company;
  double? perTotDays;
  int? pTimeMins;
  int? pTimeHrs;

  StaffLeaveReport({
    this.requestionId,
    this.requestionNo,
    this.eDate,
    this.employee,
    this.reqType,
    this.status,
    this.perFrmDate,
    this.perToDate,
    this.perFrmTime,
    this.perToTime,
    this.perReason,
    this.perTotHours,
    this.leaveFrmDate,
    this.leaveToDate,
    this.leaveReason,
    this.company,
    this.perTotDays,
    this.pTimeMins,
    this.pTimeHrs,
  });

  factory StaffLeaveReport.fromJson(Map<String, dynamic> json) => StaffLeaveReport(
    requestionId: json["RequestionId"],
    requestionNo: json["Requestion_No"],
    eDate: json["EDate"],
    employee: json["Employee"],
    reqType: json["ReqType"],
    status: json["Status"],
    perFrmDate: json["Per_FrmDate"],
    perToDate: json["Per_ToDate"],
    perFrmTime: json["Per_FrmTime"],
    perToTime: json["Per_ToTime"],
    perReason: json["Per_Reason"],
    perTotHours: json["Per_TotHours"],
    leaveFrmDate: json["Leave_FrmDate"],
    leaveToDate: json["Leave_ToDate"],
    leaveReason: json["Leave_Reason"],
    company: json["Company"],
    perTotDays: json["Per_TotDays"],
    pTimeMins: json["PTimeMins"],
    pTimeHrs: json["PTimeHrs"],
  );

  Map<String, dynamic> toJson() => {
    "RequestionId": requestionId,
    "Requestion_No": requestionNo,
    "EDate": eDate,
    "Employee": employee,
    "ReqType": reqType,
    "Status": status,
    "Per_FrmDate": perFrmDate,
    "Per_ToDate": perToDate,
    "Per_FrmTime": perFrmTime,
    "Per_ToTime": perToTime,
    "Per_Reason": perReason,
    "Per_TotHours": perTotHours,
    "Leave_FrmDate": leaveFrmDate,
    "Leave_ToDate": leaveToDate,
    "Leave_Reason": leaveReason,
    "Company": company,
    "Per_TotDays": perTotDays,
    "PTimeMins": pTimeMins,
    "PTimeHrs": pTimeHrs,
  };
}
