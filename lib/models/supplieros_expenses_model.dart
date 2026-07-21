// import 'dart:convert';
//
// List<SupplierOsExpensesResponse> supplierOsExpensesResponseFromJson(String str) => List<SupplierOsExpensesResponse>.from(json.decode(str).map((x) => SupplierOsExpensesResponse.fromJson(x)));
//
// String supplierOsExpensesResponseToJson(List<SupplierOsExpensesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class SupplierOsExpensesResponse {
//   SupplierOsExpensesResponse({
//     this.sNo,
//     this.supplier,
//     this.op,
//     this.billamt,
//     this.advamt,
//     this.retAmt,
//     this.balamt,
//     this.excessamt,
//   });
//
//   int? sNo;
//   String? supplier;
//   double? op;
//   double? billamt;
//   double? advamt;
//   double? retAmt;
//   double? balamt;
//   double? excessamt;
//
//   factory SupplierOsExpensesResponse.fromJson(Map<String, dynamic> json) => SupplierOsExpensesResponse(
//     sNo: json["SNo"],
//     supplier: json["supplier"],
//     op: json["op"],
//     billamt: json["billamt"],
//     advamt: json["advamt"],
//     retAmt: json["RetAmt"],
//     balamt: json["balamt"],
//     excessamt: json["excessamt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SNo": sNo,
//     "supplier": supplier,
//     "op": op,
//     "billamt": billamt,
//     "advamt": advamt,
//     "RetAmt": retAmt,
//     "balamt": balamt,
//     "excessamt": excessamt,
//   };
// }


// To parse this JSON data, do
//
//     final supplierOsExpensesResponse = supplierOsExpensesResponseFromJson(jsonString);

import 'dart:convert';

SupplierOsExpensesResponse supplierOsExpensesResponseFromJson(String str) => SupplierOsExpensesResponse.fromJson(json.decode(str));

String supplierOsExpensesResponseToJson(SupplierOsExpensesResponse data) => json.encode(data.toJson());

class SupplierOsExpensesResponse {
  bool? success;
  List<Result>? result;
  Map<String, double>? grandTotal;
  String? message;

  SupplierOsExpensesResponse({
    this.success,
    this.result,
    this.grandTotal,
    this.message
  });

  factory SupplierOsExpensesResponse.fromJson(Map<String, dynamic> json) => SupplierOsExpensesResponse(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    grandTotal: Map.from(json["grandTotal"]).map((k, v) => MapEntry<String, double>(k, v)),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "grandTotal": Map.from(grandTotal!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "message": message
  };
}

class Result {
  int? sNo;
  String? supplierName;
  double? openingBalance;
  double? billAmount;
  double? advanceAmount;
  double? returnAmount;
  double? tdsAmount;
  double? tdsPaidAmount;
  double? balanceAmount;
  double? excessAmount;
  double? tdsBalanceAmount;
  double? totalBalanceAmount;

  Result({
    this.sNo,
    this.supplierName,
    this.openingBalance,
    this.billAmount,
    this.advanceAmount,
    this.returnAmount,
    this.tdsAmount,
    this.tdsPaidAmount,
    this.balanceAmount,
    this.excessAmount,
    this.tdsBalanceAmount,
    this.totalBalanceAmount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    sNo: json["SNo"],
    supplierName: json["SupplierName"],
    openingBalance: json["OpeningBalance"],
    billAmount: json["BillAmount"],
    advanceAmount: json["AdvanceAmount"],
    returnAmount: json["ReturnAmount"],
    tdsAmount: json["TDSAmount"],
    tdsPaidAmount: json["TDSPaidAmount"],
    balanceAmount: json["BalanceAmount"],
    excessAmount: json["ExcessAmount"],
    tdsBalanceAmount: json["TDSBalanceAmount"],
    totalBalanceAmount: json["TotalBalanceAmount"],
  );

  Map<String, dynamic> toJson() => {
    "SNo": sNo,
    "SupplierName": supplierName,
    "OpeningBalance": openingBalance,
    "BillAmount": billAmount,
    "AdvanceAmount": advanceAmount,
    "ReturnAmount": returnAmount,
    "TDSAmount": tdsAmount,
    "TDSPaidAmount": tdsPaidAmount,
    "BalanceAmount": balanceAmount,
    "ExcessAmount": excessAmount,
    "TDSBalanceAmount": tdsBalanceAmount,
    "TotalBalanceAmount": totalBalanceAmount,
  };
}
