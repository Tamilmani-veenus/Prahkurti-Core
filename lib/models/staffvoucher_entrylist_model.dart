// To parse this JSON data, do
//
//     final staffvoucherentrylist = staffvoucherentrylistFromJson(jsonString);

import 'dart:convert';

List<Staffvoucherentrylist> staffvoucherentrylistFromJson(String str) => List<Staffvoucherentrylist>.from(json.decode(str).map((x) => Staffvoucherentrylist.fromJson(x)));

String staffvoucherentrylistToJson(List<Staffvoucherentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Staffvoucherentrylist {
  Staffvoucherentrylist({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.staff,
    this.accName,
    this.accType,
    this.payFor,
    this.vocDate1,
    this.vocAmt,
  });

  int? vocId;
  String? vocNo;
  String? vocDate;
  String? staff;
  String? accName;
  String? accType;
  String? payFor;
  String? vocDate1;
  double? vocAmt;

  factory Staffvoucherentrylist.fromJson(Map<String, dynamic> json) => Staffvoucherentrylist(
    vocId: json["voc_id"],
    vocNo: json["voc_no"],
    vocDate: json["voc_date"],
    staff: json["staff"],
    accName: json["acc_name"],
    accType: json["acc_type"],
    payFor: json["pay_for"],
    vocDate1: json["voc_date1"],
    vocAmt: json["voc_amt"],
  );

  Map<String, dynamic> toJson() => {
    "voc_id": vocId,
    "voc_no": vocNo,
    "voc_date": vocDate,
    "staff": staff,
    "acc_name": accName,
    "acc_type": accType,
    "pay_for": payFor,
    "voc_date1": vocDate1,
    "voc_amt": vocAmt,
  };
}
