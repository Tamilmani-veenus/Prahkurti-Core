// To parse this JSON data, do
//
//     final dashboardResModel = dashboardResModelFromJson(jsonString);

import 'dart:convert';

List<DashboardResModel> dashboardResModelFromJson(String str) => List<DashboardResModel>.from(json.decode(str).map((x) => DashboardResModel.fromJson(x)));

String dashboardResModelToJson(List<DashboardResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardResModel {
  int? totalProjects;
  double? customerAmt;
  double? incomeAmt;
  double? expensesAmt;
  double? cashinHand;
  double? bankAmt;
  double? supplierAmt;
  double? subContAmt;

  DashboardResModel({
    this.totalProjects,
    this.customerAmt,
    this.incomeAmt,
    this.expensesAmt,
    this.cashinHand,
    this.bankAmt,
    this.supplierAmt,
    this.subContAmt,
  });

  factory DashboardResModel.fromJson(Map<String, dynamic> json) => DashboardResModel(
    totalProjects: json["TotalProjects"],
    customerAmt: json["CustomerAmt"].toDouble(),
    incomeAmt: json["IncomeAmt"].toDouble(),
    expensesAmt: json["ExpensesAmt"],
    cashinHand: json["CashinHand"].toDouble(),
    bankAmt: json["BankAmt"].toDouble(),
    supplierAmt: json["SupplierAmt"],
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
