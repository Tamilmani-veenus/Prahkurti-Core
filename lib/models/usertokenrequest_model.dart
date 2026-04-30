// To parse this JSON data, do
//
//     final usertokenRequest = usertokenRequestFromJson(jsonString);

import 'dart:convert';

UsertokenRequest usertokenRequestFromJson(String str) => UsertokenRequest.fromJson(json.decode(str));

String usertokenRequestToJson(UsertokenRequest data) => json.encode(data.toJson());

class UsertokenRequest {
  UsertokenRequest({
    this.userId,
    this.deviceId,
    this.token,
  });

  String? userId;
  String? deviceId;
  String? token;

  factory UsertokenRequest.fromJson(Map<String, dynamic> json) => UsertokenRequest(
    userId: json["UserId"],
    deviceId: json["DeviceID"],
    token: json["Token"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "DeviceID": deviceId,
    "Token": token,
  };
}
