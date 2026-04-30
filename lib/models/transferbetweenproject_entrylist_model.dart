// import 'dart:convert';
//
// List<TransferBProjectentrylist> transferBProjectentrylistFromJson(String str) => List<TransferBProjectentrylist>.from(json.decode(str).map((x) => TransferBProjectentrylist.fromJson(x)));
//
// String transferBProjectentrylistToJson(List<TransferBProjectentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class TransferBProjectentrylist {
//   TransferBProjectentrylist({
//     this.transferId,
//     this.transferNo,
//     this.exdate,
//     this.dcno,
//     this.vehicleno,
//     this.edate,
//     this.frProject,
//     this.fromSite,
//     this.toProject,
//     this.entryType,
//     this.entryTypeName,
//     this.preparedByName,
//     this.ackStatus,
//   });
//
//   int? transferId;
//   String? transferNo;
//   String? exdate;
//   String? edate;
//   String? dcno;
//   String? vehicleno;
//   String? frProject;
//   String? fromSite;
//   String? toProject;
//   String? entryType;
//   String? entryTypeName;
//   String? preparedByName;
//   String? ackStatus;
//
//   factory TransferBProjectentrylist.fromJson(Map<String, dynamic> json) => TransferBProjectentrylist(
//     transferId: json["Transfer_id"],
//     transferNo: json["TransferNo"],
//     exdate: json["Exdate"],
//     dcno: json["dcno"],
//     vehicleno: json["vehicleno"],
//     edate: json["Edate"],
//     frProject: json["FrProject"],
//     fromSite: json["FromSite"],
//     toProject: json["ToProject"],
//     entryType: json["Entry_Type"],
//     entryTypeName: json["EntryTypeName"],
//     preparedByName: json["PreparedByName"],
//     ackStatus: json["AckStatus"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Transfer_id": transferId,
//     "TransferNo": transferNo,
//     "Exdate": exdate,
//     "Edate": edate,
//     "dcno": dcno,
//     "vehicleno": vehicleno,
//     "FrProject": frProject,
//     "FromSite": fromSite,
//     "ToProject": toProject,
//     "Entry_Type": entryType,
//     "EntryTypeName": entryTypeName,
//     "PreparedByName": preparedByName,
//     "AckStatus": ackStatus,
//   };
// }


// To parse this JSON data, do
//
// final getTransferListResponse = getTransferListResponseFromJson(jsonString);

import 'dart:convert';

GetTransferListResponse getTransferListResponseFromJson(String str) =>
    GetTransferListResponse.fromJson(json.decode(str));

String getTransferListResponseToJson(GetTransferListResponse data) =>
    json.encode(data.toJson());

class GetTransferListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  GetTransferListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory GetTransferListResponse.fromJson(Map<String, dynamic> json) =>
      GetTransferListResponse(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(
            json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.transferId,
    this.transferNo,
    this.fromProjectId,
    this.toProjectId,
    this.fromSiteid,
    this.ackStatus,
    this.matReqMasId,
    this.matTransReqMasId,
    this.remarks,
    this.vehicleName,
    this.driverName,
    this.transportAmount,
    this.totalAmount,
    this.entryType,
    this.entryName,
    this.entryDate,
    this.dcNo,
    this.createdBy,
    this.createdDt,
    this.frProjectName,
    this.toProjectName,
    this.frSiteName,
    this.reqOrdNo,
    this.matTransferReqNo,
    this.approveNo,
    this.createdName,
    this.materialName,
    this.scaleName,
    this.qty,
    this.approvedBy,
    this.approveStatus,
    this.approveDate,
    this.verifyStatus,
    this.verifyBy,
    this.verifyDate,
    this.materialTransLinks,
  });

  int? transferId;
  String? transferNo;
  int? fromProjectId;
  int? toProjectId;
  int? fromSiteid;
  dynamic ackStatus;
  int? matReqMasId;
  int? matTransReqMasId;
  String? remarks;
  String? vehicleName;
  dynamic driverName;
  double? transportAmount;
  double? totalAmount;
  String? entryType;
  String? entryName;
  String? entryDate;
  String? dcNo;
  int? createdBy;
  String? createdDt;
  String? frProjectName;
  String? toProjectName;
  String? frSiteName;
  dynamic reqOrdNo;
  String? matTransferReqNo;
  dynamic approveNo;
  dynamic createdName;
  dynamic materialName;
  dynamic scaleName;
  int? qty;
  int? approvedBy;
  String? approveStatus;
  String? approveDate;
  String? verifyStatus;
  int? verifyBy;
  String? verifyDate;
  List<dynamic>? materialTransLinks;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    transferId: json["id"],
    transferNo: json["transferNo"],
    fromProjectId: json["fromProjectId"],
    toProjectId: json["toProjectId"],
    fromSiteid: json["fromSiteid"],
    ackStatus: json["ackStatus"],
    matReqMasId: json["matReqMasId"],
    matTransReqMasId: json["matTransReqMasId"],
    remarks: json["remarks"],
    vehicleName: json["vehicleName"],
    driverName: json["driverName"],
    transportAmount: json["transportAmount"],
    totalAmount: json["totalAmount"],
    entryType: json["entryType"],
    entryName: json["entryName"],
    entryDate: json["entryDate"],
    dcNo: json["dcNo"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    frProjectName: json["frProjectName"],
    toProjectName: json["toProjectName"],
    frSiteName: json["frSiteName"],
    reqOrdNo: json["reqOrdNo"],
    matTransferReqNo: json["matTransferReqNo"],
    approveNo: json["approveNo"],
    createdName: json["createdName"],
    materialName: json["materialName"],
    scaleName: json["scaleName"],
    qty: json["qty"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDate: json["approveDate"],
    verifyStatus: json["verifyStatus"],
    verifyBy: json["verifyBy"],
    verifyDate: json["verifyDate"],
    materialTransLinks: json["materialTransLinks"] == null
        ? []
        : List<dynamic>.from(json["materialTransLinks"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": transferId,
    "transferNo": transferNo,
    "fromProjectId": fromProjectId,
    "toProjectId": toProjectId,
    "fromSiteid": fromSiteid,
    "ackStatus": ackStatus,
    "matReqMasId": matReqMasId,
    "matTransReqMasId": matTransReqMasId,
    "remarks": remarks,
    "vehicleName": vehicleName,
    "driverName": driverName,
    "transportAmount": transportAmount,
    "totalAmount": totalAmount,
    "entryType": entryType,
    "entryName": entryName,
    "entryDate": entryDate,
    "dcNo": dcNo,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "frProjectName": frProjectName,
    "toProjectName": toProjectName,
    "frSiteName": frSiteName,
    "reqOrdNo": reqOrdNo,
    "matTransferReqNo": matTransferReqNo,
    "approveNo": approveNo,
    "createdName": createdName,
    "materialName": materialName,
    "scaleName": scaleName,
    "qty": qty,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "approveDate": approveDate,
    "verifyStatus": verifyStatus,
    "verifyBy": verifyBy,
    "verifyDate": verifyDate,
    "materialTransLinks": materialTransLinks == null
        ? []
        : List<dynamic>.from(materialTransLinks!.map((x) => x)),
  };
}

