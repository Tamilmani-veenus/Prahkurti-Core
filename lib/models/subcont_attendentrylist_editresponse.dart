// To parse this JSON data, do
//
//     final subContAttendEntryListEditRes = subContAttendEntryListEditResFromJson(jsonString);

import 'dart:convert';

SubContAttendEntryListEditRes subContAttendEntryListEditResFromJson(String str) => SubContAttendEntryListEditRes.fromJson(json.decode(str));

String subContAttendEntryListEditResToJson(SubContAttendEntryListEditRes data) => json.encode(data.toJson());

class SubContAttendEntryListEditRes {
  bool? success;
  Result? result;
  String? message;

  SubContAttendEntryListEditRes({
    this.success,
    this.result,
    this.message,
  });

  factory SubContAttendEntryListEditRes.fromJson(Map<String, dynamic> json) => SubContAttendEntryListEditRes(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
  };
}

class Result {
  int? id;
  String? labourAttendanceNo;
  String? labourAttendanceDate;
  double? totNos;
  double? totAmt;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? workType;
  int? labourType;
  int? projectId;
  int? companyId;
  String? approveStatus;
  dynamic approvedDt;
  String? billStatus;
  int? approvedBy;
  String? workShift;
  int? subcontractorId;
  int? siteId;
  String? imageUpload;
  String? projectName;
  String? subContractorName;
  String? siteName;
  String? employeeName;
  String? approveByName;
  List<SubContLabourAttendDet>? subContLabourAttendDetS;

  Result({
    this.id,
    this.labourAttendanceNo,
    this.labourAttendanceDate,
    this.totNos,
    this.totAmt,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.workType,
    this.labourType,
    this.projectId,
    this.companyId,
    this.approveStatus,
    this.approvedDt,
    this.billStatus,
    this.approvedBy,
    this.workShift,
    this.subcontractorId,
    this.siteId,
    this.imageUpload,
    this.projectName,
    this.subContractorName,
    this.siteName,
    this.employeeName,
    this.approveByName,
    this.subContLabourAttendDetS,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    labourAttendanceNo: json["labourAttendanceNo"],
    labourAttendanceDate: json["labourAttendanceDate"],
    totNos: json["totNos"],
    totAmt: json["totAmt"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    workType: json["workType"],
    labourType: json["labourType"],
    projectId: json["projectId"],
    companyId: json["companyId"],
    approveStatus: json["approveStatus"],
    approvedDt: json["approvedDt"],
    billStatus: json["billStatus"],
    approvedBy: json["approvedBy"],
    workShift: json["workShift"],
    subcontractorId: json["subcontractorId"],
    siteId: json["siteId"],
    imageUpload: json["imageUpload"],
    projectName: json["projectName"],
    subContractorName: json["subContractorName"],
    siteName: json["siteName"],
    employeeName: json["employeeName"],
    approveByName: json["approveByName"],
    subContLabourAttendDetS: List<SubContLabourAttendDet>.from(json["subContLabourAttendDetS"].map((x) => SubContLabourAttendDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "labourAttendanceNo": labourAttendanceNo,
    "labourAttendanceDate":labourAttendanceDate,
    "totNos": totNos,
    "totAmt": totAmt,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "workType": workType,
    "labourType": labourType,
    "projectId": projectId,
    "companyId": companyId,
    "approveStatus": approveStatus,
    "approvedDt": approvedDt,
    "billStatus": billStatus,
    "approvedBy": approvedBy,
    "workShift": workShift,
    "subcontractorId": subcontractorId,
    "siteId": siteId,
    "imageUpload": imageUpload,
    "projectName": projectName,
    "subContractorName": subContractorName,
    "siteName": siteName,
    "employeeName": employeeName,
    "approveByName": approveByName,
    "subContLabourAttendDetS": List<dynamic>.from(subContLabourAttendDetS!.map((x) => x.toJson())),
  };
}

class SubContLabourAttendDet {
  int? id;
  int? subContLabourMasId;
  int? siteId;
  String? siteName;
  int? labourId;
  int? labourCategoryId;
  double? nos;
  double? rate;
  double? otNos;
  double? otHrs;
  double? totalAmount;
  String? remarks;
  double? extra;
  String? shift;
  String? billStatus;
  double? morotHrs;
  double? morotAmt;
  double? eveotHrs;
  double? eveotAmt;
  double? extraAmt;
  String? subContractorname;
  String? labourCategoryName;

  SubContLabourAttendDet({
    this.id,
    this.subContLabourMasId,
    this.siteId,
    this.siteName,
    this.labourId,
    this.labourCategoryId,
    this.nos,
    this.rate,
    this.otNos,
    this.otHrs,
    this.totalAmount,
    this.remarks,
    this.extra,
    this.shift,
    this.billStatus,
    this.morotHrs,
    this.morotAmt,
    this.eveotHrs,
    this.eveotAmt,
    this.extraAmt,
    this.subContractorname,
    this.labourCategoryName,
  });

  factory SubContLabourAttendDet.fromJson(Map<String, dynamic> json) => SubContLabourAttendDet(
    id: json["id"],
    subContLabourMasId: json["subContLabourMasId"],
    siteId: json["siteId"],
    siteName: json["siteName"],
    labourId: json["labourId"],
    labourCategoryId: json["labourCategoryId"],
    nos: json["nos"],
    rate: json["rate"],
    otNos: json["otNos"],
    otHrs: json["otHrs"],
    totalAmount: json["totalAmount"],
    remarks: json["remarks"],
    extra: json["extra"],
    shift: json["shift"],
    billStatus: json["billStatus"],
    morotHrs: json["morotHrs"],
    morotAmt: json["morotAmt"],
    eveotHrs: json["eveotHrs"],
    eveotAmt: json["eveotAmt"],
    extraAmt: json["extraAmt"],
    subContractorname: json["subContractorname"],
    labourCategoryName: json["labourCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContLabourMasId": subContLabourMasId,
    "siteId": siteId,
    "siteName": siteName,
    "labourId": labourId,
    "labourCategoryId": labourCategoryId,
    "nos": nos,
    "rate": rate,
    "otNos": otNos,
    "otHrs": otHrs,
    "totalAmount": totalAmount,
    "remarks": remarks,
    "extra": extra,
    "shift": shift,
    "billStatus": billStatus,
    "morotHrs": morotHrs,
    "morotAmt": morotAmt,
    "eveotHrs": eveotHrs,
    "eveotAmt": eveotAmt,
    "extraAmt": extraAmt,
    "subContractorname": subContractorname,
    "labourCategoryName": labourCategoryName,
  };
}
