// To parse this JSON data, do
//
//     final staff = staffFromJson(jsonString);

import 'dart:convert';

List<Staff> staffFromJson(String str) => List<Staff>.from(json.decode(str).map((x) => Staff.fromJson(x)));

String staffToJson(List<Staff> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Staff {
  Staff({
    this.empid,
    this.empName,
  });

  int? empid;
  String? empName;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    empid: json["Empid"],
    empName: json["EmpName"],
  );

  Map<String, dynamic> toJson() => {
    "Empid": empid,
    "EmpName": empName,
  };
}
