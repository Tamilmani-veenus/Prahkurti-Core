// To parse this JSON data, do
//
//     final payforReponse = payforReponseFromJson(jsonString);

import 'dart:convert';

PayforReponse payforReponseFromJson(String str) => PayforReponse.fromJson(json.decode(str));

String payforReponseToJson(PayforReponse data) => json.encode(data.toJson());

class PayforReponse {
  bool? success;
  String? message;
  List<Result>? result;

  PayforReponse({
    this.success,
    this.message,
    this.result,
  });

  factory PayforReponse.fromJson(Map<String, dynamic> json) => PayforReponse(
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
  String? acPayForId;
  String? acPayForName;

  Result({
    this.acPayForId,
    this.acPayForName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    acPayForId: json["accountPayForType"],
    acPayForName: json["accountPayForName"],
  );

  Map<String, dynamic> toJson() => {
    "accountPayForType": acPayForId,
    "accountPayForName": acPayForName,
  };
}
