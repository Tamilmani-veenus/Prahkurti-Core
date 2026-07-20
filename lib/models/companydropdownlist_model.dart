// // To parse this JSON data, do
// //
// //     final companyDropdownListResponse = companyDropdownListResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// List<CompanyDropdownListResponse> companyDropdownListResponseFromJson(String str) => List<CompanyDropdownListResponse>.from(json.decode(str).map((x) => CompanyDropdownListResponse.fromJson(x)));
//
// String companyDropdownListResponseToJson(List<CompanyDropdownListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class CompanyDropdownListResponse {
//   CompanyDropdownListResponse({
//     this.companyid,
//     this.company,
//   });
//
//   int? companyid;
//   String? company;
//
//   factory CompanyDropdownListResponse.fromJson(Map<String, dynamic> json) => CompanyDropdownListResponse(
//     companyid: json["Companyid"],
//     company: json["Company"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Companyid": companyid,
//     "Company": company,
//   };
// }


// To parse this JSON data, do
//
//     final companyDropdownListResponse = companyDropdownListResponseFromJson(jsonString);

import 'dart:convert';

CompanyDropdownListResponse companyDropdownListResponseFromJson(String str) => CompanyDropdownListResponse.fromJson(json.decode(str));

String companyDropdownListResponseToJson(CompanyDropdownListResponse data) => json.encode(data.toJson());

class CompanyDropdownListResponse {
  bool? success;
  List<Result>? result;
  String? message;

  CompanyDropdownListResponse({
    this.success,
    this.result,
    this.message,
  });

  factory CompanyDropdownListResponse.fromJson(Map<String, dynamic> json) => CompanyDropdownListResponse(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? id;
  String? companyName;

  Result({
    this.id,
    this.companyName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    companyName: json["companyName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
  };
}

