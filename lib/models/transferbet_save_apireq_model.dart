// To parse this JSON data, do
//
//     final transferbetSaveApiReq = transferbetSaveApiReqFromJson(jsonString);

import 'dart:convert';

TransferbetSaveApiReq transferbetSaveApiReqFromJson(String str) => TransferbetSaveApiReq.fromJson(json.decode(str));

String transferbetSaveApiReqToJson(TransferbetSaveApiReq data) => json.encode(data.toJson());

class TransferbetSaveApiReq {
  int? id;
  String? transferNo;
  int? fromProjectId;
  int? toProjectId;
  int? fromSiteid;
  int? matReqMasId;
  int? matTransReqMasId;
  String? remarks;
  String? vehicleName;
  String? entryType;
  String? entryDate;
  String? dcNo;
  String? reqOrdNo;
  int? createdBy;
  int? updatedBy;
  double? totalAmount;
  double? transportAmount;
  String? createdDt;
  String? updatedDt;
  List<MaterialTransLink>? materialTransLinks;

  TransferbetSaveApiReq({
    this.id,
    this.transferNo,
    this.fromProjectId,
    this.toProjectId,
    this.fromSiteid,
    this.matReqMasId,
    this.matTransReqMasId,
    this.remarks,
    this.vehicleName,
    this.reqOrdNo,
    this.entryType,
    this.entryDate,
    this.dcNo,
    this.totalAmount,
    this.transportAmount,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
    this.materialTransLinks,
  });

  factory TransferbetSaveApiReq.fromJson(Map<String, dynamic> json) => TransferbetSaveApiReq(
    id: json["id"],
    transferNo: json["transferNo"],
    fromProjectId: json["fromProjectId"],
    toProjectId: json["toProjectId"],
    fromSiteid: json["fromSiteid"],
    matReqMasId: json["matReqMasId"],
    matTransReqMasId: json["matTransReqMasId"],
    remarks: json["remarks"],
    vehicleName: json["vehicleName"],
    reqOrdNo: json["reqOrdNo"],
    entryType: json["entryType"],
    entryDate: json["entryDate"],
    dcNo: json["dcNo"],
    totalAmount: json["totalAmount"],
    transportAmount: json["transportAmount"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    materialTransLinks: List<MaterialTransLink>.from(json["materialTransLinks"].map((x) => MaterialTransLink.fromJson(x))),
  );

  Map<String, dynamic> toJson()  {
    final data = {
    "id": id,
    "transferNo": transferNo,
    "fromProjectId": fromProjectId,
    "toProjectId": toProjectId,
    "fromSiteid": fromSiteid,
    "matReqMasId": matReqMasId,
    "matTransReqMasId": matTransReqMasId,
    "remarks": remarks,
    "vehicleName": vehicleName,
    "reqOrdNo": reqOrdNo,
    "entryType": entryType,
    "entryDate": entryDate,
    "dcNo": dcNo,
    "transportAmount": transportAmount,
    "totalAmount": totalAmount,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
    "materialTransLinks": materialTransLinks?.map((x) => x.toJson()).toList(),
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

class MaterialTransLink {
  int? id;
  int? materialTransferMasId;
  int? materialId;
  double? qty;
  int? reqMasDetId;
  int? transReqDetId;
  double? rate;
  double? amount;

  MaterialTransLink({
    this.id,
    this.materialTransferMasId,
    this.materialId,
    this.qty,
    this.reqMasDetId,
    this.transReqDetId,
    this.rate,
    this.amount,
  });

  factory MaterialTransLink.fromJson(Map<String, dynamic> json) => MaterialTransLink(
    id: json["id"],
    materialTransferMasId: json["materialTransferMasId"],
    materialId: json["materialId"],
    qty: json["qty"],
    reqMasDetId: json["reqMasDetId"],
    transReqDetId: json["transReqDetId"],
    rate: json["rate"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialTransferMasId": materialTransferMasId,
    "materialId": materialId,
    "qty": qty,
    "reqMasDetId": reqMasDetId,
    "transReqDetId": transReqDetId,
    "rate": rate,
    "amount": amount,
  };
}
