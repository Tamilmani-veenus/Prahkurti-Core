// To parse this JSON data, do
//
//     final adminDashboardResponse = adminDashboardResponseFromJson(jsonString);

import 'dart:convert';

AdminDashboardResponse adminDashboardResponseFromJson(String str) => AdminDashboardResponse.fromJson(json.decode(str));

String adminDashboardResponseToJson(AdminDashboardResponse data) => json.encode(data.toJson());

class AdminDashboardResponse {
  bool? success;
  Result? result;
  List<PoVsbillTable>? poVsbillTable;
  List<BudgetVsSpend>? budgetVsSpend;
  List<ProjectCompletion>? projectCompletion;
  String? budgetUsed;
  ExpenseCategoryMix? expenseCategoryMix;
  List<BoqProgress>? boqProgress;

  AdminDashboardResponse({
    this.success,
    this.result,
    this.poVsbillTable,
    this.budgetVsSpend,
    this.projectCompletion,
    this.budgetUsed,
    this.expenseCategoryMix,
    this.boqProgress,
  });

  factory AdminDashboardResponse.fromJson(Map<String, dynamic> json) => AdminDashboardResponse(
    success: json["success"],
    result: Result.fromJson(json["result"]),
    poVsbillTable: json["poVsbillTable"]==null?[]:List<PoVsbillTable>.from(json["poVsbillTable"].map((x) => PoVsbillTable.fromJson(x))),
    budgetVsSpend: json["budgetVsSpend"]==null?[]:List<BudgetVsSpend>.from(json["budgetVsSpend"].map((x) => BudgetVsSpend.fromJson(x))),
    projectCompletion: json["projectCompletion"]==null?[]:List<ProjectCompletion>.from(json["projectCompletion"].map((x) => ProjectCompletion.fromJson(x))),
    budgetUsed: json["budgetUsed"],
    expenseCategoryMix: ExpenseCategoryMix.fromJson(json["expenseCategoryMix"]),
    boqProgress: json["boqProgress"]==null?[]:List<BoqProgress>.from(json["boqProgress"].map((x) => BoqProgress.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
    "poVsbillTable": List<dynamic>.from(poVsbillTable!.map((x) => x.toJson())),
    "budgetVsSpend": List<dynamic>.from(budgetVsSpend!.map((x) => x.toJson())),
    "projectCompletion": List<dynamic>.from(projectCompletion!.map((x) => x.toJson())),
    "budgetUsed": budgetUsed,
    "expenseCategoryMix": expenseCategoryMix!.toJson(),
    "boqProgress": List<dynamic>.from(boqProgress!.map((x) => x.toJson())),
  };
}

class BoqProgress {
  int? projectId;
  String? projectName;
  String? boqValue;
  double? plannedPercentage;
  double? actualPercentage;
  String? progress;
  String? status;
  String? endDate;
  String? startDate;

  BoqProgress({
   this.projectId,
   this.projectName,
   this.boqValue,
   this.plannedPercentage,
   this.actualPercentage,
   this.progress,
   this.status,
   this.endDate,
   this.startDate,
  });

  factory BoqProgress.fromJson(Map<String, dynamic> json) => BoqProgress(
    projectId: json["projectId"],
    projectName: json["projectName"],
    boqValue: json["boqValue"],
    plannedPercentage: json["plannedPercentage"]?.toDouble(),
    actualPercentage: json["actualPercentage"]?.toDouble(),
    progress: json["progress"],
    status: json["status"],
    endDate: json["endDate"],
    startDate: json["startDate"],
  );

  Map<String, dynamic> toJson() => {
    "projectId": projectId,
    "projectName": projectName,
    "boqValue": boqValue,
    "plannedPercentage": plannedPercentage,
    "actualPercentage": actualPercentage,
    "progress": progress,
    "status": status,
    "endDate": endDate,
    "startDate": startDate,
  };
}

class BudgetVsSpend {
  int? projectId;
  String? projectName;
  String? budget;
  String? spent;

  BudgetVsSpend({
    this.projectId,
    this.projectName,
    this.budget,
    this.spent,
  });

  factory BudgetVsSpend.fromJson(Map<String, dynamic> json) => BudgetVsSpend(
    projectId: json["projectId"],
    projectName: json["projectName"],
    budget: json["budget"],
    spent: json["spent"],
  );

  Map<String, dynamic> toJson() => {
    "projectId": projectId,
    "projectName": projectName,
    "budget": budget,
    "spent": spent,
  };
}

class ExpenseCategoryMix {
  Material? material;
  Material? nmrWorkAmount;
  Material? rateWorkAmount;
  Material? mis;
  Material? siteMaterialExpense;
  TotalExpense? totalExpense;

  ExpenseCategoryMix({
    this.material,
    this.nmrWorkAmount,
    this.rateWorkAmount,
    this.mis,
    this.siteMaterialExpense,
    this.totalExpense,
  });

  factory ExpenseCategoryMix.fromJson(Map<String, dynamic> json) => ExpenseCategoryMix(
    material: Material.fromJson(json["material"]),
    nmrWorkAmount: Material.fromJson(json["nmrWorkAmount"]),
    rateWorkAmount: Material.fromJson(json["rateWorkAmount"]),
    mis: Material.fromJson(json["mis"]),
    siteMaterialExpense: Material.fromJson(json["siteMaterialExpense"]),
    totalExpense: TotalExpense.fromJson(json["totalExpense"]),
  );

  Map<String, dynamic> toJson() => {
    "material": material!.toJson(),
    "nmrWorkAmount": nmrWorkAmount!.toJson(),
    "rateWorkAmount": rateWorkAmount!.toJson(),
    "mis": mis!.toJson(),
    "siteMaterialExpense": siteMaterialExpense!.toJson(),
    "totalExpense": totalExpense!.toJson(),
  };
}

class Material {
  String? amount;
  double? percentage;

  Material({
    this.amount,
    this.percentage,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
    amount: json["amount"],
    percentage: json["percentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "percentage": percentage,
  };
}

class TotalExpense {
  dynamic totalExpenseAmount;

  TotalExpense({
     this.totalExpenseAmount,
  });

  factory TotalExpense.fromJson(Map<String, dynamic> json) => TotalExpense(
    totalExpenseAmount: json["totalExpenseAmount"],
  );

  Map<String, dynamic> toJson() => {
    "totalExpenseAmount": totalExpenseAmount,
  };
}

class PoVsbillTable {
  String? projectName;
  int? totalPOs;
  String? poValue;
  String? billValue;
  String? billingPercent;
  String? variance;
  String? varianceLabel;

  PoVsbillTable({
   this.projectName,
   this.totalPOs,
   this.poValue,
   this.billValue,
   this.billingPercent,
   this.variance,
   this.varianceLabel,
  });

  factory PoVsbillTable.fromJson(Map<String, dynamic> json) => PoVsbillTable(
    projectName: json["projectName"],
    totalPOs: json["totalPOs"],
    poValue: json["poValue"],
    billValue: json["billValue"],
    billingPercent: json["billingPercent"],
    variance: json["variance"],
    varianceLabel: json["varianceLabel"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "totalPOs": totalPOs,
    "poValue": poValue,
    "billValue": billValue,
    "billingPercent": billingPercent,
    "variance": variance,
    "varianceLabel": varianceLabel,
  };
}

class ProjectCompletion {
  int? projectId;
  String? projectName;
  double? totalBoqQty;
  double? totalExecutedQty;
  double? completionPercentage;

  ProjectCompletion({
    this.projectId,
    this.projectName,
    this.totalBoqQty,
    this.totalExecutedQty,
    this.completionPercentage,
  });

  factory ProjectCompletion.fromJson(Map<String, dynamic> json) => ProjectCompletion(
    projectId: json["projectId"],
    projectName: json["projectName"],
    totalBoqQty: json["totalBOQQty"]?.toDouble(),
    totalExecutedQty: json["totalExecutedQty"]?.toDouble(),
    completionPercentage: json["completionPercentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "projectId": projectId,
    "projectName": projectName,
    "totalBOQQty": totalBoqQty,
    "totalExecutedQty": totalExecutedQty,
    "completionPercentage": completionPercentage,
  };
}

class Result {
  int? activeProjects;
  String? totalOutStandingSupplier;
  String? totalOutStandingSubcont;
  String? totalExpense;
  String? totalCashInBank;
  String? totalCashInHand;

  Result({
    this.activeProjects,
    this.totalOutStandingSupplier,
    this.totalOutStandingSubcont,
    this.totalExpense,
    this.totalCashInBank,
    this.totalCashInHand,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    activeProjects: json["activeProjects"],
    totalOutStandingSupplier: json["totalOutStandingSupplier"],
    totalOutStandingSubcont: json["totalOutStandingSubcont"],
    totalExpense: json["totalExpense"],
    totalCashInBank: json["totalCashInBank"],
    totalCashInHand: json["totalCashInHand"],
  );

  Map<String, dynamic> toJson() => {
    "activeProjects": activeProjects,
    "totalOutStandingSupplier": totalOutStandingSupplier,
    "totalOutStandingSubcont": totalOutStandingSubcont,
    "totalExpense": totalExpense,
    "totalCashInBank": totalCashInBank,
    "totalCashInHand": totalCashInHand,
  };
}
