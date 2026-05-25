// To parse this JSON data, do
//
//     final bankNamelistModel = bankNamelistModelFromJson(jsonString);

import 'dart:convert';

BankNamelistModel bankNamelistModelFromJson(String str) => BankNamelistModel.fromJson(json.decode(str));

String bankNamelistModelToJson(BankNamelistModel data) => json.encode(data.toJson());

class BankNamelistModel {
  bool? success;
  String? message;
  List<Result>? result;

  BankNamelistModel({
    this.success,
    this.message,
    this.result,
  });

  factory BankNamelistModel.fromJson(Map<String, dynamic> json) => BankNamelistModel(
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
  String? bankName;
  String? active;
  int? createdBy;
  String? createdDt;

  Result({
    this.id,
    this.bankName,
    this.active,
    this.createdBy,
    this.createdDt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    bankName: json["bankName"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bankName": bankName,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt,
  };
}
