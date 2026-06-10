// To parse this JSON data, do
//
//     final dprHeadNameListModel = dprHeadNameListModelFromJson(jsonString);

import 'dart:convert';

DprHeadNameListModel dprHeadNameListModelFromJson(String str) => DprHeadNameListModel.fromJson(json.decode(str));

String dprHeadNameListModelToJson(DprHeadNameListModel data) => json.encode(data.toJson());

class DprHeadNameListModel {
  bool? success;
  String? message;
  List<Result>? result;

  DprHeadNameListModel({
    this.success,
    this.message,
    this.result
  });

  factory DprHeadNameListModel.fromJson(Map<String, dynamic> json) => DprHeadNameListModel(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? headItemName;
  String? headName;

  Result({
    this.id,
    this.headItemName,
    this.headName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    headItemName: json["headItemName"],
    headName: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "headItemName": headItemName,
    "name": headName,
  };
}
