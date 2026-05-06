// To parse this JSON data, do
//
//     final attendanceReportListResponse = attendanceReportListResponseFromJson(jsonString);

import 'dart:convert';

AttendanceReportListResponse attendanceReportListResponseFromJson(String str) => AttendanceReportListResponse.fromJson(json.decode(str));

String attendanceReportListResponseToJson(AttendanceReportListResponse data) => json.encode(data.toJson());

class AttendanceReportListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  AttendanceReportListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory AttendanceReportListResponse.fromJson(Map<String, dynamic> json) => AttendanceReportListResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?null:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? attenId;
  String? attenDate;
  String? attenNo;
  String? appStatus;
  String? projectName;
  String? subContName;
  String? WorkType;
  String? ShiftName;

  Result({
    this.attenId,
    this.attenDate,
    this.attenNo,
    this.appStatus,
    this.projectName,
    this.subContName,
    this.WorkType,
    this.ShiftName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    attenId: json["id"],
    attenDate: json["AttendanceDate"],
    attenNo: json["LabrAttn_No"],
    appStatus: json["ApproveStatus"],
    projectName: json["Project"],
    subContName:  json["Subcon_name"],
    WorkType: json["WorkType"],
    ShiftName: json["WorkShiftName"],
  );

  Map<String, dynamic> toJson() => {
    "id": attenId,
    "AttendanceDate": attenDate,
    "LabrAttn_No": attenNo,
    "ApproveStatus": appStatus,
    "Project": projectName,
    "Subcon_name": subContName,
    "WorkType": WorkType,
    "WorkShiftName": ShiftName,
  };
}
