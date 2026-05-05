// To parse this JSON data, do
//
//     final accountnamesaveRequest = accountnamesaveRequestFromJson(jsonString);

import 'dart:convert';

AccountnamesaveRequest accountnamesaveRequestFromJson(String str) => AccountnamesaveRequest.fromJson(json.decode(str));

String accountnamesaveRequestToJson(AccountnamesaveRequest data) => json.encode(data.toJson());

class AccountnamesaveRequest {
  int? id;
  int? accountTypeId;
  int? accountHeadId;
  int? accountMainGroupId;
  String? accountName;
  String? active;

  AccountnamesaveRequest({
    this.id,
    this.accountTypeId,
    this.accountHeadId,
    this.accountMainGroupId,
    this.accountName,
    this.active,
  });

  factory AccountnamesaveRequest.fromJson(Map<String, dynamic> json) => AccountnamesaveRequest(
    id: json["id"],
    accountTypeId: json["accountTypeId"],
    accountHeadId: json["accountHeadId"],
    accountMainGroupId: json["accountMainGroupId"],
    accountName: json["accountName"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountTypeId": accountTypeId,
    "accountHeadId": accountHeadId,
    "accountMainGroupId": accountMainGroupId,
    "accountName": accountName,
    "active": active,
  };
}
