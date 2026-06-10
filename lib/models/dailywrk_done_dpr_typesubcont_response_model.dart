// To parse this JSON data, do
//
//     final dprTypeSucontResponse = dprTypeSucontResponseFromJson(jsonString);

import 'dart:convert';

DprTypeSucontResponse dprTypeSucontResponseFromJson(String str) => DprTypeSucontResponse.fromJson(json.decode(str));

String dprTypeSucontResponseToJson(DprTypeSucontResponse data) => json.encode(data.toJson());

class DprTypeSucontResponse {
  bool? success;
  List<Result>? result;
  String? message;

  DprTypeSucontResponse({
    this.success,
    this.result,
    this.message,
  });

  factory DprTypeSucontResponse.fromJson(Map<String, dynamic> json) => DprTypeSucontResponse(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class Result {
  int? subContId;
  int? subContractorId;
  String? subContName;

  Result({
    this.subContId,
    this.subContractorId,
    this.subContName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    subContId: json["id"],
    subContractorId: json["subContractorId"],
    subContName: json["subContractorName"],
  );

  Map<String, dynamic> toJson() => {
    "id": subContId,
    "subContractorId": subContractorId,
    "subContractorName": subContName,
  };
}
