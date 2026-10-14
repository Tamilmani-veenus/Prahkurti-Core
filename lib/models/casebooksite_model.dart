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
  List<Voucher>? vouchers;

  Result({
    this.vouchers,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vouchers: List<Voucher>.from(json["vouchers"].map((x) => Voucher.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vouchers": List<dynamic>.from(vouchers!.map((x) => x.toJson())),
  };
}

class Voucher {
  int? sno;
  int? projectId;
  int? voucherId;
  String? voucherNo;
  dynamic vocDate;
  String? voucherDate;
  String? descriptions;
  String? voucherType;
  double? creditAmount;
  double? depitAmount;
  String? remarks;

  Voucher({
    this.sno,
    this.projectId,
    this.voucherId,
    this.voucherNo,
    this.vocDate,
    this.voucherDate,
    this.descriptions,
    this.voucherType,
    this.creditAmount,
    this.depitAmount,
    this.remarks,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    sno: json["sno"],
    projectId: json["projectId"],
    voucherId: json["voucherId"],
    voucherNo: json["voucherNo"],
    vocDate: json["vocDate"],
    voucherDate: json["voucherDate"],
    descriptions: json["descriptions"],
    voucherType: json["voucherType"],
    creditAmount: json["creditAmount"]?.toDouble(),
    depitAmount: json["depitAmount"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "projectId": projectId,
    "voucherId": voucherId,
    "voucherNo": voucherNo,
    "vocDate": vocDate,
    "voucherDate": voucherDate,
    "descriptions": descriptions,
    "voucherType": voucherType,
    "creditAmount": creditAmount,
    "depitAmount": depitAmount,
    "remarks": remarks,
  };
}
