// To parse this JSON data, do
//
//     final consumptionTypeResponse = consumptionTypeResponseFromJson(jsonString);

import 'dart:convert';

ConsumptionTypeResponse consumptionTypeResponseFromJson(String str) => ConsumptionTypeResponse.fromJson(json.decode(str));

String consumptionTypeResponseToJson(ConsumptionTypeResponse data) => json.encode(data.toJson());

class ConsumptionTypeResponse {
  bool? success;
  String? message;
  List<Result>? result;

  ConsumptionTypeResponse({
    this.success,
    this.message,
    this.result,
  });

  factory ConsumptionTypeResponse.fromJson(Map<String, dynamic> json) => ConsumptionTypeResponse(
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
  String? typeId;
  String? typeName;

  Result({
    this.typeId,
    this.typeName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    typeId: json["typeId"],
    typeName: json["typeName"],
  );

  Map<String, dynamic> toJson() => {
    "typeId": typeId,
    "typeName": typeName,
  };
}
