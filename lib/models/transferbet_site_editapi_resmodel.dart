import 'dart:convert';

TransferbetSiteEditApiResmodel transferbetSiteEditApiResmodelFromJson(
    String str) =>
    TransferbetSiteEditApiResmodel.fromJson(json.decode(str));

String transferbetSiteEditApiResmodelToJson(
    TransferbetSiteEditApiResmodel data) =>
    json.encode(data.toJson());

class TransferbetSiteEditApiResmodel {
  bool? success;
  String? message;
  Result? result;

  TransferbetSiteEditApiResmodel({
    this.success,
    this.message,
    this.result,
  });

  factory TransferbetSiteEditApiResmodel.fromJson(
      Map<String, dynamic> json) =>
      TransferbetSiteEditApiResmodel(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? null
            : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  int? id;
  String? transferNo;
  String? entryDt;

  // Existing names
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

  String? projectName;
  String? fromSiteName;
  String? toSiteName;
  String? subcontractName;
  String? createdName;

  int? reqOrdMasId;

  // Existing detail list
  List<MaterialSiteLink>? materialSiteLink;

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
    this.projectName,
    this.fromSiteName,
    this.toSiteName,
    this.subcontractName,
    this.createdName,
    this.reqOrdMasId,
    this.materialSiteLink,
  });

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

    // NEW API -> EXISTING PROPERTY
    projectName: json["frProjectName"],
    fromSiteName: json["frSiteName"],
    toSiteName: json["toSiteName"],
    subcontractName: json["subcontractName"],
    createdName: json["createdName"],

    reqOrdMasId: json["reqOrdMasId"],

    materialSiteLink: json["materialSiteLink"] == null
        ? []
        : List<MaterialSiteLink>.from(
      json["materialSiteLink"].map(
            (x) => MaterialSiteLink.fromJson(x),
      ),
    ),
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

    "frProjectName": projectName,
    "frSiteName": fromSiteName,
    "toSiteName": toSiteName,
    "subcontractName": subcontractName,
    "createdName": createdName,

    "reqOrdMasId": reqOrdMasId,

    "materialSiteLink": materialSiteLink == null
        ? []
        : List<dynamic>.from(
      materialSiteLink!.map((x) => x.toJson()),
    ),
  };
}

class MaterialSiteLink {
  int? id;
  int? transferSiteId;
  int? materialId;
  double? qty;
  double? rate;
  double? amount;
  String? materialName;
  int? unitId;
  String? unitName;
  double? stockQty;
  double? balQty;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;
  int? reqOrdDetId;

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
    this.reqOrdDetId,
  });

  factory MaterialSiteLink.fromJson(Map<String, dynamic> json) => MaterialSiteLink(
    id: json["id"],
    transferSiteId: json["transferSiteId"],
    materialId: json["materialId"],
    qty: json["qty"],
    rate: json["rate"],
    amount: json["amount"],
    materialName: json["materialName"],
    unitId: json["unitID"],
    unitName: json["unitName"],
    stockQty: json["stockQty"],
    balQty: json["balQty"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    reqOrdDetId: json["reqOrdDetId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transferSiteId": transferSiteId,
    "materialId": materialId,
    "qty": qty,
    "rate": rate,
    "amount": amount,
    "materialName": materialName,
    "unitID": unitId,
    "unitName": unitName,
    "stockQty": stockQty,
    "balQty": balQty,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
    "reqOrdDetId": reqOrdDetId,
  };
}