// To parse this JSON data, do
//
//     final getPunchTypeListRes = getPunchTypeListResFromJson(jsonString);

import 'dart:convert';

GetPunchTypeListRes getPunchTypeListResFromJson(String str) => GetPunchTypeListRes.fromJson(json.decode(str));

String getPunchTypeListResToJson(GetPunchTypeListRes data) => json.encode(data.toJson());

class GetPunchTypeListRes {
  bool? success;
  String? message;
  List<Result>? result;

  GetPunchTypeListRes({
    this.success,
    this.message,
    this.result
  });

  factory GetPunchTypeListRes.fromJson(Map<String, dynamic> json) => GetPunchTypeListRes(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? punchinandOutType;
  String? punchinandOutValues;
  int? createdBy;
  String? createdDate;
  String? active;

  Result({
    this.id,
    this.punchinandOutType,
    this.punchinandOutValues,
    this.createdBy,
    this.createdDate,
    this.active,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    punchinandOutType: json["punchinandOutType"],
    punchinandOutValues: json["punchinandOutValues"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "punchinandOutType": punchinandOutType,
    "punchinandOutValues": punchinandOutValues,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "active": active,
  };
}
