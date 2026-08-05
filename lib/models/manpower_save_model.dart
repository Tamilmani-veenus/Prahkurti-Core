// To parse this JSON data, do
//
//     final manPowerSaveModel = manPowerSaveModelFromJson(jsonString);

import 'dart:convert';

ManPowerSaveModel manPowerSaveModelFromJson(String str) => ManPowerSaveModel.fromJson(json.decode(str));

String manPowerSaveModelToJson(ManPowerSaveModel data) => json.encode(data.toJson());

class ManPowerSaveModel {
  int? id;
  String? manPowerNo;
  String? entryDate;
  int? projectId;
  int? siteId;
  int? headItemId;
  String? remarks;
  // int? approvedBy;
  String? approveStatus;
  int? createdBy;
  List<ManPowerDet>? manPowerDets;

  ManPowerSaveModel({
    this.id,
    this.manPowerNo,
    this.entryDate,
    this.projectId,
    this.siteId,
    this.headItemId,
    this.remarks,
    // this.approvedBy,
    this.approveStatus,
    this.createdBy,
    this.manPowerDets,
  });

  factory ManPowerSaveModel.fromJson(Map<String, dynamic> json) => ManPowerSaveModel(
    id: json["id"],
    manPowerNo: json["manPowerNo"],
    entryDate:json["entryDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    headItemId: json["headItemId"],
    remarks: json["remarks"],
    // approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    createdBy: json["createdBy"],
    manPowerDets: List<ManPowerDet>.from(json["manPowerDets"].map((x) => ManPowerDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manPowerNo": manPowerNo,
    "entryDate": entryDate,
    "projectId": projectId,
    "siteId": siteId,
    "headItemId": headItemId,
    "remarks": remarks,
    // "approvedBy": approvedBy,
    "createdBy": createdBy,
    "approveStatus": approveStatus,
    "manPowerDets": List<dynamic>.from(manPowerDets!.map((x) => x.toJson())),
  };
}

class ManPowerDet {
  int? id;
  int? manPowerAllocationMasId;
  int? categoryId;
  String? level3ItemId;
  int? nos;
  int? appNos;
  String? remarks;

  ManPowerDet({
    this.id,
    this.manPowerAllocationMasId,
    this.categoryId,
    this.level3ItemId,
    this.nos,
    this.appNos,
    this.remarks,
  });

  factory ManPowerDet.fromJson(Map<String, dynamic> json) => ManPowerDet(
    id: json["id"],
    manPowerAllocationMasId: json["manPowerAllocationMasId"],
    categoryId: json["categoryId"],
    level3ItemId: json["level3ItemId"],
    nos: json["nos"],
    appNos: json["appNos"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manPowerAllocationMasId": manPowerAllocationMasId,
    "categoryId": categoryId,
    "level3ItemId": level3ItemId,
    "nos": nos,
    "appNos": appNos,
    "remarks": remarks,
  };
}
