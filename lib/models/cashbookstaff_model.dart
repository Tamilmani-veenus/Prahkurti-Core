// To parse this JSON data, do
//
//     final casebookstaff = casebookstaffFromJson(jsonString);

import 'dart:convert';

List<Casebookstaff> casebookstaffFromJson(String str) => List<Casebookstaff>.from(json.decode(str).map((x) => Casebookstaff.fromJson(x)));

String casebookstaffToJson(List<Casebookstaff> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Casebookstaff {
  Casebookstaff({
    this.sno,
    this.staffid,
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
  int? staffid;
  String? vocDate;
  String? vocdate;
  String? vocNo;
  String? descriptions;
  String? vocType;
  double? debit;
  double? credit;
  String? remarks;


  factory Casebookstaff.fromJson(Map<String, dynamic> json) => Casebookstaff(
    sno: json["sno"],
    staffid: json["staffid"],
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
    "staffid": staffid,
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
