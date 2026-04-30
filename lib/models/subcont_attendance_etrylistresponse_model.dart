// // To parse this JSON data, do
// //
// //     final attendanceEntrylist = attendanceEntrylistFromJson(jsonString);
//
// import 'dart:convert';
//
// List<SubContAttendanceEntrylistRes> subContattendanceEntrylistFromJson(String str) => List<SubContAttendanceEntrylistRes>.from(json.decode(str).map((x) => SubContAttendanceEntrylistRes.fromJson(x)));
//
// String subContattendanceEntrylistToJson(List<SubContAttendanceEntrylistRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class SubContAttendanceEntrylistRes {
//   SubContAttendanceEntrylistRes({
//     this.subcontLabrAttnId,
//     this.labrAttnNo,
//     this.labrAttnDate,
//     this.totNos,
//     this.totAmt,
//     this.workType,
//     this.workshift,
//     this.project,
//     this.subcontid,
//     this.subconName,
//     this.siteId,
//     this.siteName,
//     this.appStatus,
//     this.preparedByName,
//   });
//
//   int? subcontLabrAttnId;
//   String? labrAttnNo;
//   String? labrAttnDate;
//   double? totNos;
//   double? totAmt;
//   String? workType;
//   String? workshift;
//   String? project;
//   int? subcontid;
//   int? siteId;
//   String? siteName;
//   String? subconName;
//   String? appStatus;
//   String? preparedByName;
//
//   factory SubContAttendanceEntrylistRes.fromJson(Map<String, dynamic> json) => SubContAttendanceEntrylistRes(
//     subcontLabrAttnId: json["Subcont_LabrAttn_Id"],
//     labrAttnNo: json["LabrAttn_No"],
//     labrAttnDate: json["LabrAttn_Date"],
//     totNos: json["TotNos"].toDouble(),
//     totAmt: json["TotAmt"].toDouble(),
//     workType: json["WorkType"],
//     workshift: json["workshift"],
//     project: json["project"],
//     subcontid: json["subcontid"],
//     subconName: json["Subcon_name"],
//     siteId: json["Siteid"],
//     siteName: json["SiteName"],
//     appStatus: json["App_Status"],
//     preparedByName: json["PreparedByName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Subcont_LabrAttn_Id": subcontLabrAttnId,
//     "LabrAttn_No": labrAttnNo,
//     "LabrAttn_Date": labrAttnDate,
//     "TotNos": totNos,
//     "TotAmt": totAmt,
//     "WorkType":  workType,
//     "workshift":  workshift,
//     "project": project,
//     "subcontid": subcontid,
//     "Subcon_name": subconName,
//     "Siteid": siteId,
//     "SiteName": siteName,
//     "App_Status": appStatus,
//     "PreparedByName": preparedByName,
//   };
// }
//



// To parse this JSON data, do
//
//     final subContAttendanceEntrylistRes = subContAttendanceEntrylistResFromJson(jsonString);

import 'dart:convert';

SubContAttendanceEntrylistRes subContAttendanceEntrylistResFromJson(String str) => SubContAttendanceEntrylistRes.fromJson(json.decode(str));

String subContAttendanceEntrylistResToJson(SubContAttendanceEntrylistRes data) => json.encode(data.toJson());

class SubContAttendanceEntrylistRes {
  bool? success;
  String? message;
  List<Result>? result;

  SubContAttendanceEntrylistRes({
    this.success,
    this.message,
    this.result,
  });

  factory SubContAttendanceEntrylistRes.fromJson(Map<String, dynamic> json) => SubContAttendanceEntrylistRes(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? labourAttendanceNo;
  String? labourAttendanceDate;
  String? workType;
  String? workTypeName;
  String? workShift;
  int? projectId;
  String? projectName;
  int? siteId;
  String? siteName;
  int? subcontractorId;
  String? subContractorName;
  int? createdBy;
  String? employeeName;
  double? totNos;
  double? totAmt;
  String? approveStatus;
  String? appType;

  Result({
    this.id,
    this.labourAttendanceNo,
    this.labourAttendanceDate,
    this.workType,
    this.workTypeName,
    this.workShift,
    this.projectId,
    this.projectName,
    this.siteId,
    this.siteName,
    this.subcontractorId,
    this.subContractorName,
    this.createdBy,
    this.employeeName,
    this.totNos,
    this.totAmt,
    this.approveStatus,
    this.appType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    labourAttendanceNo: json["labourAttendanceNo"],
    labourAttendanceDate: json["labourAttendanceDate"],
    workType: json["workType"],
    workTypeName: json["workTypName"],
    workShift: json["workShift"],
    projectId: json["projectId"],
    projectName: json["projectName"],
    siteId: json["siteId"],
    siteName: json["siteName"],
    subcontractorId: json["subcontractorId"],
    subContractorName: json["subContractorName"],
    createdBy: json["createdBy"],
    employeeName: json["employeeName"],
    totNos: json["totNos"],
    totAmt: json["totAmt"],
    approveStatus: json["approveStatus"],
    appType: json["appType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "labourAttendanceNo": labourAttendanceNo,
    "labourAttendanceDate": labourAttendanceDate,
    "workType": workType,
    "workTypName": workTypeName,
    "workShift": workShift,
    "projectId": projectId,
    "projectName": projectName,
    "siteId": siteId,
    "siteName": siteName,
    "subcontractorId": subcontractorId,
    "subContractorName": subContractorName,
    "createdBy": createdBy,
    "employeeName": employeeName,
    "totNos": totNos,
    "totAmt": totAmt,
    "approveStatus": approveStatus,
    "appType": appType,
  };
}
