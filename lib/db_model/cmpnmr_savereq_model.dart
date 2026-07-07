// To parse this JSON data, do
//
//     final cmpNmrSaveReqModel = cmpNmrSaveReqModelFromJson(jsonString);

import 'dart:convert';

CmpNmrSaveReqModel cmpNmrSaveReqModelFromJson(String str) => CmpNmrSaveReqModel.fromJson(json.decode(str));

String cmpNmrSaveReqModelToJson(CmpNmrSaveReqModel data) => json.encode(data.toJson());

class CmpNmrSaveReqModel {
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
  String? approveStatus;
  int? approvedBy;
  String? approveDt;
  List<NmrLbrattendDetLink>? nmrLbrattendDetLink;

  CmpNmrSaveReqModel({
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
    this.approveStatus,
    this.approvedBy,
    this.approveDt,
    this.nmrLbrattendDetLink,
  });

  factory CmpNmrSaveReqModel.fromJson(Map<String, dynamic> json) => CmpNmrSaveReqModel(
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
    createdDt: json["createdDt"],
    approveStatus: json["approveStatus"],
    approvedBy: json["approvedBy"],
    approveDt: json["approveDt"],
    nmrLbrattendDetLink: List<NmrLbrattendDetLink>.from(json["nmrLbrattendDetLink"].map((x) => NmrLbrattendDetLink.fromJson(x))),
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
    "approveStatus": approveStatus,
    "approvedBy": approvedBy,
    "approveDt": approveDt,
    "nmrLbrattendDetLink": List<dynamic>.from(nmrLbrattendDetLink!.map((x) => x.toJson())),
  };
}

class NmrLbrattendDetLink {
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

  NmrLbrattendDetLink({
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
  });

  factory NmrLbrattendDetLink.fromJson(Map<String, dynamic> json) => NmrLbrattendDetLink(
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
  };
}
