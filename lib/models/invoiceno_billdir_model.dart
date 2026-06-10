// To parse this JSON data, do
//
//     final invoiceNoResponse = invoiceNoResponseFromJson(jsonString);

import 'dart:convert';

InvoiceNoResponse invoiceNoResponseFromJson(String str) => InvoiceNoResponse.fromJson(json.decode(str));

String invoiceNoResponseToJson(InvoiceNoResponse data) => json.encode(data.toJson());

class InvoiceNoResponse {
  bool? success;
  List<Result>? result;
  String? message;

  InvoiceNoResponse({
    this.success,
    this.result,
    this.message,
  });

  factory InvoiceNoResponse.fromJson(Map<String, dynamic> json) => InvoiceNoResponse(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class Result {
  String? entryAutoNo;

  Result({
    this.entryAutoNo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    entryAutoNo: json["EntryAutoNo"],
  );

  Map<String, dynamic> toJson() => {
    "EntryAutoNo": entryAutoNo,
  };
}
