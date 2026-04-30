// To parse this JSON data, do
//
//     final invoiceNoResponse = invoiceNoResponseFromJson(jsonString);

import 'dart:convert';

List<InvoiceNoResponse> invoiceNoResponseFromJson(String str) => List<InvoiceNoResponse>.from(json.decode(str).map((x) => InvoiceNoResponse.fromJson(x)));

String invoiceNoResponseToJson(List<InvoiceNoResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceNoResponse {
  String? entryAutoNo;

  InvoiceNoResponse({
    this.entryAutoNo,
  });

  factory InvoiceNoResponse.fromJson(Map<String, dynamic> json) => InvoiceNoResponse(
    entryAutoNo: json["EntryAutoNo"],
  );

  Map<String, dynamic> toJson() => {
    "EntryAutoNo": entryAutoNo,
  };
}
