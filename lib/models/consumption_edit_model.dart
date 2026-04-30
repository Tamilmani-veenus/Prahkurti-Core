// To parse this JSON data, do
//
//     final conumEditResponse = conumEditResponseFromJson(jsonString);

import 'dart:convert';

ConumEditResponse conumEditResponseFromJson(String str) => ConumEditResponse.fromJson(json.decode(str));

String conumEditResponseToJson(ConumEditResponse data) => json.encode(data.toJson());

class ConumEditResponse {
  bool? success;
  String? message;
  ConsumEditResult? result;

  ConumEditResponse({
    this.success,
    this.message,
    this.result,
  });

  factory ConumEditResponse.fromJson(Map<String, dynamic> json) => ConumEditResponse(
    success: json["success"],
    message: json["message"],
    result: ConsumEditResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class ConsumEditResult {
  int? id;
  String? entryDt;
  String? expenseNo;
  int? projectid;
  int? siteid;
  String? remarks;
  int? subContractId;
  String? expenseType;
  String? expenseName;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;
  String? projectName;
  String? siteName;
  String? subContractName;
  String? createdName;
  List<MaterialExpensesLink>? materialExpensesLink;

  ConsumEditResult({
    this.id,
    this.entryDt,
    this.expenseNo,
    this.projectid,
    this.siteid,
    this.remarks,
    this.subContractId,
    this.expenseType,
    this.expenseName,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
    this.projectName,
    this.siteName,
    this.subContractName,
    this.createdName,
    this.materialExpensesLink,
  });

  factory ConsumEditResult.fromJson(Map<String, dynamic> json) => ConsumEditResult(
    id: json["id"],
    entryDt: json["entryDt"],
    expenseNo: json["expenseNo"],
    projectid: json["projectid"],
    siteid: json["siteid"],
    remarks: json["remarks"],
    subContractId: json["subContractId"],
    expenseType: json["expenseType"],
    expenseName: json["expenseName"],
    createdBy: json["createdBy"],
    createdDt:json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractName: json["subContractName"],
    createdName: json["createdName"],
    materialExpensesLink: List<MaterialExpensesLink>.from(json["materialExpensesLink"].map((x) => MaterialExpensesLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entryDt": entryDt,
    "expenseNo": expenseNo,
    "projectid": projectid,
    "siteid": siteid,
    "remarks": remarks,
    "subContractId": subContractId,
    "expenseType": expenseType,
    "expenseName": expenseName,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
    "projectName": projectName,
    "siteName": siteName,
    "subContractName": subContractName,
    "createdName": createdName,
    "materialExpensesLink": List<dynamic>.from(materialExpensesLink!.map((x) => x.toJson())),
  };
}

class MaterialExpensesLink {
  int? id;
  int? expenseId;
  int? materialId;
  double? qty;
  double? rate;
  String? remarks;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;
  String? materialName;
  int? scaleId;
  String? unit;
  double? stockQty;

  MaterialExpensesLink({
    this.id,
    this.expenseId,
    this.materialId,
    this.qty,
    this.rate,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
    this.materialName,
    this.scaleId,
    this.unit,
    this.stockQty,
  });

  factory MaterialExpensesLink.fromJson(Map<String, dynamic> json) => MaterialExpensesLink(
    id: json["id"],
    expenseId: json["expenseId"],
    materialId: json["materialId"],
    qty: json["qty"],
    rate: json["rate"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    materialName: json["materialName"],
    scaleId: json["unitID"],
    unit: json["unitName"],
    stockQty: json["stockQty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "expenseId": expenseId,
    "materialId": materialId,
    "qty": qty,
    "rate": rate,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "updatedBy": updatedBy,
    "updatedDt": updatedDt,
    "materialName": materialName,
    "unitID": scaleId,
    "unitName": unit,
    "stockQty": stockQty,
  };
}
