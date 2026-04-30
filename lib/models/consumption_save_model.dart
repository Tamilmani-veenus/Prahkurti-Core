// To parse this JSON data, do
//
//     final conumSaveRequest = conumSaveRequestFromJson(jsonString);

import 'dart:convert';

ConumSaveRequest conumSaveRequestFromJson(String str) => ConumSaveRequest.fromJson(json.decode(str));

String conumSaveRequestToJson(ConumSaveRequest data) => json.encode(data.toJson());

class ConumSaveRequest {
  int? id;
  String? entryDt;
  String? expenseNo;
  int? projectid;
  int? siteid;
  String? remarks;
  int? subContractId;
  String? expenseType;
  int? createdBy;
  String? createdDt;
  int? updatedBy;
  String? updatedDt;
  List<ConsumptionDet>? consumptionDet;

  ConumSaveRequest({
    this.id,
    this.entryDt,
    this.expenseNo,
    this.projectid,
    this.siteid,
    this.remarks,
    this.subContractId,
    this.expenseType,
    this.createdBy,
    this.createdDt,
    this.updatedBy,
    this.updatedDt,
    this.consumptionDet,
  });

  factory ConumSaveRequest.fromJson(Map<String, dynamic> json) =>
      ConumSaveRequest(
        id: json["id"],
        entryDt: json["entryDt"],
        expenseNo: json["expenseNo"],
        projectid: json["projectid"],
        siteid: json["siteid"],
        remarks: json["remarks"],
        subContractId: json["subContractId"],
        expenseType: json["expenseType"],
        createdBy: json["createdBy"],
        createdDt: json["createdDt"],
        updatedBy: json["updatedBy"],
        updatedDt: json["updatedDt"],
        consumptionDet: List<ConsumptionDet>.from(
            json["materialExpensesLink"].map((x) =>
                ConsumptionDet.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    final data = {
      "id": id,
      "entryDt": entryDt,
      "expenseNo": expenseNo,
      "projectid": projectid,
      "siteid": siteid,
      "remarks": remarks,
      "subContractId": subContractId,
      "expenseType": expenseType,
      "createdBy": createdBy,
      "createdDt": createdDt,
      "updatedBy": updatedBy,
      "updatedDt": updatedDt,
      "materialExpensesLink": List<dynamic>.from(
          consumptionDet!.map((x) => x!.toJson())),
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

class ConsumptionDet {
  int? id;
  int? expenseId;
  int? materialId;
  double? qty;
  int? rate;
  String? remarks;
  int? unitId;
  double? stockQty;

  ConsumptionDet({
    this.id,
    this.expenseId,
    this.materialId,
    this.qty,
    this.rate,
    this.remarks,
    this.unitId,
    this.stockQty,
  });

  factory ConsumptionDet.fromJson(Map<String, dynamic> json) => ConsumptionDet(
    id: json["id"],
    expenseId: json["expenseId"],
    materialId: json["materialId"],
    qty: json["qty"],
    rate: json["rate"],
    remarks: json["remarks"],
    unitId: json["unitID"],
    stockQty: json["stockQty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "expenseId": expenseId,
    "materialId": materialId,
    "qty": qty,
    "rate": rate,
    "remarks": remarks,
    "unitID": unitId,
    "stockQty": stockQty,
  };
}
