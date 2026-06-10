import 'dart:convert';

// To parse this JSON data, do
//
//     final nmrApprovedStatus = nmrApprovedStatusFromJson(jsonString);

import 'dart:convert';

NmrApprovedStatus nmrApprovedStatusFromJson(String str) => NmrApprovedStatus.fromJson(json.decode(str));

String nmrApprovedStatusToJson(NmrApprovedStatus data) => json.encode(data.toJson());

class NmrApprovedStatus {
  bool? success;
  String? message;
  List<DetailsResult>? result;

  NmrApprovedStatus({
    this.success,
    this.message,
    this.result,
  });

  factory NmrApprovedStatus.fromJson(Map<String, dynamic> json) => NmrApprovedStatus(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<DetailsResult>.from(json["result"].map((x) => DetailsResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class DetailsResult {
  String? labourAttendanceDate;
  String? labourAttendanceNo;
  String? approveStatus;

  DetailsResult({
    this.labourAttendanceDate,
    this.labourAttendanceNo,
    this.approveStatus,
  });

  factory DetailsResult.fromJson(Map<String, dynamic> json) => DetailsResult(
    labourAttendanceDate: json["LabourAttendanceDate"],
    labourAttendanceNo: json["LabourAttendanceNo"],
    approveStatus: json["ApproveStatus"],
  );

  Map<String, dynamic> toJson() => {
    "LabourAttendanceDate": labourAttendanceDate,
    "LabourAttendanceNo": labourAttendanceNo,
    "ApproveStatus": approveStatus,
  };
}


NmrCountList nmrCountListFromJson(String str) => NmrCountList.fromJson(json.decode(str));

String nmrCountListToJson(NmrCountList data) => json.encode(data.toJson());

class NmrCountList {
  bool? success;
  String? message;
  List<Result>? result;

  NmrCountList({
    this.success,
    this.message,
    this.result,
  });

  factory NmrCountList.fromJson(Map<String, dynamic> json) => NmrCountList(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? reccount;
  int? appCount;

  Result({
    this.reccount,
    this.appCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    reccount: json["Reccount"],
    appCount: json["AppCount"],
  );

  Map<String, dynamic> toJson() => {
    "Reccount": reccount,
    "AppCount": appCount,
  };
}



