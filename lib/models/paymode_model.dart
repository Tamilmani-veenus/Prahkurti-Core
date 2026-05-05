// To parse this JSON data, do
//
//     final payModeReponse = payModeReponseFromJson(jsonString);

import 'dart:convert';

PayModeReponse payModeReponseFromJson(String str) => PayModeReponse.fromJson(json.decode(str));

String payModeReponseToJson(PayModeReponse data) => json.encode(data.toJson());

class PayModeReponse {
  bool? success;
  String? message;
  List<Result>? result;

  PayModeReponse({
    this.success,
    this.message,
    this.result,
  });

  factory PayModeReponse.fromJson(Map<String, dynamic> json) => PayModeReponse(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? paymodeid;
  String? paymode;

  Result({
    this.paymodeid,
    this.paymode,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    paymodeid: json["id"],
    paymode: json["payMode"],
  );

  Map<String, dynamic> toJson() => {
    "id": paymodeid,
    "payMode": paymode,
  };
}
