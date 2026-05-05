// To parse this JSON data, do
//
//     final paymentTypeReponse = paymentTypeReponseFromJson(jsonString);

import 'dart:convert';

PaymentTypeReponse paymentTypeReponseFromJson(String str) => PaymentTypeReponse.fromJson(json.decode(str));

String paymentTypeReponseToJson(PaymentTypeReponse data) => json.encode(data.toJson());

class PaymentTypeReponse {
  bool? success;
  String? message;
  List<Result>? result;

  PaymentTypeReponse({
    this.success,
    this.message,
    this.result,
  });

  factory PaymentTypeReponse.fromJson(Map<String, dynamic> json) => PaymentTypeReponse(
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
  int? id;
  String? paymentTypeName;
  String? paymentTypeValue;

  Result({
    this.id,
    this.paymentTypeName,
    this.paymentTypeValue,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    paymentTypeName: json["paymentTypeName"],
    paymentTypeValue: json["paymentTypeValue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paymentTypeName": paymentTypeName,
    "paymentTypeValue": paymentTypeValue,
  };
}
