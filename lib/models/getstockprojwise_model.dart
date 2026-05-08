// To parse this JSON data, do
//
//     final getStockRptListDetails = getStockRptListDetailsFromJson(jsonString);

import 'dart:convert';

GetStockRptListDetails getStockRptListDetailsFromJson(String str) => GetStockRptListDetails.fromJson(json.decode(str));

String getStockRptListDetailsToJson(GetStockRptListDetails data) => json.encode(data.toJson());

class GetStockRptListDetails {
  bool? success;
  String? message;
  List<GetStockReport>? getStockReport;

  GetStockRptListDetails({
    this.success,
    this.message,
    this.getStockReport,
  });

  factory GetStockRptListDetails.fromJson(Map<String, dynamic> json) => GetStockRptListDetails(
    success: json["success"],
    message: json["message"],
    getStockReport: json["getStockReport"]==null?[]:List<GetStockReport>.from(json["getStockReport"].map((x) => GetStockReport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "getStockReport": getStockReport==null?[]:List<dynamic>.from(getStockReport!.map((x) => x.toJson())),
  };
}

class GetStockReport {
  String? projectName;
  List<StockRepDetail>? stockRepDetails;

  GetStockReport({
    this.projectName,
    this.stockRepDetails,
  });

  factory GetStockReport.fromJson(Map<String, dynamic> json) => GetStockReport(
    projectName: json["projectName"],
    stockRepDetails: json["stockRepDetails"]==null?[]:List<StockRepDetail>.from(json["stockRepDetails"].map((x) => StockRepDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "stockRepDetails": stockRepDetails==null?[]:List<dynamic>.from(stockRepDetails!.map((x) => x.toJson())),
  };
}

class StockRepDetail {
  int? projectId;
  String? projectName;
  String? materialHeadName;
  String? unit;
  double? stockQty;
  String? footer;
  String? header;

  StockRepDetail({
    this.projectId,
    this.projectName,
    this.materialHeadName,
    this.unit,
    this.stockQty,
    this.footer,
    this.header,
  });

  factory StockRepDetail.fromJson(Map<String, dynamic> json) => StockRepDetail(
    projectId: json["projectId"],
    projectName: json["projectName"],
    materialHeadName: json["materialHeadName"],
    unit: json["unit"],
    stockQty: json["stock_Qty"],
    footer: json["footer"],
    header: json["header"],
  );

  Map<String, dynamic> toJson() => {
    "projectId": projectId,
    "projectName": projectName,
    "materialHeadName": materialHeadName,
    "unit": unit,
    "stock_Qty": stockQty,
    "footer": footer,
    "header": header,
  };
}
