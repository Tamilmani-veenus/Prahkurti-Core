import 'dart:convert';

class LoginDetailsPayload {
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

  LoginDetailsPayload({
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

  Map<String, dynamic> toMap() {
    return {
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

  factory LoginDetailsPayload.fromMap(Map<String, dynamic> map) {
    return LoginDetailsPayload(
      success: map["success"],
      message: map["message"],
      accessToken: map["access_token"],
      refreshToken: map["refresh_token"],
      tokenType: map["token_type"],
      empId: map["employeeID"],
      expiresIn: map["expires_in"],
      userIdleTime: map["userIdleTime"],
      empName: map["employeeName"],
      userName: map["userName"],
      userType: map["userType"],
      userId: map["userId"],
      userPassword: map["userPassword"],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDetailsPayload.fromJson(String source) =>
      LoginDetailsPayload.fromMap(json.decode(source));
}