// To parse this JSON data, do
//
//     final manPowerEditModel = manPowerEditModelFromJson(jsonString);

import 'dart:convert';

ManPowerEditModel manPowerEditModelFromJson(String str) => ManPowerEditModel.fromJson(json.decode(str));

String manPowerEditModelToJson(ManPowerEditModel data) => json.encode(data.toJson());

class ManPowerEditModel {
  bool? success;
  String? message;
  ManPowerEditResult? result;

  ManPowerEditModel({
    this.success,
    this.message,
    this.result,
  });

  factory ManPowerEditModel.fromJson(Map<String, dynamic> json) => ManPowerEditModel(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:ManPowerEditResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?null:result!.toJson(),
    "message": message,
  };
}

class ManPowerEditResult {
  int id;
  String manPowerNo;
  String entryDate;
  int projectId;
  int siteId;
  int headItemId;
  String remarks;
  int createdBy;
  String projectName;
  String siteName;
  String createdByName;
  String approvedByName;
  String materialHeadName;
  String status;
  List<ManPowerEditDet> manPowerDets;

  ManPowerEditResult({
    required this.id,
    required this.manPowerNo,
    required this.entryDate,
    required this.projectId,
    required this.siteId,
    required this.headItemId,
    required this.remarks,
    required this.createdBy,
    required this.projectName,
    required this.siteName,
    required this.createdByName,
    required this.approvedByName,
    required this.materialHeadName,
    required this.status,
    required this.manPowerDets,
  });

  factory ManPowerEditResult.fromJson(Map<String, dynamic> json) => ManPowerEditResult(
    id: json["id"],
    manPowerNo: json["manPowerNo"],
    entryDate: json["entryDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    headItemId: json["headItemId"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    createdByName: json["createdByName"],
    approvedByName: json["approvedByName"],
    materialHeadName: json["materialHeadName"],
    status: json["status"],
    manPowerDets: List<ManPowerEditDet>.from(json["manPowerDets"].map((x) => ManPowerEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manPowerNo": manPowerNo,
    "entryDate": entryDate,
    "projectId": projectId,
    "siteId": siteId,
    "headItemId": headItemId,
    "remarks": remarks,
    "createdBy": createdBy,
    "projectName": projectName,
    "siteName": siteName,
    "createdByName": createdByName,
    "approvedByName": approvedByName,
    "materialHeadName": materialHeadName,
    "status": status,
    "manPowerDets": List<dynamic>.from(manPowerDets.map((x) => x.toJson())),
  };
}

class ManPowerEditDet {
  int id;
  int manPowerAllocationMasId;
  int categoryId;
  String level3ItemId;
  int nos;
  String remarks;
  String categoryName;

  ManPowerEditDet({
    required this.id,
    required this.manPowerAllocationMasId,
    required this.categoryId,
    required this.level3ItemId,
    required this.nos,
    required this.remarks,
    required this.categoryName,
  });

  factory ManPowerEditDet.fromJson(Map<String, dynamic> json) => ManPowerEditDet(
    id: json["id"],
    manPowerAllocationMasId: json["manPowerAllocationMasId"],
    categoryId: json["categoryId"],
    level3ItemId: json["level3ItemId"],
    nos: json["nos"],
    remarks: json["remarks"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manPowerAllocationMasId": manPowerAllocationMasId,
    "categoryId": categoryId,
    "level3ItemId": level3ItemId,
    "nos": nos,
    "remarks": remarks,
    "categoryName": categoryName,
  };
}



