

import 'dart:convert';

List<InwardReportListResponse> inwardReportListResponseFromJson(String str) => List<InwardReportListResponse>.from(json.decode(str).map((x) => InwardReportListResponse.fromJson(x)));

String inwardReportListResponseToJson(List<InwardReportListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InwardReportListResponse {
  InwardReportListResponse({
    this.inwardId,
    this.inwardNo,
    this.inwardDate,
    this.projectName,
    this.siteName,
    this.supplierName,
    this.invNo,
    this.poNo,
  });

  int? inwardId;
  String? inwardNo;
  String? inwardDate;
  String? projectName;
  String? siteName;
  String? supplierName;
  String? invNo;
  String? poNo;

  factory InwardReportListResponse.fromJson(Map<String, dynamic> json) => InwardReportListResponse(
    inwardId: json["InwardId"],
    inwardNo: json["InwardNo"],
    inwardDate: json["InwardDate"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    supplierName: json["SupplierName"],
    invNo: json["InvNo"],
    poNo: json["PONo"],
  );

  Map<String, dynamic> toJson() => {
    "InwardId": inwardId,
    "InwardNo": inwardNo,
    "InwardDate": inwardDate,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SupplierName": supplierName,
    "InvNo": invNo,
    "PONo": poNo,
  };
}
