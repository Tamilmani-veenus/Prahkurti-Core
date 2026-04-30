// To parse this JSON data, do
//
//     final materialTransReqsave = materialTransReqsaveFromJson(jsonString);

import 'dart:convert';

MaterialTransReqsave materialTransReqsaveFromJson(String str) =>
    MaterialTransReqsave.fromJson(json.decode(str));

String materialTransReqsaveToJson(MaterialTransReqsave data) =>
    json.encode(data.toJson());

class MaterialTransReqsave {
  int? id;
  String? transferNo;
  String? transferEntryDate;
  int? fromProjectId;
  int? fromSiteId;
  int? toProjectId;
  int? preparedBy;
  String? remarks;
  bool? verifyStatus;
  int? verifyBy;
  String? verifyDate;
  bool? approveStatus;
  int? approvedBy;
  String? approveDate;
  int? createdBy;
  String? createdDate;
  List<MaterialTransferRequestDet>? materialTransferRequestDets;

  MaterialTransReqsave({
    this.id,
    this.transferNo,
    this.transferEntryDate,
    this.fromProjectId,
    this.fromSiteId,
    this.toProjectId,
    this.preparedBy,
    this.remarks,
    this.verifyStatus,
    this.verifyBy,
    this.verifyDate,
    this.approveStatus,
    this.approvedBy,
    this.approveDate,
    this.createdBy,
    this.createdDate,
    this.materialTransferRequestDets,
  });

  factory MaterialTransReqsave.fromJson(Map<String, dynamic> json) =>
      MaterialTransReqsave(
        id: json["id"],
        transferNo: json["transferNo"],
        transferEntryDate: json["transferEntryDate"],
        fromProjectId: json["fromProjectId"],
        fromSiteId: json["fromSiteId"],
        toProjectId: json["toProjectId"],
        preparedBy: json["preparedBy"],
        remarks: json["remarks"],
        verifyStatus: json["verifyStatus"],
        verifyBy: json["verifyBy"],
        verifyDate: json["verifyDate"],
        approveStatus: json["approveStatus"],
        approvedBy: json["approvedBy"],
        approveDate: json["approveDate"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        materialTransferRequestDets: List<MaterialTransferRequestDet>.from(
            json["materialTransferRequestDets"]
                .map((x) => MaterialTransferRequestDet.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    final data = {
      "id": id,
      "transferNo": transferNo,
      "transferEntryDate": transferEntryDate,
      "fromProjectId": fromProjectId,
      "fromSiteId": fromSiteId,
      "toProjectId": toProjectId,
      "preparedBy": preparedBy,
      "remarks": remarks,
      "verifyStatus": verifyStatus,
      "verifyBy": verifyBy,
      "verifyDate": verifyDate,
      "approveStatus": approveStatus,
      "approvedBy": approvedBy,
      "approveDate": approveDate,
      "createdBy": createdBy,
      "createdDate": createdDate,
      "materialTransferRequestDets": List<dynamic>.from(
          materialTransferRequestDets!.map((x) => x.toJson())),
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

class MaterialTransferRequestDet {
  int? id;
  int? materialTransferRequestMasId;
  int? materialId;
  double? qty;
  double? trQty;
  String? remarks;

  MaterialTransferRequestDet({
    this.id,
    this.materialTransferRequestMasId,
    this.materialId,
    this.qty,
    this.trQty,
    this.remarks,
  });

  factory MaterialTransferRequestDet.fromJson(Map<String, dynamic> json) =>
      MaterialTransferRequestDet(
        id: json["id"],
        materialTransferRequestMasId: json["materialTransferRequestMasId"],
        materialId: json["materialId"],
        qty: json["qty"],
        trQty: json["trQty"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "materialTransferRequestMasId": materialTransferRequestMasId,
        "materialId": materialId,
        "qty": qty,
        "trQty": trQty,
        "remarks": remarks,
      };
}
