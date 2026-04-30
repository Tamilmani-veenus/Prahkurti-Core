// To parse this JSON data, do
//
//     final matTransReqEdit = matTransReqEditFromJson(jsonString);

import 'dart:convert';

MatTransReqEdit matTransReqEditFromJson(String str) => MatTransReqEdit.fromJson(json.decode(str));

String matTransReqEditToJson(MatTransReqEdit data) => json.encode(data.toJson());

class MatTransReqEdit {
  bool? success;
  String? message;
  Result? result;

  MatTransReqEdit({
    this.success,
    this.message,
    this.result,
  });

  factory MatTransReqEdit.fromJson(Map<String, dynamic> json) => MatTransReqEdit(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class Result {
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
  bool? approveStatus;
  int? approvedBy;
  int? createdBy;
  String? createdDate;
  String? siteName;
  String? toProjectName;
  String? fromProjectName;
  String? status;
  String? createdName;
  List<MaterialTransferRequestDet>? materialTransferRequestDets;

  Result({
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
    this.approveStatus,
    this.approvedBy,
    this.createdBy,
    this.createdDate,
    this.siteName,
    this.toProjectName,
    this.fromProjectName,
    this.status,
    this.createdName,
    this.materialTransferRequestDets,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    approveStatus: json["approveStatus"],
    approvedBy: json["approvedBy"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    siteName: json["siteName"],
    toProjectName: json["toProjectName"],
    fromProjectName: json["fromProjectName"],
    status: json["status"],
    createdName: json["createdName"],
    materialTransferRequestDets: List<MaterialTransferRequestDet>.from(json["materialTransferRequestDets"].map((x) => MaterialTransferRequestDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
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
    "approveStatus": approveStatus,
    "approvedBy": approvedBy,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "siteName": siteName,
    "toProjectName": toProjectName,
    "fromProjectName": fromProjectName,
    "status": status,
    "createdName": createdName,
    "materialTransferRequestDets": List<dynamic>.from(materialTransferRequestDets!.map((x) => x.toJson())),
  };
}

class MaterialTransferRequestDet {
  int? id;
  int? materialTransferRequestMasId;
  int? materialId;
  double? qty;
  double? trQty;
  String? remarks;
  String? materialName;
  String? scaleName;
  double? stockQty;

  MaterialTransferRequestDet({
    this.id,
    this.materialTransferRequestMasId,
    this.materialId,
    this.qty,
    this.trQty,
    this.remarks,
    this.materialName,
    this.scaleName,
    this.stockQty,
  });

  factory MaterialTransferRequestDet.fromJson(Map<String, dynamic> json) => MaterialTransferRequestDet(
    id: json["id"],
    materialTransferRequestMasId: json["materialTransferRequestMasId"],
    materialId: json["materialId"],
    qty: json["qty"],
    trQty: json["trQty"],
    remarks: json["remarks"],
    materialName: json["materialName"],
    scaleName: json["scaleName"],
    stockQty: json["stockQty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialTransferRequestMasId": materialTransferRequestMasId,
    "materialId": materialId,
    "qty": qty,
    "trQty": trQty,
    "remarks": remarks,
    "materialName": materialName,
    "scaleName": scaleName,
    "stockQty": stockQty,
  };
}
