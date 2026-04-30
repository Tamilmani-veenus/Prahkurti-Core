// To parse this JSON data, do
//
//     final casebooksite = casebooksiteFromJson(jsonString);

import 'dart:convert';

List<Casebooksite> casebooksiteFromJson(String str) => List<Casebooksite>.from(json.decode(str).map((x) => Casebooksite.fromJson(x)));

String casebooksiteToJson(List<Casebooksite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Casebooksite {
  Casebooksite({
    this.sno,
    this.projectid,
    this.vocDate,
    this.vocdate,
    this.vocNo,
    this.descriptions,
    this.vocType,
    this.debit,
    this.credit,
    this.remarks,
  });

  int? sno;
  int? projectid;
  String? vocDate;
  String? vocdate;
  String? vocNo;
  String? descriptions;
  String? vocType;
  double? debit;
  double? credit;
  String? remarks;

  factory Casebooksite.fromJson(Map<String, dynamic> json) => Casebooksite(
    sno: json["sno"],
    projectid: json["projectid"],
    vocDate: json["voc_date"],
    vocdate: json["vocdate"],
    vocNo: json["voc_no"],
    descriptions: json["Descriptions"],
    vocType: json["VOC_TYPE"],
    debit: json["Debit"],
    credit: json["credit"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "projectid": projectid,
    "voc_date": vocDate,
    "vocdate": vocdate,
    "voc_no": vocNo,
    "Descriptions": descriptions,
    "VOC_TYPE": vocType,
    "Debit": debit,
    "credit": credit,
    "remarks": remarks,
  };
}
