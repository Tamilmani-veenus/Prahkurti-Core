import 'dart:convert';

List<CompanyNmrAddListResModel> companyNmrAddListResModelFromJson(String str) => List<CompanyNmrAddListResModel>.from(json.decode(str).map((x) => CompanyNmrAddListResModel.fromJson(x)));

String companyNmrAddListResModelToJson(List<CompanyNmrAddListResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyNmrAddListResModel {
  CompanyNmrAddListResModel({
    this.labourId,
    this.labourName,
    this.categaryName,
    this.Labour_No,
    this.wages,
  });

  int? labourId;
  String? labourName;
  String? Labour_No;
  String? categaryName;
  int? wages;
  bool?ischeck=false;

  factory CompanyNmrAddListResModel.fromJson(Map<String, dynamic> json) => CompanyNmrAddListResModel(
    labourId: json["LabourId"],
    labourName: json["LabourName"],
    Labour_No: json["Labour_No"],
    categaryName: json["CategaryName"],
    wages: json["Wages"],
  );

  Map<String, dynamic> toJson() => {
    "LabourId": labourId,
    "LabourName": labourName,
    "Labour_No": Labour_No,
    "CategaryName": categaryName,
    "Wages": wages,
  };
}





