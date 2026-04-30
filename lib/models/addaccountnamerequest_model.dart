// To parse this JSON data, do
//
//     final accountnamesaveRequest = accountnamesaveRequestFromJson(jsonString);

import 'dart:convert';

AccountnamesaveRequest accountnamesaveRequestFromJson(String str) => AccountnamesaveRequest.fromJson(json.decode(str));

String accountnamesaveRequestToJson(AccountnamesaveRequest data) => json.encode(data.toJson());

class AccountnamesaveRequest {
  AccountnamesaveRequest({
    this.accTypeId,
    this.accNameId,
    this.accName,
  });

  String? accTypeId;
  String? accNameId;
  String? accName;

  factory AccountnamesaveRequest.fromJson(Map<String, dynamic> json) => AccountnamesaveRequest(
    accTypeId: json["AccTypeId"],
    accNameId: json["AccNameId"],
    accName: json["AccName"],
  );

  Map<String, dynamic> toJson() => {
    "AccTypeId": accTypeId,
    "AccNameId": accNameId,
    "AccName": accName,
  };
}
