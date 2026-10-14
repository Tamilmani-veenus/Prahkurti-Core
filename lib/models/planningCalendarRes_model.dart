// To parse this JSON data, do
//
//     final planningCalendarResponse = planningCalendarResponseFromJson(jsonString);

import 'dart:convert';

PlanningCalendarResponse planningCalendarResponseFromJson(String str) => PlanningCalendarResponse.fromJson(json.decode(str));

String planningCalendarResponseToJson(PlanningCalendarResponse data) => json.encode(data.toJson());

class PlanningCalendarResponse {
  bool? success;
  List<PlanningCalendar>? result;
  String? message;

  PlanningCalendarResponse({
    this.success,
    this.result,
    this.message,
  });

  factory PlanningCalendarResponse.fromJson(Map<String, dynamic> json) => PlanningCalendarResponse(
    success: json["success"],
    result: json["result"] == null ? [] : List<PlanningCalendar>.from(json["result"]!.map((x) => PlanningCalendar.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class PlanningCalendar {
  int? id;
  String? meetingTitle;
  DateTime? meetingDate;
  String? meetingDescription;
  String? meetingTime;
  String? meetingStatus;
  int? assignedBy;
  String? active;
  int? createdBy;
  String? createdDate;

  PlanningCalendar({
    this.id,
    this.meetingTitle,
    this.meetingDate,
    this.meetingDescription,
    this.meetingTime,
    this.meetingStatus,
    this.assignedBy,
    this.active,
    this.createdBy,
    this.createdDate,
  });

  factory PlanningCalendar.fromJson(Map<String, dynamic> json) => PlanningCalendar(
    id: json["id"],
    meetingTitle: json["meetingTitle"],
    meetingDate: json["meetingDate"] == null ? null : DateTime.parse(json["meetingDate"]),
    meetingDescription: json["meetingDescription"],
    meetingTime: json["meetingTime"],
    meetingStatus: json["meetingStatus"],
    assignedBy: json["assignedBy"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "meetingTitle": meetingTitle,
    "meetingDate": meetingDate == null ? null : "${meetingDate!.year.toString().padLeft(4, '0')}-${meetingDate!.month.toString().padLeft(2, '0')}-${meetingDate!.day.toString().padLeft(2, '0')}",
    "meetingDescription": meetingDescription,
    "meetingTime": meetingTime,
    "meetingStatus": meetingStatus,
    "assignedBy": assignedBy,
    "active": active,
    "createdBy": createdBy,
    "createdDate": createdDate,
  };
}
