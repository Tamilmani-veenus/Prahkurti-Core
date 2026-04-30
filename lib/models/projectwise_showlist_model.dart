import 'dart:convert';

List<ProjectWiseShowListResponse> projectWiseShowListResponseFromJson(String str) => List<ProjectWiseShowListResponse>.from(json.decode(str).map((x) => ProjectWiseShowListResponse.fromJson(x)));

String projectWiseShowListResponseToJson(List<ProjectWiseShowListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectWiseShowListResponse {
  ProjectWiseShowListResponse({
    this.siteid,
    this.siteName,
    this.headerId,
    this.header,
    this.footerId,
    this.footer,
    this.unit,
    this.balQty,
    this.stockQty,
  });

  int? siteid;
  String? siteName;
  int? headerId;
  String? header;
  int? footerId;
  String? footer;
  String? unit;
  double? balQty;
  double? stockQty;

  factory ProjectWiseShowListResponse.fromJson(Map<String, dynamic> json) => ProjectWiseShowListResponse(
    siteid: json["siteid"],
    siteName: json["SiteName"],
    headerId: json["HeaderId"],
    header: json["Header"],
    footerId: json["FooterId"],
    footer: json["Footer"],
    unit: json["Unit"],
    balQty: json["Bal_Qty"].toDouble(),
    stockQty: json["Stock_Qty"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "siteid": siteid,
    "SiteName": siteName,
    "HeaderId": headerId,
    "Header": header,
    "FooterId": footerId,
    "Footer": footer,
    "Unit": unit,
    "Bal_Qty": balQty,
    "Stock_Qty": stockQty,
  };
}


//---------New Stock Materials List-------

//
// StockReport stockReportFromJson(String str) => StockReport.fromJson(json.decode(str));
//
// String stockReportToJson(StockReport data) => json.encode(data.toJson());
//
// class StockReport {
//   List<GetStockReport>? getStockReport;
//
//   StockReport({
//     this.getStockReport,
//   });
//
//   factory StockReport.fromJson(Map<String, dynamic> json) => StockReport(
//     getStockReport: List<GetStockReport>.from(json["GetStockReport"].map((x) => GetStockReport.fromJson(x))),
//   );
//
//
//   Map<String, dynamic> toJson() => {
//     "GetStockReport": List<dynamic>.from(getStockReport!.map((x) => x.toJson())),
//   };
// }
//
// class GetStockReport {
//   String? projectName;
//   List<StockRepDetail> stockRepDetails;
//
//   GetStockReport({
//     this.projectName,
//     required this.stockRepDetails,
//   });
//
//   factory GetStockReport.fromJson(Map<String, dynamic> json) => GetStockReport(
//     projectName: json["projectName"],
//     stockRepDetails: json["StockRepDetails"] != null
//         ? List<StockRepDetail>.from(json["StockRepDetails"].map((x) => StockRepDetail.fromJson(x)))
//         : [],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "projectName": projectName,
//     "StockRepDetails": List<dynamic>.from(stockRepDetails!.map((x) => x.toJson())),
//   };
// }
//
// class StockRepDetail {
//   MaterialHead? materialHead;
//   String? unit;
//   double? stockQty;
//   String? footer;
//
//   StockRepDetail({
//     this.materialHead,
//     this.unit,
//     this.stockQty,
//     this.footer,
//   });
//
//   factory StockRepDetail.fromJson(Map<String, dynamic> json) => StockRepDetail(
//     materialHead: materialHeadValues.map[json["Material_Head"]],
//     unit: json["Unit"],
//     stockQty: json["Stock_Qty"],
//     footer: json["Footer"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Material_Head": materialHeadValues.reverse[materialHead],
//     "Unit": unit,
//     "Stock_Qty": stockQty,
//     "Footer": footer,
//   };
// }
//
// enum MaterialHead {
//   CIVIL_MATERIALS,
//   VCPL_CENTERING_MATERIALS
// }
//
// final materialHeadValues = EnumValues({
//   "CIVIL MATERIALS": MaterialHead.CIVIL_MATERIALS,
//   "VCPL CENTERING MATERIALS": MaterialHead.VCPL_CENTERING_MATERIALS
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }




