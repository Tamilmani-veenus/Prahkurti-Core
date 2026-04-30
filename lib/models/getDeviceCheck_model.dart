// To parse this JSON data, do
//
//     final getDeviceCheckResponse = getDeviceCheckResponseFromJson(jsonString);

import 'dart:convert';

GetDeviceCheckResponse getDeviceCheckResponseFromJson(String str) => GetDeviceCheckResponse.fromJson(json.decode(str));

String getDeviceCheckResponseToJson(GetDeviceCheckResponse data) => json.encode(data.toJson());

class GetDeviceCheckResponse {
  String? status;
  String? message;
  String? userType;

  GetDeviceCheckResponse({
    this.status,
    this.message,
    this.userType,
  });

  factory GetDeviceCheckResponse.fromJson(Map<String, dynamic> json) => GetDeviceCheckResponse(
    status: json["Status"],
    message: json["Message"],
    userType: json["UserType"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "UserType": userType,
  };
}
