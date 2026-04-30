// To parse this JSON data, do
//
//     final transferbetSiteSaveApiReq = transferbetSiteSaveApiReqFromJson(jsonString);

import 'dart:convert';

TransferbetSiteSaveApiReq transferbetSiteSaveApiReqFromJson(String str) => TransferbetSiteSaveApiReq.fromJson(json.decode(str));

String transferbetSiteSaveApiReqToJson(TransferbetSiteSaveApiReq data) => json.encode(data.toJson());

class TransferbetSiteSaveApiReq {
  int? id;
  String? transferNo;
  String? entryDt;
  int? fromSiteid;
  int? toSiteId;
  int? reqOrdMasId;
  String? remarks;
  int? fromProjectId;
  int? subContractId;
  int? transferType;
  int? createdBy;
  String? createdDt;
  String? updatedDate;
  int? updatedBy;
  List<MaterialSiteLink>? materialSiteLink;

  TransferbetSiteSaveApiReq({
    this.id,
    this.transferNo,
    this.entryDt,
    this.fromSiteid,
    this.toSiteId,
    this.reqOrdMasId,
    this.remarks,
    this.fromProjectId,
    this.subContractId,
    this.transferType,
    this.createdBy,
    this.createdDt,
    this.updatedDate,
    this.updatedBy,
    this.materialSiteLink,
  });

  factory TransferbetSiteSaveApiReq.fromJson(Map<String, dynamic> json) => TransferbetSiteSaveApiReq(
    id: json["id"],
    transferNo: json["transferNo"],
    entryDt: json["entryDt"],
    fromSiteid: json["fromSiteid"],
    toSiteId: json["toSiteId"],
    reqOrdMasId: json["reqOrdMasId"],
    remarks: json["remarks"],
    fromProjectId: json["fromProjectId"],
    subContractId: json["subContractId"],
    transferType: json["transferType"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDate: json["updatedDate"],
    materialSiteLink: List<MaterialSiteLink>.from(json["materialSiteLink"].map((x) => MaterialSiteLink.fromJson(x))),
  );

  Map<String, dynamic> toJson()  {
  final data = {
    "id": id,
    "transferNo": transferNo,
    "entryDt": entryDt,
    "fromSiteid": fromSiteid,
    "toSiteId": toSiteId,
    "reqOrdMasId": reqOrdMasId,
    "remarks": remarks,
    "fromProjectId": fromProjectId,
    "subContractId": subContractId,
    "transferType": transferType,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedDate": updatedDate,
    "updatedBy": updatedBy,
    "materialSiteLink": List<dynamic>.from(
        materialSiteLink!.map((x) => x.toJson())),
};
    data.removeWhere((key, value) => value == null);
    return data;
  }
}

class MaterialSiteLink {
  int? id;
  int? transferSiteId;
  int? materialId;
  int? reqOrdDetId;
  double? qty;
  double? rate;
  double? amount;

  MaterialSiteLink({
    this.id,
    this.transferSiteId,
    this.materialId,
    this.reqOrdDetId,
    this.qty,
    this.rate,
    this.amount,
  });

  factory MaterialSiteLink.fromJson(Map<String, dynamic> json) => MaterialSiteLink(
    id: json["id"],
    transferSiteId: json["transferSiteId"],
    materialId: json["materialId"],
    reqOrdDetId: json["reqOrdDetId"],
    qty: json["qty"],
    rate: json["rate"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson(){
  final data = {
    "id": id,
    "transferSiteId": transferSiteId,
    "materialId": materialId,
    "reqOrdDetId": reqOrdDetId,
    "qty": qty,
    "rate": rate,
    "amount": amount,
  };
  data.removeWhere((key, value) => value == null);
  return data;
}

}
