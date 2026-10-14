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
  String? reqDate;
  String? dueDate;
  int? projectId;
  int? siteId;
  int? headItemId;
  String? remarks;
  String? level3ItemId;
  // int? approvedBy;
  String? approveStatus;
  String? approveRemarks;
  int? createdBy;
  List<ManPowerDet>? manPowerDets;

  ManPowerSaveModel({
    this.id,
    this.manPowerNo,
    this.entryDate,
    this.reqDate,
    this.dueDate,
    this.projectId,
    this.siteId,
    this.headItemId,
    this.remarks,
    this.level3ItemId,
    // this.approvedBy,
    this.approveStatus,
    this.approveRemarks,
    this.createdBy,
    this.manPowerDets,
  });

  factory ManPowerSaveModel.fromJson(Map<String, dynamic> json) => ManPowerSaveModel(
    id: json["id"],
    manPowerNo: json["manPowerNo"],
    entryDate:json["entryDate"],
    reqDate:json["reqDate"],
    dueDate:json["dueDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    headItemId: json["headItemId"],
    remarks: json["remarks"],
    level3ItemId: json["level3ItemId"],
    // approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveRemarks: json["approveRemarks"],
    createdBy: json["createdBy"],
    manPowerDets: List<ManPowerDet>.from(json["manPowerReqDets"].map((x) => ManPowerDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manPowerNo": manPowerNo,
    "entryDate": entryDate,
    "reqDate": reqDate,
    "dueDate": dueDate,
    "projectId": projectId,
    "siteId": siteId,
    "headItemId": headItemId,
    "remarks": remarks,
    "level3ItemId": level3ItemId,
    // "approvedBy": approvedBy,
    "createdBy": createdBy,
    "approveRemarks": approveRemarks,
    "approveStatus": approveStatus,
    "manPowerReqDets": List<dynamic>.from(manPowerDets!.map((x) => x.toJson())),
  };
}

class ManPowerDet {
  int? id;
  int? manPowerAllocationMasId;
  int? categoryId;
  // String? level3ItemId;
  int? nos;
  int? appNos;
  // String? remarks;

  ManPowerDet({
    this.id,
    this.manPowerAllocationMasId,
    this.categoryId,
    // this.level3ItemId,
    this.nos,
    this.appNos,
    // this.remarks,
  });

  factory ManPowerDet.fromJson(Map<String, dynamic> json) => ManPowerDet(
    id: json["id"],
    manPowerAllocationMasId: json["manPowerAllocationMasId"],
    categoryId: json["categoryId"],
    // level3ItemId: json["level3ItemId"],
    nos: json["nos"],
    appNos: json["appNos"],
    // remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manPowerAllocationMasId": manPowerAllocationMasId,
    "categoryId": categoryId,
    // "level3ItemId": level3ItemId,
    "nos": nos,
    "appNos": appNos,
    // "remarks": remarks,
  };
}
