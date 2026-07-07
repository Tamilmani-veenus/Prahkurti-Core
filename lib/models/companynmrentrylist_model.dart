// To parse this JSON data, do
//
//     final companyNmrEntryListmodel = companyNmrEntryListmodelFromJson(jsonString);

import 'dart:convert';

CompanyNmrEntryListmodel companyNmrEntryListmodelFromJson(String str) => CompanyNmrEntryListmodel.fromJson(json.decode(str));

String companyNmrEntryListmodelToJson(CompanyNmrEntryListmodel data) => json.encode(data.toJson());

class CompanyNmrEntryListmodel {
  bool? success;
  String? message;
  List<Result>? result;

  CompanyNmrEntryListmodel({
    this.success,
    this.message,
    this.result,
  });

  factory CompanyNmrEntryListmodel.fromJson(Map<String, dynamic> json) => CompanyNmrEntryListmodel(
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
  String? labourAttendanceNo;
  String? labourAttendanceDate;
  String? projectName;
  String? siteName;
  String? subContractorName;
  String? workType;
  String? workTypName;
  int? createdBy;
  String? employeeName;
  int? labourCount;
  String? approveStatus;
  String? billStatus;
  String? billStatusDesc;
  String? appType;

  Result({
    this.id,
    this.labourAttendanceNo,
    this.labourAttendanceDate,
    this.projectName,
    this.siteName,
    this.subContractorName,
    this.workType,
    this.workTypName,
    this.createdBy,
    this.employeeName,
    this.labourCount,
    this.approveStatus,
    this.billStatus,
    this.billStatusDesc,
    this.appType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    labourAttendanceNo: json["labourAttendanceNo"],
    labourAttendanceDate: json["labourAttendanceDate"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractorName: json["subContractorName"],
    workType: json["workType"],
    workTypName: json["workTypName"],
    createdBy: json["createdBy"],
    employeeName: json["employeeName"],
    labourCount: json["labourCount"],
    approveStatus: json["approveStatus"],
    billStatus: json["billStatus"],
    billStatusDesc: json["billStatusDesc"],
    appType: json["appType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "labourAttendanceNo": labourAttendanceNo,
    "labourAttendanceDate": labourAttendanceDate,
    "projectName": projectName,
    "siteName": siteName,
    "subContractorName": subContractorName,
    "workType": workType,
    "workTypName": workTypName,
    "createdBy": createdBy,
    "employeeName": employeeName,
    "labourCount": labourCount,
    "approveStatus": approveStatus,
    "billStatus": billStatus,
    "billStatusDesc": billStatusDesc,
    "appType": appType,
  };
}
