// To parse this JSON data, do
//
//     final companyNmrEntryListmodel = companyNmrEntryListmodelFromJson(jsonString);

import 'dart:convert';

List<CompanyNmrEntryListmodel> companyNmrEntryListmodelFromJson(String str) => List<CompanyNmrEntryListmodel>.from(json.decode(str).map((x) => CompanyNmrEntryListmodel.fromJson(x)));

String companyNmrEntryListmodelToJson(List<CompanyNmrEntryListmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyNmrEntryListmodel {
  CompanyNmrEntryListmodel({
    this.nmrLbrAttnId,
    this.nmrLbrAttnNo,
    this.labrAttnDate,
    this.preparedByName,
    this.attdate,
    this.siteName,
    this.project,
    this.billstatus,
    this.appstatus,
  });

  int? nmrLbrAttnId;
  String? nmrLbrAttnNo;
  String? labrAttnDate;
  String? preparedByName;
  DateTime? attdate;
  String? siteName;
  String? project;
  String? billstatus;
  String? appstatus;

  factory CompanyNmrEntryListmodel.fromJson(Map<String, dynamic> json) => CompanyNmrEntryListmodel(
    nmrLbrAttnId: json["NMRLbrAttn_Id"],
    nmrLbrAttnNo: json["NMRLbrAttn_No"],
    labrAttnDate: json["LabrAttn_Date"],
    preparedByName: json["PreparedByName"],
    attdate: DateTime.parse(json["attdate"]),
    siteName: json["SiteName"],
    project: json["Project"],
    billstatus: json["billstatus"],
    appstatus: json["Appstatus"],
  );

  Map<String, dynamic> toJson() => {
    "NMRLbrAttn_Id": nmrLbrAttnId,
    "NMRLbrAttn_No": nmrLbrAttnNo,
    "LabrAttn_Date": labrAttnDate,
    "PreparedByName": preparedByName,
    "attdate": attdate!.toIso8601String(),
    "SiteName": siteName,
    "Project": project,
    "billstatus": billstatus,
    "Appstatus": appstatus,
  };
}
