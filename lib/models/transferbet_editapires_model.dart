// To parse this JSON data, do
//
//     final transferbetEditApiRes = transferbetEditApiResFromJson(jsonString);

import 'dart:convert';

TransferbetEditApiRes transferbetEditApiResFromJson(String str) => TransferbetEditApiRes.fromJson(json.decode(str));

String transferbetEditApiResToJson(TransferbetEditApiRes data) => json.encode(data.toJson());

class TransferbetEditApiRes {
  bool? success;
  String? message;
  transEditResult? result;

  TransferbetEditApiRes({
    this.success,
    this.message,
    this.result,
  });

  factory TransferbetEditApiRes.fromJson(Map<String, dynamic> json) => TransferbetEditApiRes(
    success: json["success"],
    message: json["message"],
    result: transEditResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class transEditResult {
  int? id;
  String? transferNo;
  int? fromProjectId;
  int? toProjectId;
  int? fromSiteid;
  String? ackStatus;
  int? matReqMasId;
  int? matTransReqMasId;
  String? remarks;
  String? vehicleName;
  String? entryType;
  String? entryName;
  String? entryDate;
  String? dcNo;
  int? createdBy;
  double? totalAmount;
  double? transportAmount;
  String? createdDt;
  String? frProjectName;
  String? toProjectName;
  String? frSiteName;
  String? matTransferReqNo;
  String? createdName;
  String? reqOrdNo;
  List<transEditDetResult>? materialTransLinks;

  transEditResult({
    this.id,
    this.transferNo,
    this.fromProjectId,
    this.toProjectId,
    this.fromSiteid,
    this.ackStatus,
    this.matReqMasId,
    this.matTransReqMasId,
    this.remarks,
    this.vehicleName,
    this.entryType,
    this.entryName,
    this.entryDate,
    this.dcNo,
    this.transportAmount,
    this.totalAmount,
    this.createdBy,
    this.createdDt,
    this.frProjectName,
    this.toProjectName,
    this.frSiteName,
    this.matTransferReqNo,
    this.createdName,
    this.reqOrdNo,
    this.materialTransLinks,
  });

  factory transEditResult.fromJson(Map<String, dynamic> json) => transEditResult(
    id: json["id"],
    transferNo: json["transferNo"],
    fromProjectId: json["fromProjectId"],
    toProjectId: json["toProjectId"],
    fromSiteid: json["fromSiteid"],
    ackStatus: json["ackStatus"],
    matReqMasId: json["matReqMasId"],
    matTransReqMasId: json["matTransReqMasId"],
    remarks: json["remarks"],
    vehicleName: json["vehicleName"],
    entryType: json["entryType"],
    entryName: json["entryName"],
    entryDate: json["entryDate"],
    dcNo: json["dcNo"],
    transportAmount: json["transportAmount"],
    totalAmount: json["totalAmount"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    frProjectName: json["frProjectName"],
    toProjectName: json["toProjectName"],
    frSiteName: json["frSiteName"],
    matTransferReqNo: json["matTransferReqNo"],
    createdName: json["createdName"],
    reqOrdNo: json["reqOrdNo"],
    materialTransLinks: List<transEditDetResult>.from(json["materialTransLinks"].map((x) => transEditDetResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transferNo": transferNo,
    "fromProjectId": fromProjectId,
    "toProjectId": toProjectId,
    "fromSiteid": fromSiteid,
    "ackStatus": ackStatus,
    "matReqMasId": matReqMasId,
    "matTransReqMasId": matTransReqMasId,
    "remarks": remarks,
    "vehicleName": vehicleName,
    "entryType": entryType,
    "entryName": entryName,
    "entryDate": entryDate,
    "dcNo": dcNo,
    "transportAmount": transportAmount,
    "totalAmount": totalAmount,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "frProjectName": frProjectName,
    "toProjectName": toProjectName,
    "frSiteName": frSiteName,
    "matTransferReqNo": matTransferReqNo,
    "createdName": createdName,
    "reqOrdNo": reqOrdNo,
    "materialTransLinks": List<dynamic>.from(materialTransLinks!.map((x) => x.toJson())),
  };
}

class transEditDetResult {
  int? reqDetId;
  int? materialTransferMasId;
  int? materialId;
  String? materialName;
  double? qty;
  double? stockQty;
  double? balQty;
  double? balTfrQty;
  int? reqMasDetId;
  int? transReqDetId;
  int? scaleId;
  String? scale;
  double? amount;
  double? rate;
  String? ackDiffStatus;

  transEditDetResult({
    this.reqDetId,
    this.materialTransferMasId,
    this.materialId,
    this.materialName,
    this.qty,
    this.stockQty,
    this.balQty,
    this.balTfrQty,
    this.reqMasDetId,
    this.transReqDetId,
    this.scaleId,
    this.scale,
    this.amount,
    this.rate,
    this.ackDiffStatus,
  });

  factory transEditDetResult.fromJson(Map<String, dynamic> json) => transEditDetResult(
    reqDetId: json["id"],
    materialTransferMasId: json["materialTransferMasId"],
    materialId: json["materialId"],
    materialName: json["materialName"],
    qty: json["qty"],
    stockQty: json["stockQty"],
    balQty: json["balQty"],
    balTfrQty: json["balTfrQty"],
    reqMasDetId: json["reqMasDetId"],
    transReqDetId: json["transReqDetId"],
    scaleId: json["scaleId"],
    scale: json["scaleName"],
    amount: json["amount"],
    rate: json["rate"],
    ackDiffStatus: json["ackDiffStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": reqDetId,
    "materialTransferMasId": materialTransferMasId,
    "materialId": materialId,
    "materialName": materialName,
    "qty": qty,
    "stockQty": stockQty,
    "balQty": balQty,
    "balTfrQty": balTfrQty,
    "reqMasDetId": reqMasDetId,
    "transReqDetId": transReqDetId,
    "scaleId": scaleId,
    "scaleName": scale,
    "amount": amount,
    "rate": rate,
    "ackDiffStatus": ackDiffStatus,
  };
}
