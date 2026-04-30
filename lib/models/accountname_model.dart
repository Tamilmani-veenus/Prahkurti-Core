// To parse this JSON data, do
//
//     final accountNameReponse = accountNameReponseFromJson(jsonString);

import 'dart:convert';

AccountNameReponse accountNameReponseFromJson(String str) => AccountNameReponse.fromJson(json.decode(str));

String accountNameReponseToJson(AccountNameReponse data) => json.encode(data.toJson());

class AccountNameReponse {
  bool? success;
  String? message;
  List<Result>? result;

  AccountNameReponse({
    this.success,
    this.message,
    this.result,
  });

  factory AccountNameReponse.fromJson(Map<String, dynamic> json) => AccountNameReponse(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? accNameid;
  String? accName;
  int? accountTypeId;
  String? accountTypeName;

  Result({
    this.accNameid,
    this.accName,
    this.accountTypeId,
    this.accountTypeName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    accNameid: json["id"],
    accName: json["accountName"],
    accountTypeId: json["accountTypeId"],
    accountTypeName: json["accountTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": accNameid,
    "accountName": accName,
    "accountTypeId": accountTypeId,
    "accountTypeName": accountTypeName,
  };
}
