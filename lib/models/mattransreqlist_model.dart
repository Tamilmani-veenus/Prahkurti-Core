import 'dart:convert';

MatTransferListResponse matTransferListResponseFromJson(String str) =>
    MatTransferListResponse.fromJson(json.decode(str));

String matTransferListResponseToJson(MatTransferListResponse data) =>
    json.encode(data.toJson());

class MatTransferListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  MatTransferListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory MatTransferListResponse.fromJson(Map<String, dynamic> json) =>
      MatTransferListResponse(
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
    this.siteName,
    this.toProjectName,
    this.fromProjectName,
    this.status,
    this.createdName,
    this.approvedName,
    this.verifedName,
    this.materialTransferRequestDets,
  });

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
  String? siteName;
  String? toProjectName;
  String? fromProjectName;
  String? status;
  String? createdName;
  String? approvedName;
  String? verifedName;
  dynamic materialTransferRequestDets;

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
    verifyDate: json["verifyDate"],
    approveStatus: json["approveStatus"],
    approvedBy: json["approvedBy"],
    approveDate: json["approveDate"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    siteName: json["siteName"],
    toProjectName: json["toProjectName"],
    fromProjectName: json["fromProjectName"],
    status: json["status"],
    createdName: json["createdName"],
    approvedName: json["approvedName"],
    verifedName: json["verifedName"],
    materialTransferRequestDets: json["materialTransferRequestDets"],
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
    "verifyDate": verifyDate,
    "approveStatus": approveStatus,
    "approvedBy": approvedBy,
    "approveDate": approveDate,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "siteName": siteName,
    "toProjectName": toProjectName,
    "fromProjectName": fromProjectName,
    "status": status,
    "createdName": createdName,
    "approvedName": approvedName,
    "verifedName": verifedName,
    "materialTransferRequestDets": materialTransferRequestDets,
  };
}
