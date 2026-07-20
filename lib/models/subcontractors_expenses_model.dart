// import 'dart:convert';
//
// List<SubcontractorOsExpensesResponse> subcontractorOsExpensesResponseFromJson(String str) => List<SubcontractorOsExpensesResponse>.from(json.decode(str).map((x) => SubcontractorOsExpensesResponse.fromJson(x)));
//
// String subcontractorOsExpensesResponseToJson(List<SubcontractorOsExpensesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class SubcontractorOsExpensesResponse {
//   SubcontractorOsExpensesResponse({
//     this.sNo,
//     this.labourName,
//     this.opnAmt,
//     this.workAmt,
//     this.issuepayment,
//     this.balAmt,
//   });
//
//   int? sNo;
//   String? labourName;
//   double? opnAmt;
//   double? workAmt;
//   double? issuepayment;
//   double? balAmt;
//
//   factory SubcontractorOsExpensesResponse.fromJson(Map<String, dynamic> json) => SubcontractorOsExpensesResponse(
//     sNo: json["SNo"],
//     labourName: json["LabourName"],
//     opnAmt: json["OpnAmt"],
//     workAmt: json["WorkAmt"],
//     issuepayment: json["Issuepayment"],
//     balAmt: json["BalAmt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SNo": sNo,
//     "LabourName": labourName,
//     "OpnAmt": opnAmt,
//     "WorkAmt": workAmt,
//     "Issuepayment": issuepayment,
//     "BalAmt": balAmt,
//   };
// }

// To parse this JSON data, do
//
//     final subcontractorOsExpensesResponse = subcontractorOsExpensesResponseFromJson(jsonString);

import 'dart:convert';

SubcontractorOsExpensesResponse subcontractorOsExpensesResponseFromJson(String str) => SubcontractorOsExpensesResponse.fromJson(json.decode(str));

String subcontractorOsExpensesResponseToJson(SubcontractorOsExpensesResponse data) => json.encode(data.toJson());

class SubcontractorOsExpensesResponse {
  bool? success;
  List<Result>? result;
  Map<String, double>? grandTotal;
  String? message;

  SubcontractorOsExpensesResponse({
    this.success,
    this.result,
    this.grandTotal,
    this.message,
  });

  factory SubcontractorOsExpensesResponse.fromJson(Map<String, dynamic> json) => SubcontractorOsExpensesResponse(
    success: json["success"],
      result: json["result"] == null
          ? []
          : List<Result>.from(
        json["result"].map((x) => Result.fromJson(x)),
      ),
      grandTotal: json["grandTotal"] == null
          ? {}
          : Map<String, double>.from(
        json["grandTotal"].map(
              (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
    "grandTotal": grandTotal ?? {},
    "message": message
  };
}

class Result {
  int? sNo;
  String? labourName;
  double? openingAmount;
  double? billAmount;
  double? issuePaymentAmount;
  double? tdsAmount;
  double? tdsPaidAmount;
  double? retentionHoldingAmount;
  double? retentionIssuedAmount;
  double? gstHoldingAmount;
  double? gstIssuedAmount;
  double? balanceAmount;

  Result({
    this.sNo,
    this.labourName,
    this.openingAmount,
    this.billAmount,
    this.issuePaymentAmount,
    this.tdsAmount,
    this.tdsPaidAmount,
    this.retentionHoldingAmount,
    this.retentionIssuedAmount,
    this.gstHoldingAmount,
    this.gstIssuedAmount,
    this.balanceAmount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    sNo: json["SNo"],
    labourName: json["LabourName"],
    openingAmount: json["OpeningAmount"].toDouble(),
    billAmount: json["BillAmount"].toDouble(),
    issuePaymentAmount: json["IssuePaymentAmount"],
    tdsAmount: json["TDSAmount"].toDouble(),
    tdsPaidAmount: json["TDSPaidAmount"],
    retentionHoldingAmount: json["RetentionHoldingAmount"].toDouble(),
    retentionIssuedAmount: json["RetentionIssuedAmount"],
    gstHoldingAmount: json["GSTHoldingAmount"],
    gstIssuedAmount: json["GSTIssuedAmount"],
    balanceAmount: json["BalanceAmount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "SNo": sNo,
    "LabourName": labourName,
    "OpeningAmount": openingAmount,
    "BillAmount": billAmount,
    "IssuePaymentAmount": issuePaymentAmount,
    "TDSAmount": tdsAmount,
    "TDSPaidAmount": tdsPaidAmount,
    "RetentionHoldingAmount": retentionHoldingAmount,
    "RetentionIssuedAmount": retentionIssuedAmount,
    "GSTHoldingAmount": gstHoldingAmount,
    "GSTIssuedAmount": gstIssuedAmount,
    "BalanceAmount": balanceAmount,
  };
}

