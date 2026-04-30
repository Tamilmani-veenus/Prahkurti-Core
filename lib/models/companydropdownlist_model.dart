// To parse this JSON data, do
//
//     final companyDropdownListResponse = companyDropdownListResponseFromJson(jsonString);

import 'dart:convert';

List<CompanyDropdownListResponse> companyDropdownListResponseFromJson(String str) => List<CompanyDropdownListResponse>.from(json.decode(str).map((x) => CompanyDropdownListResponse.fromJson(x)));

String companyDropdownListResponseToJson(List<CompanyDropdownListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyDropdownListResponse {
  CompanyDropdownListResponse({
    this.companyid,
    this.company,
  });

  int? companyid;
  String? company;

  factory CompanyDropdownListResponse.fromJson(Map<String, dynamic> json) => CompanyDropdownListResponse(
    companyid: json["Companyid"],
    company: json["Company"],
  );

  Map<String, dynamic> toJson() => {
    "Companyid": companyid,
    "Company": company,
  };
}
