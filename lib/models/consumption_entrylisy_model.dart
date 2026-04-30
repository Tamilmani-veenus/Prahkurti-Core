// // To parse this JSON data, do
// //
// //     final consumptionentrylist = consumptionentrylistFromJson(jsonString);
//
// import 'dart:convert';
//
// List<Consumptionentrylist> consumptionentrylistFromJson(String str) => List<Consumptionentrylist>.from(json.decode(str).map((x) => Consumptionentrylist.fromJson(x)));
//
// String consumptionentrylistToJson(List<Consumptionentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Consumptionentrylist {
//   Consumptionentrylist({
//     this.expenseId,
//     this.expenseNo,
//     this.project,
//     this.site,
//     this.exdate,
//     this.entryType,
//     this.preparedByName,
//   });
//
//   int? expenseId;
//   String? expenseNo;
//   String? project;
//   String? site;
//   String? exdate;
//   String? entryType;
//   String? preparedByName;
//
//   factory Consumptionentrylist.fromJson(Map<String, dynamic> json) => Consumptionentrylist(
//     expenseId: json["Expense_id"],
//     expenseNo: json["Expense_No"],
//     project: json["Project"],
//     site: json["Site"],
//     exdate: json["Exdate"],
//     entryType: json["EntryType"],
//     preparedByName: json["PreparedByName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Expense_id": expenseId,
//     "Expense_No": expenseNo,
//     "Project": project,
//     "Site": site,
//     "Exdate": exdate,
//     "EntryType": entryType,
//     "PreparedByName": preparedByName,
//   };
// }


// To parse this JSON data, do
//
//     final materialExpenseList = materialExpenseListFromJson(jsonString);

import 'dart:convert';

MaterialExpenseList materialExpenseListFromJson(String str) =>
    MaterialExpenseList.fromJson(json.decode(str));

String materialExpenseListToJson(MaterialExpenseList data) =>
    json.encode(data.toJson());

class MaterialExpenseList {
  bool? success;
  String? message;
  List<Result>? result;

  MaterialExpenseList({
    this.success,
    this.message,
    this.result,
  });

  factory MaterialExpenseList.fromJson(Map<String, dynamic> json) =>
      MaterialExpenseList(
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    createdDt: json["createdDt"],
    updatedBy: json["updatedBy"],
    updatedDt: json["updatedDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContractName: json["subContractName"],
    createdName: json["createdName"],
    materialExpensesLink: json["materialExpensesLink"] == null
        ? []
        : List<MaterialExpensesLink>.from(
        json["materialExpensesLink"]
            .map((x) => MaterialExpensesLink.fromJson(x))),
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
    "materialExpensesLink": materialExpensesLink == null
        ? []
        : List<dynamic>.from(
        materialExpensesLink!.map((x) => x.toJson())),
  };
}

class MaterialExpensesLink {
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
    this.unitId,
    this.unitName,
    this.stockQty,
  });

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
  int? unitId;
  String? unitName;
  dynamic stockQty;

  factory MaterialExpensesLink.fromJson(Map<String, dynamic> json) =>
      MaterialExpensesLink(
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
        unitId: json["unitId"],
        unitName: json["unitName"],
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
    "unitId": unitId,
    "unitName": unitName,
    "stockQty": stockQty,
  };
}

