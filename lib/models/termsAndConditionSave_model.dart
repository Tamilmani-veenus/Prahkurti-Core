// To parse this JSON data, do
//
//     final termsandConditionSaveRes = termsandConditionSaveResFromJson(jsonString);

import 'dart:convert';

TermsandConditionSaveRes termsandConditionSaveResFromJson(String str) => TermsandConditionSaveRes.fromJson(json.decode(str));

String termsandConditionSaveResToJson(TermsandConditionSaveRes data) => json.encode(data.toJson());

class TermsandConditionSaveRes {
  int? id;
  String? termsAndCondition;
  bool? active;
  int? createdBy;
  String? createdDt;

  TermsandConditionSaveRes({
    this.id,
    this.termsAndCondition,
    this.active,
    this.createdBy,
    this.createdDt,
  });

  factory TermsandConditionSaveRes.fromJson(Map<String, dynamic> json) => TermsandConditionSaveRes(
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
