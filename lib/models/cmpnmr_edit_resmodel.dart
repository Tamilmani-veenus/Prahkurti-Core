// To parse this JSON data, do
//
//     final cmpNmrEditResModel = cmpNmrEditResModelFromJson(jsonString);

import 'dart:convert';

CmpNmrEditResModel cmpNmrEditResModelFromJson(String str) => CmpNmrEditResModel.fromJson(json.decode(str));

String cmpNmrEditResModelToJson(CmpNmrEditResModel data) => json.encode(data.toJson());

class CmpNmrEditResModel {
  bool? success;
  String? message;
  Result? result;

  CmpNmrEditResModel({
    this.success,
    this.message,
    this.result,
  });

  factory CmpNmrEditResModel.fromJson(Map<String, dynamic> json) => CmpNmrEditResModel(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?null:result!.toJson(),
  };
}

class Result {
  int? id;
  String? nmrLabourAttendanceNo;
  String? nmrLabourAttendanceDate;
  int? projectId;
  int? siteId;
  int? subContractorId;
  String? billStatus;
  String? workType;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? projectName;
  String? siteName;
  String? subContractorName;
  String? employeeName;
  String? approveByName;
  List<NmrLbrDet>? nmrLbrattendDetLink;

  Result({
    this.id,
    this.nmrLabourAttendanceNo,
    this.nmrLabourAttendanceDate,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.billStatus,
    this.workType,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.projectName,
    this.siteName,
    this.subContractorName,
    this.employeeName,
    this.approveByName,
    this.nmrLbrattendDetLink,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    nmrLabourAttendanceNo: json["nmrLabourAttendanceNo"],
    nmrLabourAttendanceDate: json["nmrLabourAttendanceDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    billStatus: json["billStatus"],
    workType: json["workType"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt:json["createdDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractorName: json["subContractorName"],
    employeeName: json["employeeName"],
    approveByName: json["approveByName"],
    nmrLbrattendDetLink: List<NmrLbrDet>.from(json["nmrLbrattendDetLink"].map((x) => NmrLbrDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nmrLabourAttendanceNo": nmrLabourAttendanceNo,
    "nmrLabourAttendanceDate": nmrLabourAttendanceDate,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "billStatus": billStatus,
    "workType": workType,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "projectName": projectName,
    "siteName": siteName,
    "subContractorName": subContractorName,
    "employeeName": employeeName,
    "approveByName": approveByName,
    "nmrLbrattendDetLink": List<dynamic>.from(nmrLbrattendDetLink!.map((x) => x.toJson())),
  };
}

class NmrLbrDet {
  int? id;
  int? nmrLabourAttendanceMasId;
  int? nmrLabourInfoId;
  int? siteId;
  String? status;
  double? wages;
  double? otHrs;
  double? advance;
  String? remarks;
  double? busFare;
  String? shift;
  double? otAmount;
  int? nmrLabourCategoryId;
  String? labourName;
  String? statusDesc;
  String? labourCategoryName;

  NmrLbrDet({
    this.id,
    this.nmrLabourAttendanceMasId,
    this.nmrLabourInfoId,
    this.siteId,
    this.status,
    this.wages,
    this.otHrs,
    this.advance,
    this.remarks,
    this.busFare,
    this.shift,
    this.otAmount,
    this.nmrLabourCategoryId,
    this.labourName,
    this.statusDesc,
    this.labourCategoryName,
  });

  factory NmrLbrDet.fromJson(Map<String, dynamic> json) => NmrLbrDet(
    id: json["id"],
    nmrLabourAttendanceMasId: json["nmrLabourAttendanceMasId"],
    nmrLabourInfoId: json["nmrLabourInfoId"],
    siteId: json["siteId"],
    status: json["status"],
    wages: json["wages"],
    otHrs: json["otHrs"],
    advance: json["advance"],
    remarks: json["remarks"],
    busFare: json["busFare"],
    shift: json["shift"],
    otAmount: json["otAmount"],
    nmrLabourCategoryId: json["nmrLabourCategoryId"],
    labourName: json["labourName"],
    statusDesc: json["statusDesc"],
    labourCategoryName: json["labourCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nmrLabourAttendanceMasId": nmrLabourAttendanceMasId,
    "nmrLabourInfoId": nmrLabourInfoId,
    "siteId": siteId,
    "status": status,
    "wages": wages,
    "otHrs": otHrs,
    "advance": advance,
    "remarks": remarks,
    "busFare": busFare,
    "shift": shift,
    "otAmount": otAmount,
    "nmrLabourCategoryId": nmrLabourCategoryId,
    "labourName": labourName,
    "labourCategoryName": labourCategoryName,
    "statusDesc": statusDesc,
  };
}
