// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  bool? success;
  String? message;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  int? empId;
  int? expiresIn;
  int? userIdleTime;
  String? empName;
  String? userName;
  String? userType;
  int? userId;
  String? userPassword;

  User({
    this.success,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.empId,
    this.expiresIn,
    this.userIdleTime,
    this.empName,
    this.userName,
    this.userType,
    this.userId,
    this.userPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    success: json["success"],
    message: json["message"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    empId: json["employeeID"],
    expiresIn: json["expires_in"],
    userIdleTime: json["userIdleTime"],
    empName: json["employeeName"],
    userName: json["userName"],
    userType: json["userType"],
    userId: json["userId"],
    userPassword: json["userPassword"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "employeeID": empId,
    "expires_in": expiresIn,
    "userIdleTime": userIdleTime,
    "employeeName": empName,
    "userName": userName,
    "userType": userType,
    "userId": userId,
    "userPassword": userPassword,
  };
}
