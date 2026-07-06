// To parse this JSON data, do
//
//     final registerPayload = registerPayloadFromJson(jsonString);

import 'dart:convert';

RegisterPayload registerPayloadFromJson(String str) => RegisterPayload.fromJson(json.decode(str));

String registerPayloadToJson(RegisterPayload data) => json.encode(data.toJson());

class RegisterPayload {
  int? id;
  String? userName;
  String? userPassword;
  String? userType;
  int? employeeId;
  int? userGroupId;
  int? menuTypeId;
  List<int>? companyId;
  List<int>? projectId;
  String? mobileActive;
  String? active;
  int? createdBy;
  String? employeeName;
  String? createdDt;

  RegisterPayload({
    this.id,
    this.userName,
    this.userPassword,
    this.userType,
    this.employeeId,
    this.userGroupId,
    this.menuTypeId,
    this.companyId,
    this.projectId,
    this.mobileActive,
    this.active,
    this.createdBy,
    this.employeeName,
    this.createdDt,
  });

  factory RegisterPayload.fromJson(Map<String, dynamic> json) => RegisterPayload(
    id: json["id"],
    userName: json["userName"],
    userPassword: json["userPassword"],
    userType: json["userType"],
    employeeId: json["employeeID"],
    userGroupId: json["userGroupID"],
    menuTypeId: json["menuTypeID"],
    companyId: List<int>.from(json["companyID"].map((x) => x)),
    projectId: List<int>.from(json["projectID"].map((x) => x)),
    mobileActive: json["mobileActive"],
    active: json["active"],
    createdBy: json["createdBy"],
    employeeName: json["employeeName"],
    createdDt: json["createdDt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "userPassword": userPassword,
    "userType": userType,
    "employeeID": employeeId,
    "userGroupID": userGroupId,
    "menuTypeID": menuTypeId,
    "companyID": List<dynamic>.from(companyId!.map((x) => x)),
    "projectID": List<dynamic>.from(projectId!.map((x) => x)),
    "mobileActive": mobileActive,
    "active": active,
    "createdBy": createdBy,
    "employeeName": employeeName,
    "createdDt": createdDt,
  };
}

class RegistrationResponse {
  bool? success;
  String? message;

  RegistrationResponse({this.success, this.message});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
