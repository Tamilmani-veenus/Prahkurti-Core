import 'dart:convert';

List<TransferAckEditApiRes> transferAckEditApiResFromJson(String str) => List<TransferAckEditApiRes>.from(json.decode(str).map((x) => TransferAckEditApiRes.fromJson(x)));

String transferAckEditApiResToJson(List<TransferAckEditApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferAckEditApiRes {
  TransferAckEditApiRes({
    this.ackId,
    this.ackNo,
    this.ackDate,
    this.transferId,
    this.transferNo,
    this.frProjectId,
    this.toProjectId,
    this.toSiteId,
    this.remarks,
    this.frProject,
    this.toProject,
    this.toSiteName,
    this.transferAckEditDet,
  });

  int? ackId;
  String? ackNo;
  String? ackDate;
  int? transferId;
  String? transferNo;
  int? frProjectId;
  int? toProjectId;
  int? toSiteId;
  String? remarks;
  String? frProject;
  String? toProject;
  String? toSiteName;
  List<TransferAckEditDet>? transferAckEditDet;

  factory TransferAckEditApiRes.fromJson(Map<String, dynamic> json) => TransferAckEditApiRes(
    ackId: json["AckId"],
    ackNo: json["AckNo"],
    ackDate: json["AckDate"],
    transferId: json["TransferId"],
    transferNo: json["TransferNo"],
    frProjectId: json["FrProjectId"],
    toProjectId: json["ToProjectId"],
    toSiteId: json["ToSiteId"],
    remarks: json["Remarks"],
    frProject: json["FrProject"],
    toProject: json["ToProject"],
    toSiteName: json["ToSiteName"],
    transferAckEditDet: List<TransferAckEditDet>.from(json["TransferAckEditDet"].map((x) => TransferAckEditDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AckId": ackId,
    "AckNo": ackNo,
    "AckDate": ackDate,
    "TransferId": transferId,
    "TransferNo": transferNo,
    "FrProjectId": frProjectId,
    "ToProjectId": toProjectId,
    "ToSiteId": toSiteId,
    "Remarks": remarks,
    "FrProject": frProject,
    "ToProject": toProject,
    "ToSiteName": toSiteName,
    "TransferAckEditDet": List<dynamic>.from(transferAckEditDet!.map((x) => x.toJson())),
  };
}

class TransferAckEditDet {
  TransferAckEditDet({
    this.transferDetId,
    this.materialId,
    this.materialName,
    this.scale,
    this.transQty,
    this.ackQty,
  });

  int? transferDetId;
  int? materialId;
  String? materialName;
  String? scale;
  double? transQty;
  double? ackQty;

  factory TransferAckEditDet.fromJson(Map<String, dynamic> json) => TransferAckEditDet(
    transferDetId: json["TransferDetId"],
    materialId: json["MaterialId"],
    materialName: json["MaterialName"],
    scale: json["Scale"],
    transQty: json["TransQty"],
    ackQty: json["AckQty"],
  );

  Map<String, dynamic> toJson() => {
    "TransferDetId": transferDetId,
    "MaterialId": materialId,
    "MaterialName": materialName,
    "Scale": scale,
    "TransQty": transQty,
    "AckQty": ackQty,
  };
}
