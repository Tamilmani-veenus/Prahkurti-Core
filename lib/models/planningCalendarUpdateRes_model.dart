// To parse this JSON data, do
//
//     final planningCalendarSaveResponse = planningCalendarSaveResponseFromJson(jsonString);

import 'dart:convert';

PlanningCalendarSaveResponse planningCalendarSaveResponseFromJson(String str) => PlanningCalendarSaveResponse.fromJson(json.decode(str));

String planningCalendarSaveResponseToJson(PlanningCalendarSaveResponse data) => json.encode(data.toJson());

class PlanningCalendarSaveResponse {
  int? id;
  String? meetingTitle;
  String? meetingDate;
  String? meetingDescription;
  String? meetingTime;
  String? meetingStatus;
  int? assignedBy;
  int? createdBy;
  String? createdDate;
  String? active;

  PlanningCalendarSaveResponse({
    this.id,
    this.meetingTitle,
    this.meetingDate,
    this.meetingDescription,
    this.meetingTime,
    this.meetingStatus,
    this.assignedBy,
    this.createdBy,
    this.createdDate,
    this.active,
  });

  factory PlanningCalendarSaveResponse.fromJson(Map<String, dynamic> json) => PlanningCalendarSaveResponse(
    id: json["id"],
    meetingTitle: json["meetingTitle"],
    meetingDate: json["meetingDate"],
    meetingDescription: json["meetingDescription"],
    meetingTime: json["meetingTime"],
    meetingStatus: json["meetingStatus"],
    assignedBy: json["assignedBy"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "meetingTitle": meetingTitle,
    "meetingDate": meetingDate,
    "meetingDescription": meetingDescription,
    "meetingTime": meetingTime,
    "meetingStatus": meetingStatus,
    "assignedBy": assignedBy,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "active": active,
  };
}
