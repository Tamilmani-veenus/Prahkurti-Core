

import 'dart:convert';

List<MaterialWiseShowListResponse> materialWiseShowListResponseFromJson(String str) => List<MaterialWiseShowListResponse>.from(json.decode(str).map((x) => MaterialWiseShowListResponse.fromJson(x)));

String materialWiseShowListResponseToJson(List<MaterialWiseShowListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialWiseShowListResponse {
  MaterialWiseShowListResponse({
    this.siteid,
    this.siteName,
    this.footerId,
    this.footer,
    this.headerId,
    this.header,
    this.unit,
    this.balQty,
    this.stockQty,
  });

  int? siteid;
  String? siteName;
  int? footerId;
  String? footer;
  int? headerId;
  String? header;
  String? unit;
  double? balQty;
  double? stockQty;

  factory MaterialWiseShowListResponse.fromJson(Map<String, dynamic> json) => MaterialWiseShowListResponse(
    siteid: json["siteid"],
    siteName: json["SiteName"],
    footerId: json["FooterId"],
    footer: json["Footer"],
    headerId: json["HeaderId"],
    header: json["Header"],
    unit: json["Unit"],
    balQty: json["Bal_Qty"].toDouble(),
    stockQty: json["Stock_Qty"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "siteid": siteid,
    "SiteName": siteName,
    "FooterId": footerId,
    "Footer": footer,
    "HeaderId": headerId,
    "Header": header,
    "Unit": unit,
    "Bal_Qty": balQty,
    "Stock_Qty": stockQty,
  };
}
