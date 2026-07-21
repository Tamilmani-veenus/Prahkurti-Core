// To parse this JSON data, do
//
//     final manPowerCategoryListModel = manPowerCategoryListModelFromJson(jsonString);

import 'dart:convert';

ManPowerCategoryListModel manPowerCategoryListModelFromJson(String str) => ManPowerCategoryListModel.fromJson(json.decode(str));

String manPowerCategoryListModelToJson(ManPowerCategoryListModel data) => json.encode(data.toJson());

class ManPowerCategoryListModel {
  bool? success;
  String? message;
  List<Result>? result;

  ManPowerCategoryListModel({
    this.success,
    this.message,
    this.result,
  });

  factory ManPowerCategoryListModel.fromJson(Map<String, dynamic> json) => ManPowerCategoryListModel(
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
  String? labourCategoryName;
  String? active;

  Result({
    this.id,
    this.labourCategoryName,
    this.active,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    labourCategoryName: json["labourCategoryName"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "labourCategoryName": labourCategoryName,
    "active": active,
  };
}
