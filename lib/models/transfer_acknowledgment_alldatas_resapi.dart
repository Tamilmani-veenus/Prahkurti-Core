// To parse this JSON data, do
//
//     final transferacknowAlldatasRes = transferacknowAlldatasResFromJson(jsonString);

import 'dart:convert';

TransferacknowAlldatasRes transferacknowAlldatasResFromJson(String str) => TransferacknowAlldatasRes.fromJson(json.decode(str));

String transferacknowAlldatasResToJson(TransferacknowAlldatasRes data) => json.encode(data.toJson());

class TransferacknowAlldatasRes {
  bool? success;
  String? message;
  List<Result>? result;

  TransferacknowAlldatasRes({
    this.success,
    this.message,
    this.result,
  });

  factory TransferacknowAlldatasRes.fromJson(Map<String, dynamic> json) => TransferacknowAlldatasRes(
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
  int? detid;
  String? transferNo;
  int? id;
  String? entryDate;
  int? fromProjectId;
  String? fromProjectName;
  int? toProjectId;
  String? toProjectName;
  String? entryType;
  String? dcNo;
  String? vehicleName;
  int? fromSiteid;
  String? fromSiteName;
  int? materialId;
  String? materialName;
  int? scaleId;
  String? scaleName;
  double? transQty;
  double? ackQty;
  String? ackRemarks;

  Result({
    this.detid,
    this.transferNo,
    this.id,
    this.entryDate,
    this.fromProjectId,
    this.fromProjectName,
    this.toProjectId,
    this.toProjectName,
    this.entryType,
    this.dcNo,
    this.vehicleName,
    this.fromSiteid,
    this.fromSiteName,
    this.materialId,
    this.materialName,
    this.scaleId,
    this.scaleName,
    this.transQty,
    this.ackQty,
    this.ackRemarks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    detid: json["detid"],
    transferNo: json["transferNo"],
    id: json["id"],
    entryDate: json["entryDate"],
    fromProjectId: json["fromProjectId"],
    fromProjectName: json["fromProjectName"],
    toProjectId: json["toProjectId"],
    toProjectName: json["toProjectName"],
    entryType: json["entryType"],
    dcNo: json["dcNo"],
    vehicleName: json["vehicleName"],
    fromSiteid: json["fromSiteid"],
    fromSiteName: json["fromSiteName"],
    materialId: json["materialId"],
    materialName: json["materialName"],
    scaleId: json["scaleID"],
    scaleName: json["scaleName"],
    transQty: json["transQty"],
    ackQty: json["ackQty"],
    ackRemarks: json["ackRemarks"],
  );

  Map<String, dynamic> toJson() => {
    "detid": detid,
    "transferNo": transferNo,
    "id": id,
    "entryDate": entryDate,
    "fromProjectId": fromProjectId,
    "fromProjectName": fromProjectName,
    "toProjectId": toProjectId,
    "toProjectName": toProjectName,
    "entryType": entryType,
    "dcNo": dcNo,
    "vehicleName": vehicleName,
    "fromSiteid": fromSiteid,
    "fromSiteName": fromSiteName,
    "materialId": materialId,
    "materialName": materialName,
    "scaleID": scaleId,
    "scaleName": scaleName,
    "transQty": transQty,
    "ackQty": ackQty,
    "ackRemarks": ackRemarks,
  };
}
