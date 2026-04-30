// To parse this JSON data, do
//
//     final nmrItemlist = nmrItemlistFromJson(jsonString);

import 'dart:convert';

List<NmrItemlist> nmrItemlistFromJson(String str) => List<NmrItemlist>.from(json.decode(str).map((x) => NmrItemlist.fromJson(x)));

String nmrItemlistToJson(List<NmrItemlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NmrItemlist {
  NmrItemlist({
    this.project,
    this.projectid,
    this.siteName,
    this.siteId,
    this.categoryId,
    this.categoryName,
    this.nmrAmt,
    this.totnos,
    this.totalOtamt,
    this.netAmt,
    this.Rate,
    this.Totamt,
    this.total_othrs,
    this.wages,
    this.amt,
  });

  String? project;
  int? projectid;
  String? siteName;
  int? siteId;
  int? categoryId;
  String? categoryName;
  double? nmrAmt;
  double? totnos;
  double? totalOtamt;
  double? netAmt;
  double? Rate;
  double? Totamt;
  double? total_othrs;
  double? wages;
  double? amt;


  factory NmrItemlist.fromJson(Map<String, dynamic> json) => NmrItemlist(
    project: json["project"],
    projectid: json["projectid"],
    siteName: json["sitename"],
    siteId: json["siteid"],
    categoryId: json["CategoryId"],
    categoryName: json["CategoryName"],
    nmrAmt: json["NMRAMT"],
    totnos: json["totnos"],
    totalOtamt: json["total_otamt"],
    netAmt: json["NetAmt"],
    Rate: json["Rate"],
    Totamt: json["Totamt"],
    total_othrs: json["total_othrs"],
    wages: json["wages"],
    amt: json["Amt"],
  );

  Map<String, dynamic> toJson() => {
    "project": project,
    "projectid": projectid,
    "sitename": siteName,
    "siteid": siteId,
    "CategoryId": categoryId,
    "CategoryName": categoryName,
    "NMRAMT": nmrAmt,
    "totnos": totnos,
    "total_otamt": totalOtamt,
    "NetAmt": netAmt,
    "Rate": Rate,
    "Totamt": Totamt,
    "total_othrs": total_othrs,
    "wages": wages,
    "Amt": amt,
  };
}
