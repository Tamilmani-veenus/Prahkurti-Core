// // To parse this JSON data, do
// //
// //     final getReportListResponse = getReportListResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// List<GetReportListResponse> getReportListResponseFromJson(String str) => List<GetReportListResponse>.from(json.decode(str).map((x) => GetReportListResponse.fromJson(x)));
//
// String getReportListResponseToJson(List<GetReportListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class GetReportListResponse {
//   String headName;
//   List<SubMenuReports> subMenu;
//
//   GetReportListResponse({
//     required this.headName,
//     required this.subMenu,
//   });
//
//   factory GetReportListResponse.fromJson(Map<String, dynamic> json) => GetReportListResponse(
//     headName: json["HeadName"],
//     subMenu: List<SubMenuReports>.from(json["SubMenu"].map((x) => SubMenuReports.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "HeadName": headName,
//     "SubMenu": List<dynamic>.from(subMenu.map((x) => x.toJson())),
//   };
// }
//
// class SubMenuReports {
//   String subName;
//   String reportName;
//
//   SubMenuReports({
//     required this.subName,
//     required this.reportName,
//   });
//
//   factory SubMenuReports.fromJson(Map<String, dynamic> json) => SubMenuReports(
//     subName: json["SubName"],
//     reportName: json["ReportName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SubName": subName,
//     "ReportName": reportName,
//   };
// }



// To parse this JSON data, do
//
//     final getReportListResponse = getReportListResponseFromJson(jsonString);

import 'dart:convert';

GetReportListResponse getReportListResponseFromJson(String str) => GetReportListResponse.fromJson(json.decode(str));

String getReportListResponseToJson(GetReportListResponse data) => json.encode(data.toJson());

class GetReportListResponse {
  bool? success;
  String? message;
  List<ReportResult>? result;

  GetReportListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory GetReportListResponse.fromJson(Map<String, dynamic> json) => GetReportListResponse(
    success: json["success"],
    message: json["message"],
    result: List<ReportResult>.from(json["result"].map((x) => ReportResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class ReportResult {
  int? id;
  String? menuName;
  String? mobileMenuName;

  ReportResult({
    this.id,
    this.menuName,
    this.mobileMenuName,
  });

  factory ReportResult.fromJson(Map<String, dynamic> json) => ReportResult(
    id: json["id"],
    menuName: json["menuName"],
    mobileMenuName: json["mobileMenuName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menuName": menuName,
    "mobileMenuName": mobileMenuName,
  };
}

