// To parse this JSON data, do
//
//     final dashboardResModel = dashboardResModelFromJson(jsonString);

import 'dart:convert';

DashboardResModel dashboardResModelFromJson(String str) => DashboardResModel.fromJson(json.decode(str));

String dashboardResModelToJson(DashboardResModel data) => json.encode(data.toJson());

class DashboardResModel {
  bool? success;
  Result? result;
  String? message;

  DashboardResModel({
    this.success,
    this.result,
    this.message,
  });

  factory DashboardResModel.fromJson(Map<String, dynamic> json) => DashboardResModel(
    success: json["success"],
    result: Result.fromJson(json["result"]),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
    "message": message
  };
}

class Result {
  int? totalProjects;
  double? customerAmt;
  double? incomeAmt;
  double? expensesAmt;
  double? cashinHand;
  double? bankAmt;
  double? supplierAmt;
  double? subContAmt;

  Result({
    this.totalProjects,
    this.customerAmt,
    this.incomeAmt,
    this.expensesAmt,
    this.cashinHand,
    this.bankAmt,
    this.supplierAmt,
    this.subContAmt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalProjects: json["TotalProjects"],
    customerAmt: json["CustomerAmt"],
    incomeAmt: json["IncomeAmt"],
    expensesAmt: json["ExpensesAmt"],
    cashinHand: json["CashinHand"].toDouble(),
    bankAmt: json["BankAmt"],
    supplierAmt: json["SupplierAmt"].toDouble(),
    subContAmt: json["SubContAmt"],
  );

  Map<String, dynamic> toJson() => {
    "TotalProjects": totalProjects,
    "CustomerAmt": customerAmt,
    "IncomeAmt": incomeAmt,
    "ExpensesAmt": expensesAmt,
    "CashinHand": cashinHand,
    "BankAmt": bankAmt,
    "SupplierAmt": supplierAmt,
    "SubContAmt": subContAmt,
  };
}
