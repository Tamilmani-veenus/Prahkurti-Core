// To parse this JSON data, do
//
//     final transferbetSiteEditApiResmodel = transferbetSiteEditApiResmodelFromJson(jsonString);

// import 'dart:convert';
//
// TransferbetSiteEditApiResmodel transferbetSiteEditApiResmodelFromJson(String str) => TransferbetSiteEditApiResmodel.fromJson(json.decode(str));
//
// String transferbetSiteEditApiResmodelToJson(TransferbetSiteEditApiResmodel data) => json.encode(data.toJson());
//
// class TransferbetSiteEditApiResmodel {
//   bool? success;
//   String? message;
//   Result? result;
//
//   TransferbetSiteEditApiResmodel({
//     this.success,
//     this.message,
//     this.result,
//   });
//
//   factory TransferbetSiteEditApiResmodel.fromJson(Map<String, dynamic> json) => TransferbetSiteEditApiResmodel(
//     success: json["success"],
//     message: json["message"],
//     result: Result.fromJson(json["result"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "result": result!.toJson(),
//   };
// }
//
// class Result {
//   int? id;
//   String? transferNo;
//   String? entryDt;
//   int? fromSiteid;
//   int? toSiteId;
//   String? remarks;
//   int? fromProjectId;
//   int? subContractId;
//   int? transferType;
//   int? createdBy;
//   String? createdDt;
//   int? updatedBy;
//   String? updatedDt;
//   String? frProjectName;
//   String? frSiteName;
//   String? toSiteName;
//   String? subcontractName;
//   String? createdName;
//   List<MaterialSiteLink>? materialSiteLink;
//
//   Result({
//     this.id,
//     this.transferNo,
//     this.entryDt,
//     this.fromSiteid,
//     this.toSiteId,
//     this.remarks,
//     this.fromProjectId,
//     this.subContractId,
//     this.transferType,
//     this.createdBy,
//     this.createdDt,
//     this.updatedBy,
//     this.updatedDt,
//     this.frProjectName,
//     this.frSiteName,
//     this.toSiteName,
//     this.subcontractName,
//     this.createdName,
//     this.materialSiteLink,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     id: json["id"],
//     transferNo: json["transferNo"],
//     entryDt: json["entryDt"],
//     fromSiteid: json["fromSiteid"],
//     toSiteId: json["toSiteId"],
//     remarks: json["remarks"],
//     fromProjectId: json["fromProjectId"],
//     subContractId: json["subContractId"],
//     transferType: json["transferType"],
//     createdBy: json["createdBy"],
//     createdDt: json["createdDt"],
//     updatedBy: json["updatedBy"],
//     updatedDt: json["updatedDt"],
//     frProjectName: json["frProjectName"],
//     frSiteName: json["frSiteName"],
//     toSiteName: json["toSiteName"],
//     subcontractName: json["subcontractName"],
//     createdName: json["createdName"],
//     materialSiteLink: List<MaterialSiteLink>.from(json["materialSiteLink"].map((x) => MaterialSiteLink.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "transferNo": transferNo,
//     "entryDt": entryDt,
//     "fromSiteid": fromSiteid,
//     "toSiteId": toSiteId,
//     "remarks": remarks,
//     "fromProjectId": fromProjectId,
//     "subContractId": subContractId,
//     "transferType": transferType,
//     "createdBy": createdBy,
//     "createdDt": createdDt,
//     "updatedBy": updatedBy,
//     "updatedDt": updatedDt,
//     "frProjectName": frProjectName,
//     "frSiteName": frSiteName,
//     "toSiteName": toSiteName,
//     "subcontractName": subcontractName,
//     "createdName": createdName,
//     "materialSiteLink": List<dynamic>.from(materialSiteLink!.map((x) => x.toJson())),
//   };
// }
//
// class MaterialSiteLink {
//   int? id;
//   int? transferSiteId;
//   int? materialId;
//   double? qty;
//   double? rate;
//   double? amount;
//   String? materialName;
//   int? unitId;
//   String? unit;
//   double? stockQty;
//   double? balQty;
//   int? createdBy;
//   String? createdDt;
//   int? updatedBy;
//   String? updatedDt;
//
//   MaterialSiteLink({
//     this.id,
//     this.transferSiteId,
//     this.materialId,
//     this.qty,
//     this.rate,
//     this.amount,
//     this.materialName,
//     this.unitId,
//     this.unit,
//     this.stockQty,
//     this.balQty,
//     this.createdBy,
//     this.createdDt,
//     this.updatedBy,
//     this.updatedDt,
//   });
//
//   factory MaterialSiteLink.fromJson(Map<String, dynamic> json) => MaterialSiteLink(
//     id: json["id"],
//     transferSiteId: json["transferSiteId"],
//     materialId: json["materialId"],
//     qty: json["qty"],
//     rate: json["rate"],
//     amount: json["amount"],
//     materialName: json["materialName"],
//     unitId: json["unitID"],
//     unit: json["unitName"],
//     stockQty: json["stockQty"],
//     balQty: json["balQty"],
//     createdBy: json["createdBy"],
//     createdDt: json["createdDt"],
//     updatedBy: json["updatedBy"],
//     updatedDt: json["updatedDt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "transferSiteId": transferSiteId,
//     "materialId": materialId,
//     "qty": qty,
//     "rate": rate,
//     "amount": amount,
//     "materialName": materialName,
//     "unitID": unitId,
//     "unitName": unit,
//     "stockQty": stockQty,
//     "balQty": balQty,
//     "createdBy": createdBy,
//     "createdDt": createdDt,
//     "updatedBy": updatedBy,
//     "updatedDt": updatedDt,
//   };
// }



// To parse this JSON data, do
//
//     final transferbetSiteEditApiResmodel = transferbetSiteEditApiResmodelFromJson(jsonString);

import 'dart:convert';

TransferbetSiteEditApiResmodel transferbetSiteEditApiResmodelFromJson(String str) => TransferbetSiteEditApiResmodel.fromJson(json.decode(str));

String transferbetSiteEditApiResmodelToJson(TransferbetSiteEditApiResmodel data) => json.encode(data.toJson());

class TransferbetSiteEditApiResmodel {
  bool? success;
  String? message;
  List<Result>? result;

  TransferbetSiteEditApiResmodel({
    this.success,
    this.message,
    this.result,
  });

  factory TransferbetSiteEditApiResmodel.fromJson(Map<String, dynamic> json) => TransferbetSiteEditApiResmodel(
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
  String? projectName;
  String? toSiteName;
  String? fromSiteName;
  String? subcontractName;
  int? reqOrdMasId;
  String? employeeName;
  int? StSDetId;
  int? reqDetId;
  int? materialid;
  String? materialName;
  int? scaleId;
  String? scale;
  double? stockQty;
  double? qty;
  double? rate;
  double? amount;
  double? balqty;
  double? balqty1;

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
    this.toSiteName,
    this.fromSiteName,
    this.subcontractName,
    this.reqOrdMasId,
    this.employeeName,
    this.StSDetId,
    this.reqDetId,
    this.materialid,
    this.materialName,
    this.scaleId,
    this.scale,
    this.stockQty,
    this.qty,
    this.rate,
    this.amount,
    this.balqty,
    this.balqty1,
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
    projectName: json["ProjectName"],
    toSiteName: json["ToSiteName"],
    fromSiteName: json["FromSiteName"],
    subcontractName: json["subcontractName"],
    reqOrdMasId: json["ReqOrdMasId"],
    employeeName: json["EmployeeName"],
    StSDetId: json["StSDetId"],
    reqDetId: json["ReqOrdDetId"],
    materialid: json["Materialid"],
    materialName: json["MaterialName"],
    scaleId: json["ScaleID"],
    scale: json["ScaleName"],
    stockQty: json["stockQty"],
    qty: json["qty"],
    rate: json["Rate"],
    amount: json["Amount"],
    balqty: json["balqty"],
    balqty1: json["balqty1"],
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
    "ProjectName": projectName,
    "ToSiteName": toSiteName,
    "FromSiteName": fromSiteName,
    "subcontractName": subcontractName,
    "ReqOrdMasId": reqOrdMasId,
    "EmployeeName": employeeName,
    "StSDetId": StSDetId,
    "ReqOrdDetId": reqDetId,
    "Materialid": materialid,
    "MaterialName": materialName,
    "ScaleID": scaleId,
    "ScaleName": scale,
    "stockQty": stockQty,
    "qty": qty,
    "Rate": rate,
    "Amount": amount,
    "balqty": balqty,
    "balqty1": balqty1,
  };
}

