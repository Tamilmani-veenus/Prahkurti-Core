// To parse this JSON data, do
//
//     final materialDashProjectWise = materialDashProjectWiseFromJson(jsonString);

import 'dart:convert';

MaterialDashProjectWise materialDashProjectWiseFromJson(String str) => MaterialDashProjectWise.fromJson(json.decode(str));

String materialDashProjectWiseToJson(MaterialDashProjectWise data) => json.encode(data.toJson());

class MaterialDashProjectWise {
  bool? success;
  Result? result;
  List<BillingCompletion>? billingCompletion;
  List<ProjectComparison>? projectComparison;
  List<PoVsBillReg>? poVsBillReg;

  MaterialDashProjectWise({
    this.success,
    this.result,
    this.billingCompletion,
    this.projectComparison,
    this.poVsBillReg,
  });

  factory MaterialDashProjectWise.fromJson(Map<String, dynamic> json) => MaterialDashProjectWise(
    success: json["success"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
    billingCompletion: json["billingCompletion"]==null?[]:List<BillingCompletion>.from(json["billingCompletion"].map((x) => BillingCompletion.fromJson(x))),
    projectComparison: json["projectComparison"]==null?[]:List<ProjectComparison>.from(json["projectComparison"].map((x) => ProjectComparison.fromJson(x))),
    poVsBillReg: json["poVsBillReg"]==null?[]:List<PoVsBillReg>.from(json["poVsBillReg"].map((x) => PoVsBillReg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
    "billingCompletion": List<dynamic>.from(billingCompletion!.map((x) => x.toJson())),
    "projectComparison": List<dynamic>.from(projectComparison!.map((x) => x.toJson())),
    "poVsBillReg": List<dynamic>.from(poVsBillReg!.map((x) => x.toJson())),
  };
}

class BillingCompletion {
  String? projectName;
  double? billingCompletionPercentage;

  BillingCompletion({
   this.projectName,
   this.billingCompletionPercentage,
  });

  factory BillingCompletion.fromJson(Map<String, dynamic> json) => BillingCompletion(
    projectName: json["projectName"],
    billingCompletionPercentage: json["billingCompletionPercentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "billingCompletionPercentage": billingCompletionPercentage,
  };
}

class PoVsBillReg {
  String? projectName;
  String? address;
  int? totalPos;
  double? poAmountInLakhs;
  double? billAmountInLakhs;
  dynamic approvedAmountInLakhs;
  dynamic unbilledAmountInLakhs;
  double? overBillAmountInLakhs;
  double? billingPercentage;
  String? billingStatus;

  PoVsBillReg({
    this.projectName,
    this.address,
    this.totalPos,
    this.poAmountInLakhs,
    this.billAmountInLakhs,
    this.approvedAmountInLakhs,
    this.unbilledAmountInLakhs,
    this.overBillAmountInLakhs,
    this.billingPercentage,
    this.billingStatus,
  });

  factory PoVsBillReg.fromJson(Map<String, dynamic> json) => PoVsBillReg(
    projectName: json["projectName"],
    address: json["address"],
    totalPos: json["totalPos"],
    poAmountInLakhs: json["poAmountInLakhs"]?.toDouble(),
    billAmountInLakhs: json["billAmountInLakhs"]?.toDouble(),
    approvedAmountInLakhs: json["approvedAmountInLakhs"],
    unbilledAmountInLakhs: json["unbilledAmountInLakhs"]?.toDouble(),
    overBillAmountInLakhs: json["overBillAmountInLakhs"]?.toDouble(),
    billingPercentage: json["billingPercentage"]?.toDouble(),
    billingStatus: json["billingStatus"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "address": address,
    "totalPos": totalPos,
    "poAmountInLakhs": poAmountInLakhs,
    "billAmountInLakhs": billAmountInLakhs,
    "approvedAmountInLakhs": approvedAmountInLakhs,
    "unbilledAmountInLakhs": unbilledAmountInLakhs,
    "overBillAmountInLakhs": overBillAmountInLakhs,
    "billingPercentage": billingPercentage,
    "billingStatus": billingStatus,
  };
}

class ProjectComparison {
  String? projectName;
  String? poAmountInLakhs;
  String? billAmountInLakhs;

  ProjectComparison({
    this.projectName,
    this.poAmountInLakhs,
    this.billAmountInLakhs,
  });

  factory ProjectComparison.fromJson(Map<String, dynamic> json) => ProjectComparison(
    projectName: json["projectName"],
    poAmountInLakhs: json["poAmountInLakhs"],
    billAmountInLakhs: json["billAmountInLakhs"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "poAmountInLakhs": poAmountInLakhs,
    "billAmountInLakhs": billAmountInLakhs,
  };
}

class Result {
  String? poTotalValue;
  int? activeprojectCounts;
  int? activeSuppliers;
  int? activeMaterialHeads;
  String? totalBillApproved;
  String? totalBillPending;
  String? totalBilledAmount;
  String? unBilledAmount;
  String? overBilledAmount;
  int? projectCountOverBiller;
  int? overBilledProjects;

  Result({
    this.poTotalValue,
    this.activeprojectCounts,
    this.activeSuppliers,
    this.activeMaterialHeads,
    this.totalBillApproved,
    this.totalBillPending,
    this.totalBilledAmount,
    this.unBilledAmount,
    this.overBilledAmount,
    this.projectCountOverBiller,
    this.overBilledProjects,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    poTotalValue: json["poTotalValue"],
    activeprojectCounts: json["activeprojectCounts"],
    activeSuppliers: json["activeSuppliers"],
    activeMaterialHeads: json["activeMaterialHeads"],
    totalBillApproved: json["totalBillApproved"],
    totalBillPending: json["totalBillPending"],
    totalBilledAmount: json["totalBilledAmount"],
    unBilledAmount: json["unBilledAmount"],
    overBilledAmount: json["overBilledAmount"],
    projectCountOverBiller: json["projectCountOverBiller"],
    overBilledProjects: json["overBilledProjects"],
  );

  Map<String, dynamic> toJson() => {
    "poTotalValue": poTotalValue,
    "activeprojectCounts": activeprojectCounts,
    "activeSuppliers": activeSuppliers,
    "activeMaterialHeads": activeMaterialHeads,
    "totalBillApproved": totalBillApproved,
    "totalBillPending": totalBillPending,
    "totalBilledAmount": totalBilledAmount,
    "unBilledAmount": unBilledAmount,
    "overBilledAmount": overBilledAmount,
    "projectCountOverBiller": projectCountOverBiller,
    "overBilledProjects": overBilledProjects,
  };
}
