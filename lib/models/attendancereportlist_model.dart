
import 'dart:convert';

List<AttendanceReportListResponse> attendanceReportListResponseFromJson(String str) => List<AttendanceReportListResponse>.from(json.decode(str).map((x) => AttendanceReportListResponse.fromJson(x)));

String attendanceReportListResponseToJson(List<AttendanceReportListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceReportListResponse {
  AttendanceReportListResponse({
    this.attenId,
    this.attenNo,
    this.attenDate,
    this.shiftName,
    this.projectName,
    this.subContName,
    this.appStatus,
    this.WorkType,
    this.ShiftName,
  });

  int? attenId;
  String? attenNo;
  String? attenDate;
  String? shiftName;
  String? projectName;
  String? subContName;
  String? appStatus;
  String? WorkType;
  String? ShiftName;

  factory AttendanceReportListResponse.fromJson(Map<String, dynamic> json) => AttendanceReportListResponse(
    attenId: json["AttenId"],
    attenNo: json["AttenNo"],
    attenDate: json["AttenDate"],
    shiftName: json["ShiftName"],
    projectName:json["ProjectName"],
    subContName: json["SubContName"],
    appStatus: json["AppStatus"],
    WorkType: json["WorkType"],
    ShiftName: json["ShiftName"],
  );

  Map<String, dynamic> toJson() => {
    "AttenId": attenId,
    "AttenNo": attenNo,
    "AttenDate": attenDate,
    "ShiftName": shiftName,
    "ProjectName": projectName,
    "SubContName": subContName,
    "AppStatus": appStatus ,
    "WorkType": WorkType ,
    "ShiftName": ShiftName ,
  };
}




