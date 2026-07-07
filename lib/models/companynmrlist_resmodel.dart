// To parse this JSON data, do
//
//     final companyNmrAddListResModel = companyNmrAddListResModelFromJson(jsonString);

import 'dart:convert';

CompanyNmrAddListResModel companyNmrAddListResModelFromJson(String str) => CompanyNmrAddListResModel.fromJson(json.decode(str));

String companyNmrAddListResModelToJson(CompanyNmrAddListResModel data) => json.encode(data.toJson());

class CompanyNmrAddListResModel {
  bool? success;
  String? message;
  List<Result>? result;

  CompanyNmrAddListResModel({
    this.success,
    this.message,
    this.result,
  });

  factory CompanyNmrAddListResModel.fromJson(Map<String, dynamic> json) => CompanyNmrAddListResModel(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? labourId;
  String? labourNo;
  String? labourName;
  int? projectId;
  String? projectName;
  int? subContractorId;
  String? subcontractName;
  int? cityId;
  String? cityName;
  int? categoryId;
  String? categoryName;
  double? wages;
  String? gender;
  String? labourStatus;
  bool? ischeck=false;

  Result({
    this.labourId,
    this.labourNo,
    this.labourName,
    this.projectId,
    this.projectName,
    this.subContractorId,
    this.subcontractName,
    this.cityId,
    this.cityName,
    this.categoryId,
    this.categoryName,
    this.wages,
    this.gender,
    this.labourStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    labourId: json["LabourId"],
    labourNo: json["LabourNo"],
    labourName: json["LabourName"],
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    subContractorId: json["SubContractorId"],
    subcontractName: json["SubcontractName"],
    cityId: json["CityId"],
    cityName: json["CityName"],
    categoryId: json["CategoryId"],
    categoryName: json["CategoryName"],
    wages: json["Wages"],
    gender: json["Gender"],
    labourStatus: json["LabourStatus"],
  );

  Map<String, dynamic> toJson() => {
    "LabourId": labourId,
    "LabourNo": labourNo,
    "LabourName": labourName,
    "ProjectId": projectId,
    "ProjectName": projectName,
    "SubContractorId": subContractorId,
    "SubcontractName": subcontractName,
    "CityId": cityId,
    "CityName": cityName,
    "CategoryId": categoryId,
    "CategoryName": categoryName,
    "Wages": wages,
    "Gender": gender,
    "LabourStatus": labourStatus,
  };
}
