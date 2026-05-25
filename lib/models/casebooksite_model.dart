// To parse this JSON data, do
//
//     final casebooksite = casebooksiteFromJson(jsonString);

import 'dart:convert';

Casebooksite casebooksiteFromJson(String str) => Casebooksite.fromJson(json.decode(str));

String casebooksiteToJson(Casebooksite data) => json.encode(data.toJson());

class Casebooksite {
  bool? success;
  List<Result>? result;
  String? message;
  double? totalCredit;
  double? totalDebit;
  double? closingBalance;

  Casebooksite({
    this.success,
    this.result,
    this.message,
    this.totalCredit,
    this.totalDebit,
    this.closingBalance,
  });

  factory Casebooksite.fromJson(Map<String, dynamic> json) => Casebooksite(
    success: json["success"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"],
    totalCredit: json["totalCredit"],
    totalDebit: json["totalDebit"],
    closingBalance: json["closingBalance"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
    "totalCredit": totalCredit,
    "totalDebit": totalDebit,
    "closingBalance": closingBalance,
  };
}

class Result {
  int? sno;
  int? projectId;
  String? voucherNo;
  String? vocdate;
  String? voucherDate;
  String? voucherType;
  String? descriptions;
  double? creditAmount;
  double? depitAmount;
  String? remarks;

  Result({
    this.sno,
    this.projectId,
    this.voucherNo,
    this.vocdate,
    this.voucherDate,
    this.voucherType,
    this.descriptions,
    this.creditAmount,
    this.depitAmount,
    this.remarks,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    sno: json["SNO"],
    projectId: json["ProjectId"],
    voucherNo: json["VoucherNo"],
    vocdate: json["Vocdate"],
    voucherDate: json["VoucherDate"],
    voucherType: json["VoucherType"],
    descriptions: json["Descriptions"],
    creditAmount: json["CreditAmount"],
    depitAmount: json["DepitAmount"],
    remarks: json["Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "SNO": sno,
    "ProjectId": projectId,
    "VoucherNo": voucherNo,
    "Vocdate": vocdate,
    "VoucherDate": voucherDate,
    "VoucherType": voucherType,
    "Descriptions": descriptions,
    "CreditAmount": creditAmount,
    "DepitAmount": depitAmount,
    "Remarks": remarks,
  };
}
