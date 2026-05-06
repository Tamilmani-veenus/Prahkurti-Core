// To parse this JSON data, do
//
//     final onItemSelectAttendanceList = onItemSelectAttendanceListFromJson(jsonString);

import 'dart:convert';

OnItemSelectAttendanceList onItemSelectAttendanceListFromJson(String str) => OnItemSelectAttendanceList.fromJson(json.decode(str));

String onItemSelectAttendanceListToJson(OnItemSelectAttendanceList data) => json.encode(data.toJson());

class OnItemSelectAttendanceList {
  bool? success;
  List<Result>? result;
  String? message;

  OnItemSelectAttendanceList({
    this.success,
    this.result,
    this.message,
  });

  factory OnItemSelectAttendanceList.fromJson(Map<String, dynamic> json) => OnItemSelectAttendanceList(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? subContLabourMasId;
  int? labourCategoryId;
  String? categoryName;
  double? Wages;
  double? extra;
  double? nos;
  double? morotHrs;
  double? morotAmt;
  double? eveotHrs;
  double? eveotAmt;
  double? extraAmt;
  int? siteId;
  String? siteName;
  String? remarks;
  double? totalAmount;

  Result({
    this.subContLabourMasId,
    this.labourCategoryId,
    this.categoryName,
    this.Wages,
    this.extra,
    this.nos,
    this.morotHrs,
    this.morotAmt,
    this.eveotHrs,
    this.eveotAmt,
    this.extraAmt,
    this.siteId,
    this.siteName,
    this.remarks,
    this.totalAmount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    subContLabourMasId: json["SubContLabourMasId"],
    labourCategoryId: json["LabourCategoryId"],
    categoryName: json["CategoryName"],
    Wages: json["Rate"],
    extra: json["Extra"],
    nos: json["Nos"],
    morotHrs: json["MOROTHrs"],
    morotAmt: json["MOROTAmt"].toDouble(),
    eveotHrs: json["EVEOTHrs"],
    eveotAmt: json["EVEOTAmt"].toDouble(),
    extraAmt: json["ExtraAmt"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    remarks: json["Remarks"],
    totalAmount: json["TotalAmount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "SubContLabourMasId": subContLabourMasId,
    "LabourCategoryId": labourCategoryId,
    "CategoryName": categoryName,
    "Rate": Wages,
    "Extra": extra,
    "Nos": nos,
    "MOROTHrs": morotHrs,
    "MOROTAmt": morotAmt,
    "EVEOTHrs": eveotHrs,
    "EVEOTAmt": eveotAmt,
    "ExtraAmt": extraAmt,
    "SiteId": siteId,
    "SiteName": siteName,
    "Remarks": remarks,
    "TotalAmount": totalAmount,
  };
}
