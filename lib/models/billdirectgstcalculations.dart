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
  RxDouble percentage;
  RxDouble amount = 0.0.obs;


  Result({
    this.id,
    this.addLessName,
    this.addLessType,
    this.active,
    this.createdBy,
    this.createdDt,
    double percentage = 0.0,
  })  : percentage = percentage.obs;


  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] ?? json["addLessId"],
    addLessName: json["addLessName"] ?? json["AddLessName"],
    addLessType: json["addLessType"] ?? json["AddLessType"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    percentage: (json["PercentValue"] as num?)?.toDouble() ??
        (json["percentValue"] as num?)?.toDouble() ??
        0.0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addLessName": addLessName,
    "addLessType": addLessType,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "percentage": percentage.value,
  };
}
