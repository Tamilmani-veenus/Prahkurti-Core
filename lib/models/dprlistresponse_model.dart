// To parse this JSON data, do
//
//     final dprListResponse = dprListResponseFromJson(jsonString);

import 'dart:convert';

DprListResponse dprListResponseFromJson(String str) => DprListResponse.fromJson(json.decode(str));

String dprListResponseToJson(DprListResponse data) => json.encode(data.toJson());

class DprListResponse {
  bool? success;
  List<Result>? result;

  DprListResponse({
    this.success,
    this.result,
  });

  factory DprListResponse.fromJson(Map<String, dynamic> json) => DprListResponse(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? workNo;
  String? workDate;
  int? subContractorId;
  int? siteid;
  int? projectid;
  String? projectName;
  String? siteName;
  String? subcontractName;
  String? appStatus;

  Result({
    this.id,
    this.workNo,
    this.workDate,
    this.subContractorId,
    this.siteid,
    this.projectid,
    this.projectName,
    this.siteName,
    this.subcontractName,
    this.appStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    subContractorId: json["SubContractorId"],
    siteid: json["Siteid"],
    projectid: json["projectid"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subcontractName: json["SubcontractName"],
    appStatus: json["AppStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "SubContractorId": subContractorId,
    "Siteid": siteid,
    "projectid": projectid,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SubcontractName": subcontractName,
    "AppStatus": appStatus,
  };
}
