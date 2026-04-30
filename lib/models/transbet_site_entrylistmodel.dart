import 'dart:convert';

GetTransferSiteListResponse getTransferSiteListResponseFromJson(String str) =>
    GetTransferSiteListResponse.fromJson(json.decode(str));

String getTransferSiteListResponseToJson(GetTransferSiteListResponse data) =>
    json.encode(data.toJson());

class GetTransferSiteListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  GetTransferSiteListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory GetTransferSiteListResponse.fromJson(Map<String, dynamic> json) =>
      GetTransferSiteListResponse(
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
    this.entryDt,
    this.fromSiteid,
    this.toSiteId,
    this.remarks,
    this.fromProjectId,
    this.subContractId,
    this.transferType,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
    this.frProjectName,
    this.frSiteName,
    this.toSiteName,
    this.subcontractName,
    this.createdName,
    this.materialSiteLink,
  });

  int? id;
  String? transferNo;
  String? entryDt;
  int? fromSiteid;
  int? toSiteId;
  String? remarks;
  int? fromProjectId;
  int? subContractId;
  int? transferType;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;
  String? frProjectName;
  String? frSiteName;
  String? toSiteName;
  String? subcontractName;
  String? createdName;
  List<MaterialSiteLink>? materialSiteLink;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    transferNo: json["transferNo"],
    entryDt: json["entryDt"],
    fromSiteid: json["fromSiteid"],
    toSiteId: json["toSiteId"],
    remarks: json["remarks"],
    fromProjectId: json["fromProjectId"],
    subContractId: json["subContractId"],
    transferType: json["transferType"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    frProjectName: json["frProjectName"],
    frSiteName: json["frSiteName"],
    toSiteName: json["toSiteName"],
    subcontractName: json["subcontractName"],
    createdName: json["createdName"],
    materialSiteLink: json["materialSiteLink"] == null
        ? []
        : List<MaterialSiteLink>.from(
        json["materialSiteLink"]
            .map((x) => MaterialSiteLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transferNo": transferNo,
    "entryDt": entryDt,
    "fromSiteid": fromSiteid,
    "toSiteId": toSiteId,
    "remarks": remarks,
    "fromProjectId": fromProjectId,
    "subContractId": subContractId,
    "transferType": transferType,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
    "frProjectName": frProjectName,
    "frSiteName": frSiteName,
    "toSiteName": toSiteName,
    "subcontractName": subcontractName,
    "createdName": createdName,
    "materialSiteLink": materialSiteLink == null
        ? []
        : List<dynamic>.from(
        materialSiteLink!.map((x) => x.toJson())),
  };
}

class MaterialSiteLink {
  MaterialSiteLink({
    this.id,
    this.transferSiteId,
    this.materialId,
    this.qty,
    this.rate,
    this.amount,
    this.materialName,
    this.unitId,
    this.unitName,
    this.stockQty,
    this.balQty,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
  });

  int? id;
  int? transferSiteId;
  int? materialId;
  double? qty;
  double? rate;
  double? amount;
  String? materialName;
  int? unitId;
  String? unitName;
  dynamic stockQty;
  dynamic balQty;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;

  factory MaterialSiteLink.fromJson(Map<String, dynamic> json) =>
      MaterialSiteLink(
        id: json["id"],
        transferSiteId: json["transferSiteId"],
        materialId: json["materialId"],
        qty: json["qty"],
        rate: json["rate"],
        amount: json["amount"],
        materialName: json["materialName"],
        unitId: json["unitId"],
        unitName: json["unitName"],
        stockQty: json["stockQty"],
        balQty: json["balQty"],
        createdBy: json["createdBy"],
        createdDt: json["createdDt"],
        updatedBy: json["updatedBy"],
        updatedDt: json["updatedDt"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transferSiteId": transferSiteId,
    "materialId": materialId,
    "qty": qty,
    "rate": rate,
    "amount": amount,
    "materialName": materialName,
    "unitId": unitId,
    "unitName": unitName,
    "stockQty": stockQty,
    "balQty": balQty,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
  };
}
