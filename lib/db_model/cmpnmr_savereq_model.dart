import 'dart:convert';

CmpNmrSaveReqModel? cmpNmrSaveReqModelFromJson(String str) => CmpNmrSaveReqModel.fromJson(json.decode(str));

String cmpNmrSaveReqModelToJson(CmpNmrSaveReqModel? data) => json.encode(data!.toJson());

class CmpNmrSaveReqModel {
  CmpNmrSaveReqModel({
    this.attenId,
    this.attenNo,
    this.attenDate,
    this.projectId,
    this.siteId,
    this.remarks,
    this.preparedby,
    this.approvedby,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.attendanceDet,
  });

  String? attenId;
  String? attenNo;
  String? attenDate;
  String? projectId;
  String? siteId;
  String? remarks;
  String? preparedby;
  String? approvedby;
  String? userId;
  String? entryMode;
  String? deviceName;
  List<AttendanceDet>? attendanceDet;

  factory CmpNmrSaveReqModel.fromJson(Map<String, dynamic> json) => CmpNmrSaveReqModel(
    attenId: json["AttenId"],
    attenNo: json["AttenNo"],
    attenDate: json["AttenDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    approvedby: json["Approvedby"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    attendanceDet: json["AttendanceDet"] == null ? [] : List<AttendanceDet>.from(json["AttendanceDet"]!.map((x) => AttendanceDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AttenId": attenId,
    "AttenNo": attenNo,
    "AttenDate": attenDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "Approvedby": approvedby,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "AttendanceDet": attendanceDet == null ? [] : List<dynamic>.from(attendanceDet!.map((x) => x.toJson())),
  };
}

class AttendanceDet {
  AttendanceDet({
    this.nmrLbrId,
    this.nmrLbrName,
    this.shift,
    this.status,
    this.wages,
    this.otHrs,
    this.busfare,
    this.Advance,
    this.detRemarks,
  });

  String? nmrLbrId;
  String? nmrLbrName;
  String? shift;
  String? status;
  String? wages;
  String? otHrs;
  String? busfare;
  String? Advance;
  String? detRemarks;

  factory AttendanceDet.fromJson(Map<String, dynamic> json) => AttendanceDet(
    nmrLbrId: json["NMRLbrId"],
    nmrLbrName: json["NMRLbrName"],
    shift: json["Shift"],
    status: json["Status"],
    wages: json["Wages"],
    otHrs: json["OTHrs"],
    busfare: json["Busfare"],
    Advance: json["Advance"],
    detRemarks: json["DetRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "NMRLbrId": nmrLbrId,
    "NMRLbrName": nmrLbrName,
    "Shift": shift,
    "Status": status,
    "Wages": wages,
    "OTHrs": otHrs,
    "Busfare": busfare,
    "Advance": Advance,
    "DetRemarks": detRemarks,
  };
}
