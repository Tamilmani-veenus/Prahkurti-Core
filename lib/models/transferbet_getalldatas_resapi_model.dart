// To parse this JSON data, do
//
//     final transferbetAlldatasApiRes = transferbetAlldatasApiResFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final transferbetAlldatasApiRes = transferbetAlldatasApiResFromJson(jsonString);

TransferbetAlldatasApiRes transferbetAlldatasApiResFromJson(String str) => TransferbetAlldatasApiRes.fromJson(json.decode(str));

String transferbetAlldatasApiResToJson(TransferbetAlldatasApiRes data) => json.encode(data.toJson());

class TransferbetAlldatasApiRes {
  bool? success;
  String? message;
  List<Result>? result;

  TransferbetAlldatasApiRes({
    this.success,
    this.message,
    this.result,
  });

  factory TransferbetAlldatasApiRes.fromJson(Map<String, dynamic> json) => TransferbetAlldatasApiRes(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? reqMasid;
  int? reqdetid;
  String? requestNo;
  String? requestDate;
  String? reqDueDate;
  String? approvedate;
  int? fromProjectid;
  String? fromProjectName;
  int? toProjectId;
  String? toprojectName;
  int? siteId;
  String? siteName;
  int? materialId;
  String? materialName;
  int? scaleId;
  String? scaleName;
  String? approveType;
  double? reqQty;
  double? qty;
  double? estQty;
  double? balQty;
  double? transQty;
  String? remarks;

  Result({
    this.reqMasid,
    this.reqdetid,
    this.requestNo,
    this.requestDate,
    this.reqDueDate,
    this.approvedate,
    this.fromProjectid,
    this.fromProjectName,
    this.toProjectId,
    this.toprojectName,
    this.siteId,
    this.siteName,
    this.materialId,
    this.materialName,
    this.scaleId,
    this.scaleName,
    this.approveType,
    this.reqQty,
    this.qty,
    this.estQty,
    this.balQty,
    this.transQty,
    this.remarks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    reqMasid: json["ReqMasid"],
    reqdetid: json["Reqdetid"],
    requestNo: json["RequestNo"],
    requestDate: json["RequestDate"],
    reqDueDate: json["ReqDueDate"],
    approvedate: json["Approvedate"],
    fromProjectid: json["FromProjectid"],
    fromProjectName: json["FromProjectName"],
    toProjectId: json["ToProjectId"],
    toprojectName: json["ToprojectName"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    materialId: json["MaterialID"],
    materialName: json["MaterialName"],
    scaleId: json["ScaleID"],
    scaleName: json["ScaleName"],
    approveType: json["ApproveType"],
    reqQty: json["ReqQty"],
    qty: json["Qty"],
    estQty: json["EstQty"],
    balQty: json["BalQty"],
    transQty: json["TransQty"],
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "ReqMasid": reqMasid,
    "Reqdetid": reqdetid,
    "RequestNo": requestNo,
    "RequestDate": requestDate,
    "ReqDueDate": reqDueDate,
    "Approvedate": approvedate,
    "FromProjectid": fromProjectid,
    "FromProjectName": fromProjectName,
    "ToProjectId": toProjectId,
    "ToprojectName": toprojectName,
    "SiteId": siteId,
    "SiteName": siteName,
    "MaterialID": materialId,
    "MaterialName": materialName,
    "ScaleID": scaleId,
    "ScaleName": scaleName,
    "ApproveType": approveType,
    "ReqQty": reqQty,
    "Qty": qty,
    "EstQty": estQty,
    "BalQty": balQty,
    "TransQty": transQty,
    "Remarks": remarks,
  };
}


TransReqPendingView transReqPendingViewFromJson(String str) => TransReqPendingView.fromJson(json.decode(str));

String transReqPendingViewToJson(TransReqPendingView data) => json.encode(data.toJson());

class TransReqPendingView {
  bool? success;
  String? message;
  List<TransferEditDet>? transferEditDet;

  TransReqPendingView({
    this.success,
    this.message,
    this.transferEditDet,
  });

  factory TransReqPendingView.fromJson(Map<String, dynamic> json) => TransReqPendingView(
    success: json["success"],
    message: json["message"],
    transferEditDet: List<TransferEditDet>.from(json["result"].map((x) => TransferEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(transferEditDet!.map((x) => x.toJson())),
  };
}

class TransferEditDet {
  int? detId;
  int? id;
  String? transferNo;
  String? transferEntryDate;
  int? fromProjectId;
  String? fromProjectName;
  int? fromSiteId;
  String? siteName;
  int? toProjectId;
  String? toProjectName;
  int? materialId;
  String? materialName;
  String? scale;
  int? scaleId;
  double? transQty;
  double? qty;
  double? trQty;
  double? balQty;
  double? stockQty;
  String? remarks;

  TransferEditDet({
    this.detId,
    this.id,
    this.transferNo,
    this.transferEntryDate,
    this.fromProjectId,
    this.fromProjectName,
    this.fromSiteId,
    this.siteName,
    this.toProjectId,
    this.toProjectName,
    this.materialId,
    this.materialName,
    this.scaleId,
    this.scale,
    this.transQty,
    this.qty,
    this.trQty,
    this.balQty,
    this.stockQty,
    this.remarks,
  });

  factory TransferEditDet.fromJson(Map<String, dynamic> json) => TransferEditDet(
    detId: json["detId"],
    id: json["id"],
    transferNo: json["TransferNo"],
    transferEntryDate: json["TransferEntryDate"],
    fromProjectId: json["FromProjectId"],
    fromProjectName: json["FromProjectName"],
    fromSiteId: json["FromSiteId"],
    siteName: json["SiteName"],
    toProjectId: json["ToProjectId"],
    toProjectName: json["ToProjectName"],
    materialId: json["Materialid"],
    materialName: json["MaterialName"],
    scaleId: json["ScaleID"],
    scale: json["ScaleName"],
    transQty: json["TransQty"],
    qty: json["Qty"],
    trQty: json["TrQty"],
    balQty: json["balQty"],
    stockQty: json["StockQty"],
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "detId": detId,
    "id": id,
    "TransferNo": transferNo,
    "TransferEntryDate": transferEntryDate,
    "FromProjectId": fromProjectId,
    "FromProjectName": fromProjectName,
    "FromSiteId": fromSiteId,
    "SiteName": siteName,
    "ToProjectId": toProjectId,
    "ToProjectName": toProjectName,
    "Materialid": materialId,
    "MaterialName": materialName,
    "ScaleID": scaleId,
    "ScaleName": scale,
    "TransQty": transQty,
    "Qty": qty,
    "TrQty": trQty,
    "balQty": balQty,
    "StockQty": stockQty,
    "Remarks": remarks,
  };
}
