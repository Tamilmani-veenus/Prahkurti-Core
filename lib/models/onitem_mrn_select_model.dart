// To parse this JSON data, do
//
//     final onItemSelectMrnList = onItemSelectMrnListFromJson(jsonString);

import 'dart:convert';

OnItemSelectMrnList onItemSelectMrnListFromJson(String str) => OnItemSelectMrnList.fromJson(json.decode(str));

String onItemSelectMrnListToJson(OnItemSelectMrnList data) => json.encode(data.toJson());

class OnItemSelectMrnList {
  bool? success;
  String? message;
  List<Result>? result;

  OnItemSelectMrnList({
    this.success,
    this.message,
    this.result,
  });

  factory OnItemSelectMrnList.fromJson(Map<String, dynamic> json) => OnItemSelectMrnList(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null?[] :List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? materialName;
  int? scaleId;
  String? scaleName;
  double? reqQty;
  double? appqty;
  String? remarks;
  String? approveType;

  Result({
    this.materialName,
    this.scaleId,
    this.scaleName,
    this.reqQty,
    this.appqty,
    this.remarks,
    this.approveType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    materialName: json["MaterialName"],
    scaleId: json["ScaleID"],
    scaleName: json["ScaleName"],
    reqQty: json["ReqQty"],
    appqty: json["appqty"],
    remarks: json["remarks"],
    approveType: json["ApproveType"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialName": materialName,
    "ScaleID": scaleId,
    "ScaleName": scaleName,
    "ReqQty": reqQty,
    "appqty": appqty,
    "remarks": remarks,
    "ApproveType": approveType,
  };
}
