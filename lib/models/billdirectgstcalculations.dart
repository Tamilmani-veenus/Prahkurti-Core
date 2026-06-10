// To parse this JSON data, do
//
//     final billDirectDetCalculations = billDirectDetCalculationsFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

BillDirectDetCalculations billDirectDetCalculationsFromJson(String str) => BillDirectDetCalculations.fromJson(json.decode(str));

String billDirectDetCalculationsToJson(BillDirectDetCalculations data) => json.encode(data.toJson());

class BillDirectDetCalculations {
  bool? success;
  List<Result>? result;
  String? message;


  BillDirectDetCalculations({
    this.success,
    this.result,
    this.message,
  });

  factory BillDirectDetCalculations.fromJson(Map<String, dynamic> json) => BillDirectDetCalculations(
    success: json["success"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? id;
  String? addLessName;
  String? addLessType;
  dynamic active;
  int? createdBy;
  String? createdDt;
  RxDouble percentage = 0.0.obs;
  RxDouble amount = 0.0.obs;


  Result({
    this.id,
    this.addLessName,
    this.addLessType,
    this.active,
    this.createdBy,
    this.createdDt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    addLessName: json["addLessName"],
    addLessType: json["addLessType"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addLessName": addLessName,
    "addLessType": addLessType,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt,
  };
}
