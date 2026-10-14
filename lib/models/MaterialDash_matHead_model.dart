// To parse this JSON data, do
//
//     final materialDashMatHead = materialDashMatHeadFromJson(jsonString);

import 'dart:convert';

MaterialDashMatHead materialDashMatHeadFromJson(String str) => MaterialDashMatHead.fromJson(json.decode(str));

String materialDashMatHeadToJson(MaterialDashMatHead data) => json.encode(data.toJson());

class MaterialDashMatHead {
  bool? success;
  Result? result;
  List<PoVsBillChartValue>? poVsBillChartValues;
  List<PoVsbillTable>? poVsbillTable;
  List<SpendDistribution>? spendDistribution;
  String? overallTotalspendDistributioncount;

  MaterialDashMatHead({
    this.success,
    this.result,
    this.poVsBillChartValues,
    this.poVsbillTable,
    this.spendDistribution,
    this.overallTotalspendDistributioncount,
  });

  factory MaterialDashMatHead.fromJson(Map<String, dynamic> json) => MaterialDashMatHead(
    success: json["success"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
    poVsBillChartValues: json["poVsBillChartValues"]==null?[]:List<PoVsBillChartValue>.from(json["poVsBillChartValues"].map((x) => PoVsBillChartValue.fromJson(x))),
    poVsbillTable: json["poVsbillTable"]==null?[]:List<PoVsbillTable>.from(json["poVsbillTable"].map((x) => PoVsbillTable.fromJson(x))),
    spendDistribution: json["spendDistribution"]==null?[]:List<SpendDistribution>.from(json["spendDistribution"].map((x) => SpendDistribution.fromJson(x))),
    overallTotalspendDistributioncount: json["overallTotalspendDistributioncount"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
    "poVsBillChartValues": List<dynamic>.from(poVsBillChartValues!.map((x) => x.toJson())),
    "poVsbillTable": List<dynamic>.from(poVsbillTable!.map((x) => x.toJson())),
    "spendDistribution": List<dynamic>.from(spendDistribution!.map((x) => x.toJson())),
    "overallTotalspendDistributioncount": overallTotalspendDistributioncount,
  };
}

class PoVsBillChartValue {
  String? materialHeadName;
  String? totalPoAmount;
  String? totalBillAmount;
  String? varianceLabel;

  PoVsBillChartValue({
    this.materialHeadName,
    this.totalPoAmount,
    this.totalBillAmount,
    this.varianceLabel,
  });

  factory PoVsBillChartValue.fromJson(Map<String, dynamic> json) => PoVsBillChartValue(
    materialHeadName: json["materialHeadName"],
    totalPoAmount: json["totalPOAmount"],
    totalBillAmount: json["totalBillAmount"],
    varianceLabel: json["varianceLabel"],
  );

  Map<String, dynamic> toJson() => {
    "materialHeadName": materialHeadName,
    "totalPOAmount": totalPoAmount,
    "totalBillAmount": totalBillAmount,
    "varianceLabel": varianceLabel,
  };
}

class PoVsbillTable {
  String? materialHeadName;
  int? totalPOs;
  String? poValue;
  String? billed;
  String? unbilled;
  String? overBilled;
  String? billingPercent;
  String? variance;

  PoVsbillTable({
    this.materialHeadName,
    this.totalPOs,
    this.poValue,
    this.billed,
    this.unbilled,
    this.overBilled,
    this.billingPercent,
    this.variance,
  });

  factory PoVsbillTable.fromJson(Map<String, dynamic> json) => PoVsbillTable(
    materialHeadName: json["materialHeadName"],
    totalPOs: json["totalPOs"],
    poValue: json["poValue"],
    billed: json["billed"],
    unbilled: json["unbilled"],
    overBilled: json["overBilled"],
    billingPercent: json["billingPercent"],
    variance: json["variance"],
  );

  Map<String, dynamic> toJson() => {
    "materialHeadName": materialHeadName,
    "totalPOs": totalPOs,
    "poValue": poValue,
    "billed": billed,
    "unbilled": unbilled,
    "overBilled": overBilled,
    "billingPercent": billingPercent,
    "variance": variance,
  };
}

class Result {
  int? activeMaterialHeadCount;
  int? previousActiveMaterialHeadCount;
  String? highestMatHead;
  String? highestTotalNetAmount;
  int? overBilledMaterialHeadCount;
  int? previousMonthOverBilledMaterialHeadCount;
  String? overBilledMaterialHeadDifferencePercentage;
  String? mostMatchingHead;
  String? mostMatchingHeadPercentage;
  String? avgBillPercent;
  String? previousMonthAvgBillPercent;
  String? avgBillDifferencePercentage;
  String? pendingBillAmount;
  String? previousPendingBillAmount;

  Result({
   this.activeMaterialHeadCount,
   this.previousActiveMaterialHeadCount,
   this.highestMatHead,
   this.highestTotalNetAmount,
   this.overBilledMaterialHeadCount,
   this.previousMonthOverBilledMaterialHeadCount,
   this.overBilledMaterialHeadDifferencePercentage,
   this.mostMatchingHead,
   this.mostMatchingHeadPercentage,
   this.avgBillPercent,
   this.previousMonthAvgBillPercent,
   this.avgBillDifferencePercentage,
   this.pendingBillAmount,
   this.previousPendingBillAmount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    activeMaterialHeadCount: json["activeMaterialHeadCount"],
    previousActiveMaterialHeadCount: json["previousActiveMaterialHeadCount"],
    highestMatHead: json["highestMatHead"],
    highestTotalNetAmount: json["highestTotalNetAmount"],
    overBilledMaterialHeadCount: json["overBilledMaterialHeadCount"],
    previousMonthOverBilledMaterialHeadCount: json["previousMonthOverBilledMaterialHeadCount"],
    overBilledMaterialHeadDifferencePercentage: json["overBilledMaterialHeadDifferencePercentage"],
    mostMatchingHead: json["mostMatchingHead"],
    mostMatchingHeadPercentage: json["mostMatchingHeadPercentage"],
    avgBillPercent: json["avgBillPercent"],
    previousMonthAvgBillPercent: json["previousMonthAvgBillPercent"],
    avgBillDifferencePercentage: json["avgBillDifferencePercentage"],
    pendingBillAmount: json["pendingBillAmount"],
    previousPendingBillAmount: json["previousPendingBillAmount"],
  );

  Map<String, dynamic> toJson() => {
    "activeMaterialHeadCount": activeMaterialHeadCount,
    "previousActiveMaterialHeadCount": previousActiveMaterialHeadCount,
    "highestMatHead": highestMatHead,
    "highestTotalNetAmount": highestTotalNetAmount,
    "overBilledMaterialHeadCount": overBilledMaterialHeadCount,
    "previousMonthOverBilledMaterialHeadCount": previousMonthOverBilledMaterialHeadCount,
    "overBilledMaterialHeadDifferencePercentage": overBilledMaterialHeadDifferencePercentage,
    "mostMatchingHead": mostMatchingHead,
    "mostMatchingHeadPercentage": mostMatchingHeadPercentage,
    "avgBillPercent": avgBillPercent,
    "previousMonthAvgBillPercent": previousMonthAvgBillPercent,
    "avgBillDifferencePercentage": avgBillDifferencePercentage,
    "pendingBillAmount": pendingBillAmount,
    "previousPendingBillAmount": previousPendingBillAmount,
  };
}

class SpendDistribution {
  int? materialHeadId;
  String? materialHeadName;
  String? totalAmount;
  double? contributionPercentage;
  String? contributionPercentageText;

  SpendDistribution({
    this.materialHeadId,
    this.materialHeadName,
    this.totalAmount,
    this.contributionPercentage,
    this.contributionPercentageText,
  });

  factory SpendDistribution.fromJson(Map<String, dynamic> json) => SpendDistribution(
    materialHeadId: json["materialHeadId"],
    materialHeadName: json["materialHeadName"],
    totalAmount: json["totalAmount"],
    contributionPercentage: json["contributionPercentage"]?.toDouble(),
    contributionPercentageText: json["contributionPercentageText"],
  );

  Map<String, dynamic> toJson() => {
    "materialHeadId": materialHeadId,
    "materialHeadName": materialHeadName,
    "totalAmount": totalAmount,
    "contributionPercentage": contributionPercentage,
    "contributionPercentageText": contributionPercentageText,
  };
}
