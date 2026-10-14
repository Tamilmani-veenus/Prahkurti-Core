// To parse this JSON data, do
//
//     final materialDashSupWise = materialDashSupWiseFromJson(jsonString);

import 'dart:convert';

MaterialDashSupWise materialDashSupWiseFromJson(String str) => MaterialDashSupWise.fromJson(json.decode(str));

String materialDashSupWiseToJson(MaterialDashSupWise data) => json.encode(data.toJson());

class MaterialDashSupWise {
  bool? success;
  Result? result;
  List<Povsbill>? povsbill;
  List<Povsbillreg>? povsbillreg;
  int? poRaisedCount;
  int? billIssuedCount;
  int? billPendingCount;

  MaterialDashSupWise({
    this.success,
    this.result,
    this.povsbill,
    this.povsbillreg,
    this.poRaisedCount,
    this.billIssuedCount,
    this.billPendingCount,
  });

  factory MaterialDashSupWise.fromJson(Map<String, dynamic> json) => MaterialDashSupWise(
    success: json["success"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
    povsbill: json["povsbill"]==null?[]:List<Povsbill>.from(json["povsbill"].map((x) => Povsbill.fromJson(x))),
    povsbillreg: json["povsbillreg"]==null?[]:List<Povsbillreg>.from(json["povsbillreg"].map((x) => Povsbillreg.fromJson(x))),
    poRaisedCount: json["poRaisedCount"],
    billIssuedCount: json["billIssuedCount"],
    billPendingCount: json["billPendingCount"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result!.toJson(),
    "povsbill": List<dynamic>.from(povsbill!.map((x) => x.toJson())),
    "povsbillreg": List<dynamic>.from(povsbillreg!.map((x) => x.toJson())),
    "poRaisedCount": poRaisedCount,
    "billIssuedCount": billIssuedCount,
    "billPendingCount": billPendingCount,
  };
}

class Povsbill {
  String? supplierName;
  String? totalPo;
  String? billAmount;
  String? billingPercent;
  String? variance;

  Povsbill({
   this.supplierName,
   this.totalPo,
   this.billAmount,
   this.billingPercent,
   this.variance,
  });

  factory Povsbill.fromJson(Map<String, dynamic> json) => Povsbill(
    supplierName: json["supplierName"],
    totalPo: json["totalPO"],
    billAmount: json["billAmount"],
    billingPercent: json["billingPercent"],
    variance: json["variance"],
  );

  Map<String, dynamic> toJson() => {
    "supplierName": supplierName,
    "totalPO": totalPo,
    "billAmount": billAmount,
    "billingPercent": billingPercent,
    "variance": variance,
  };
}

class Povsbillreg {
  String? supplierName;
  int? pOs;
  String? totalPo;
  String? totalBill;
  String? approved;
  String? pending;
  String? overBill;
  double? billingPercent;

  Povsbillreg({
    required this.supplierName,
    required this.pOs,
    required this.totalPo,
    required this.totalBill,
    required this.approved,
    required this.pending,
    required this.overBill,
    required this.billingPercent,
  });

  factory Povsbillreg.fromJson(Map<String, dynamic> json) => Povsbillreg(
    supplierName: json["supplierName"],
    pOs: json["pOs"],
    totalPo: json["totalPO"],
    totalBill: json["totalBill"],
    approved: json["approved"],
    pending: json["pending"],
    overBill: json["overBill"],
    billingPercent: json["billingPercent"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "supplierName": supplierName,
    "pOs": pOs,
    "totalPO": totalPo,
    "totalBill": totalBill,
    "approved": approved,
    "pending": pending,
    "overBill": overBill,
    "billingPercent": billingPercent,
  };
}

class Result {
  int? activeSuppliers;
  String? poTotalValue;
  String? previousMonthPoValue;
  String? poDifferencePercentage;
  String? totalBilledAmount;
  String? previousMonthBilledAmount;
  String? billDifferencePercentage;
  int? overBilledCount;
  String? avgBillPercentage;
  String? pendingBillAmount;
  int? poRaisedCounttotal;
  int? billIssuedCounttotal;
  int? billPendingCounttotal;

  Result({
    this.activeSuppliers,
    this.poTotalValue,
    this.previousMonthPoValue,
    this.poDifferencePercentage,
    this.totalBilledAmount,
    this.previousMonthBilledAmount,
    this.billDifferencePercentage,
    this.overBilledCount,
    this.avgBillPercentage,
    this.pendingBillAmount,
    this.poRaisedCounttotal,
    this.billIssuedCounttotal,
    this.billPendingCounttotal,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    activeSuppliers: json["activeSuppliers"],
    poTotalValue: json["poTotalValue"],
    previousMonthPoValue: json["previousMonthPoValue"],
    poDifferencePercentage: json["poDifferencePercentage"],
    totalBilledAmount: json["totalBilledAmount"],
    previousMonthBilledAmount: json["previousMonthBilledAmount"],
    billDifferencePercentage: json["billDifferencePercentage"],
    overBilledCount: json["overBilledCount"],
    avgBillPercentage: json["avgBillPercentage"],
    pendingBillAmount: json["pendingBillAmount"],
    poRaisedCounttotal: json["poRaisedCounttotal"],
    billIssuedCounttotal: json["billIssuedCounttotal"],
    billPendingCounttotal: json["billPendingCounttotal"],
  );

  Map<String, dynamic> toJson() => {
    "activeSuppliers": activeSuppliers,
    "poTotalValue": poTotalValue,
    "previousMonthPoValue": previousMonthPoValue,
    "poDifferencePercentage": poDifferencePercentage,
    "totalBilledAmount": totalBilledAmount,
    "previousMonthBilledAmount": previousMonthBilledAmount,
    "billDifferencePercentage": billDifferencePercentage,
    "overBilledCount": overBilledCount,
    "avgBillPercentage": avgBillPercentage,
    "pendingBillAmount": pendingBillAmount,
    "poRaisedCounttotal": poRaisedCounttotal,
    "billIssuedCounttotal": billIssuedCounttotal,
    "billPendingCounttotal": billPendingCounttotal,
  };
}
