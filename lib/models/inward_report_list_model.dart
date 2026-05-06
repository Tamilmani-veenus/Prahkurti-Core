// To parse this JSON data, do
//
//     final inwardReportListResponse = inwardReportListResponseFromJson(jsonString);

import 'dart:convert';

InwardReportListResponse inwardReportListResponseFromJson(String str) => InwardReportListResponse.fromJson(json.decode(str));

String inwardReportListResponseToJson(InwardReportListResponse data) => json.encode(data.toJson());

class InwardReportListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  InwardReportListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory InwardReportListResponse.fromJson(Map<String, dynamic> json) => InwardReportListResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null? null :List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? inwardNo;
  String? entryDate;
  int? projectId;
  String? projectName;
  int? siteId;
  String? siteName;
  int? supplier;
  String? supplierName;
  String? purchaseType;
  String? remarks;

  Result({
    this.id,
    this.inwardNo,
    this.entryDate,
    this.projectId,
    this.projectName,
    this.siteId,
    this.siteName,
    this.supplier,
    this.supplierName,
    this.purchaseType,
    this.remarks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    inwardNo: json["inwardNo"],
    entryDate: json["entryDate"],
    projectId: json["projectID"],
    projectName: json["projectName"],
    siteId: json["siteId"],
    siteName: json["siteName"],
    supplier: json["supplier"],
    supplierName: json["supplierName"],
    purchaseType: json["purchaseType"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inwardNo": inwardNo,
    "entryDate": entryDate,
    "projectID": projectId,
    "projectName": projectName,
    "siteId": siteId,
    "siteName": siteName,
    "supplier": supplier,
    "supplierName": supplierName,
    "purchaseType": purchaseType,
    "remarks": remarks,
  };
}

