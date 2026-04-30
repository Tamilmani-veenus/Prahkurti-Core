// To parse this JSON data, do
//
//     final transferAckSaveReq = transferAckSaveReqFromJson(jsonString);

import 'dart:convert';

TransferAckSaveReq transferAckSaveReqFromJson(String str) => TransferAckSaveReq.fromJson(json.decode(str));

String transferAckSaveReqToJson(TransferAckSaveReq data) => json.encode(data.toJson());

class TransferAckSaveReq {
  int? id;
  String? acknowledgeNo;
  String? entryDate;
  int? transferId;
  int? fromProjectId;
  int? toProjectId;
  int? toSiteId;
  int? createdBy;
  String? createdDt;
  String? transferNo;
  String? remarks;
  List<MaterialtransferDetDto>? materialtransferDetDto;

  TransferAckSaveReq({
    this.id,
    this.acknowledgeNo,
    this.entryDate,
    this.transferId,
    this.fromProjectId,
    this.toProjectId,
    this.toSiteId,
    this.createdBy,
    this.createdDt,
    this.transferNo,
    this.remarks,
    this.materialtransferDetDto,
  });

  factory TransferAckSaveReq.fromJson(Map<String, dynamic> json) => TransferAckSaveReq(
    id: json["id"],
    acknowledgeNo: json["acknowledgeNo"],
    entryDate: json["entryDate"],
    transferId: json["transferId"],
    fromProjectId: json["fromProjectId"],
    toProjectId: json["toProjectId"],
    toSiteId: json["toSiteId"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    transferNo: json["transferNo"],
    remarks: json["remarks"],
    materialtransferDetDto: List<MaterialtransferDetDto>.from(json["materialtransferDetDto"].map((x) => MaterialtransferDetDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "acknowledgeNo": acknowledgeNo,
    "entryDate": entryDate,
    "transferId": transferId,
    "fromProjectId": fromProjectId,
    "toProjectId": toProjectId,
    "toSiteId": toSiteId,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "transferNo": transferNo,
    "remarks": remarks,
    "materialtransferDetDto": List<dynamic>.from(materialtransferDetDto!.map((x) => x.toJson())),
  };
}

class MaterialtransferDetDto {
  int? id;
  int? materialTransferMasId;
  int? materialId;
  double? qty;
  String? ackRemarks;
  double? ackQty;
  String? ackDiffStatus;

  MaterialtransferDetDto({
    this.id,
    this.materialTransferMasId,
    this.materialId,
    this.qty,
    this.ackRemarks,
    this.ackQty,
    this.ackDiffStatus,
  });

  factory MaterialtransferDetDto.fromJson(Map<String, dynamic> json) => MaterialtransferDetDto(
    id: json["id"],
    materialTransferMasId: json["materialTransferMasId"],
    materialId: json["materialId"],
    qty: json["qty"],
    ackRemarks: json["ackRemarks"],
    ackQty: json["ackQty"],
    ackDiffStatus: json["ackDiffStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialTransferMasId": materialTransferMasId,
    "materialId": materialId,
    "qty": qty,
    "ackRemarks": ackRemarks,
    "ackQty": ackQty,
    "ackDiffStatus": ackDiffStatus,
  };
}
