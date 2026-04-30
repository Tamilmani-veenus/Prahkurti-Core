// To parse this JSON data, do
//
//     final getPendingListResponse = getPendingListResponseFromJson(jsonString);

import 'dart:convert';

GetPendingListResponse getPendingListResponseFromJson(String str) => GetPendingListResponse.fromJson(json.decode(str));

String getPendingListResponseToJson(GetPendingListResponse data) => json.encode(data.toJson());

class GetPendingListResponse {
  bool? success;
  String? message;
  List<PendingListResult>? result;

  GetPendingListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory GetPendingListResponse.fromJson(Map<String, dynamic> json) => GetPendingListResponse(
    success: json["success"],
    message: json["message"],
    result: List<PendingListResult>.from(json["result"].map((x) => PendingListResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class PendingListResult {
  int? menuId;
  int? sqno;
  String? entrytype;
  String? approvalCode;
  int? count;
  String? mobilemenuname;

  PendingListResult({
    this.menuId,
    this.sqno,
    this.entrytype,
    this.approvalCode,
    this.count,
    this.mobilemenuname
  });

  factory PendingListResult.fromJson(Map<String, dynamic> json) => PendingListResult(
    menuId: json["MenuId"],
    sqno: json["SQNO"],
    entrytype: json["ENTRYTYPE"],
    approvalCode: json["APPROVAL_CODE"],
    count: json["COUNT"],
    mobilemenuname: json["MobileMenuName"]
  );

  Map<String, dynamic> toJson() => {
    "MenuId": menuId,
    "SQNO": sqno,
    "ENTRYTYPE": entrytype,
    "APPROVAL_CODE": approvalCode,
    "COUNT": count,
    "MobileMenuName": mobilemenuname
  };
}
