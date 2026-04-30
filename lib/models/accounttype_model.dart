// To parse this JSON data, do
//
//     final accountTypeReponse = accountTypeReponseFromJson(jsonString);

import 'dart:convert';

AccountTypeReponse accountTypeReponseFromJson(String str) => AccountTypeReponse.fromJson(json.decode(str));

String accountTypeReponseToJson(AccountTypeReponse data) => json.encode(data.toJson());

class AccountTypeReponse {
  bool? success;
  String? message;
  List<Result>? result;

  AccountTypeReponse({
    this.success,
    this.result,
    this.message,
  });

  factory AccountTypeReponse.fromJson(Map<String, dynamic> json) => AccountTypeReponse(
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
  int? accTypeid;
  String? accType;

  Result({
    this.accTypeid,
    this.accType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    accTypeid: json["id"],
    accType: json["accountTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": accTypeid,
    "accountTypeName": accType,
  };
}
