// To parse this JSON data, do
//
//     final cmpNMrEditResModel = cmpNMrEditResModelFromJson(jsonString);

import 'dart:convert';

List<CmpNMrEditResModel?>? cmpNMrEditResModelFromJson(String str) => json.decode(str) == null ? [] : List<CmpNMrEditResModel>.from(json.decode(str)!.map((x) => CmpNMrEditResModel.fromJson(x)));

String cmpNMrEditResModelToJson(List<CmpNMrEditResModel>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())));

class CmpNMrEditResModel {
  CmpNMrEditResModel({
    this.attenId,
    this.attenNo,
    this.attenDate,
    this.projectId,
    this.siteId,
    this.companyId,
    this.companyName,
    this.projectName,
    this.siteName,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.userId,
    this.entryMode,
    this.attendanceDet,
  });

  int? attenId;
  String? attenNo;
  String? attenDate;
  int? projectId;
  int? siteId;
  int? companyId;
  String? companyName;
  String? projectName;
  String? siteName;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  int? userId;
  dynamic entryMode;
  List<AttendanceDet>? attendanceDet;

  factory CmpNMrEditResModel.fromJson(Map<String, dynamic> json) => CmpNMrEditResModel(
    attenId: json["AttenId"],
    attenNo: json["AttenNo"],
    attenDate: json["AttenDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    companyId: json["CompanyId"],
    companyName: json["CompanyName"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    attendanceDet: json["AttendanceDet"] == null ? [] : List<AttendanceDet>.from(json["AttendanceDet"]!.map((x) => AttendanceDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AttenId": attenId,
    "AttenNo": attenNo,
    "AttenDate": attenDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "CompanyId": companyId,
    "CompanyName": companyName,
    "ProjectName": projectName,
    "SiteName": siteName,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "AttendanceDet": attendanceDet == null ? [] : List<dynamic>.from(attendanceDet!.map((x) => x.toJson())),
  };
}

class AttendanceDet {
  AttendanceDet({
    this.nmrLbrId,
    this.labourName,
    this.categoryName,
    this.shift,
    this.shiftName,
    this.status,
    this.statusName,
    this.wages,
    this.otHrs,
    this.busfare,
    this.Advance,
    this.detRemarks,
  });

  int? nmrLbrId;
  String? labourName;
  String? categoryName;
  String? shift;
  String? shiftName;
  String? status;
  String? statusName;
  double? wages;
  double? otHrs;
  double? busfare;
  double? Advance;
  String? detRemarks;

  factory AttendanceDet.fromJson(Map<String, dynamic> json) => AttendanceDet(
    nmrLbrId: json["NMRLbrId"],
    labourName: json["LabourName"],
    categoryName: json["CategoryName"],
    shift: json["Shift"],
    shiftName: json["ShiftName"],
    status: json["Status"],
    statusName: json["StatusName"],
    wages: json["Wages"],
    otHrs: json["OTHrs"],
    busfare: json["Busfare"],
    Advance: json["Advance"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "NMRLbrId": nmrLbrId,
    "LabourName": labourName,
    "CategoryName": categoryName,
    "Shift": shift,
    "ShiftName": shiftName,
    "Status": status,
    "StatusName": statusName,
    "Wages": wages,
    "OTHrs": otHrs,
    "Busfare": busfare,
    "Advance": Advance,
    "DetRemarks": detRemarks,
  };
}
