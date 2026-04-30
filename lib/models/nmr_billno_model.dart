// To parse this JSON data, do
//
//     final nmrBillNoRes = nmrBillNoResFromJson(jsonString);

import 'dart:convert';

List<NmrBillNoRes> nmrBillNoResFromJson(String str) => List<NmrBillNoRes>.from(json.decode(str).map((x) => NmrBillNoRes.fromJson(x)));

String nmrBillNoResToJson(List<NmrBillNoRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NmrBillNoRes {
  String? EntryAutoNo;

  NmrBillNoRes({
    this.EntryAutoNo,
  });

  factory NmrBillNoRes.fromJson(Map<String, dynamic> json) => NmrBillNoRes(
    EntryAutoNo: json["EntryAutoNo"],
  );

  Map<String, dynamic> toJson() => {
    "EntryAutoNo": EntryAutoNo,
  };
}
