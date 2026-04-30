// To parse this JSON data, do
//
//     final siteLocationResponse = siteLocationResponseFromJson(jsonString);

import 'dart:convert';

SiteLocationResponse siteLocationResponseFromJson(String str) => SiteLocationResponse.fromJson(json.decode(str));

String siteLocationResponseToJson(SiteLocationResponse data) => json.encode(data.toJson());

class SiteLocationResponse {
  bool? success;
  List<Result>? result;
  String? message;

  SiteLocationResponse({
    this.success,
    this.result,
    this.message
  });

  factory SiteLocationResponse.fromJson(Map<String, dynamic> json) => SiteLocationResponse(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message":message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? punchId;
  int? projectId;
  String? projectName;
  String? punchStatus;
  int? locid;
  int? radius;
  String? longitude;
  String? latitude;
  String? pinStatus;
  String? status;

  Result({
    this.punchId,
    this.projectId,
    this.projectName,
    this.punchStatus,
    this.locid,
    this.radius,
    this.longitude,
    this.latitude,
    this.pinStatus,
    this.status,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    punchId: json["PunchID"],
    projectId: json["Projectid"],
    projectName: json["ProjectName"],
    punchStatus: json["PunchStatus"],
    locid: json["Locid"],
    radius: json["Radius"],
    longitude: json["Longitude"],
    latitude: json["Latitude"],
    pinStatus: json["PinStatus"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "PunchID": punchId,
    "Projectid": projectId,
    "ProjectName": projectName,
    "PunchStatus": punchStatus,
    "Locid": locid,
    "Radius": radius,
    "Longitude": longitude,
    "Latitude": latitude,
    "PinStatus": pinStatus,
    "Status": status,
  };
}
