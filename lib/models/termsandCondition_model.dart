// To parse this JSON data, do
//
//     final termsandCondition = termsandConditionFromJson(jsonString);

import 'dart:convert';

TermsandCondition termsandConditionFromJson(String str) => TermsandCondition.fromJson(json.decode(str));

String termsandConditionToJson(TermsandCondition data) => json.encode(data.toJson());

class TermsandCondition {
  bool? success;
  List<Result>? result;
  String? message;

  TermsandCondition({
    this.success,
    this.result,
    this.message
  });

  factory TermsandCondition.fromJson(Map<String, dynamic> json) => TermsandCondition(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? id;
  String? termsAndCondition;
  bool? active;
  int? createdBy;
  String? createdDt;

  Result({
    this.id,
    this.termsAndCondition,
    this.active,
    this.createdBy,
    this.createdDt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    termsAndCondition: json["termsAndCondition"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "termsAndCondition": termsAndCondition,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt,
  };
}
