// To parse this JSON data, do
//
//     final staffLeaveDetails = staffLeaveDetailsFromJson(jsonString);

// To parse this JSON data, do
//
//     final staffLeaveDetails = staffLeaveDetailsFromJson(jsonString);

import 'dart:convert';

List<StaffLeaveDetails> staffLeaveDetailsFromJson(String str) => List<StaffLeaveDetails>.from(json.decode(str).map((x) => StaffLeaveDetails.fromJson(x)));

String staffLeaveDetailsToJson(List<StaffLeaveDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffLeaveDetails {
  double? leaveDays;
  double? leaveHours;

  StaffLeaveDetails({
   this.leaveDays,
   this.leaveHours,
  });

  factory StaffLeaveDetails.fromJson(Map<String, dynamic> json) => StaffLeaveDetails(
    leaveDays: json["LeaveDays"],
    leaveHours: json["LeaveHours"],
  );

  Map<String, dynamic> toJson() => {
    "LeaveDays": leaveDays,
    "LeaveHours": leaveHours,
  };
}


StaffLeaveRes staffLeaveResFromJson(String str) => StaffLeaveRes.fromJson(json.decode(str));

String staffLeaveResToJson(StaffLeaveRes data) => json.encode(data.toJson());

class StaffLeaveRes {
  String? retString;

  StaffLeaveRes({
    this.retString,
  });

  factory StaffLeaveRes.fromJson(Map<String, dynamic> json) => StaffLeaveRes(
    retString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": retString,
  };
}


