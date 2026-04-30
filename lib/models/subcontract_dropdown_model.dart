// To parse this JSON data, do
//
//     final subcontractorDropdownList = subcontractorDropdownListFromJson(jsonString);

import 'dart:convert';

SubcontractorDropdownList subcontractorDropdownListFromJson(String str) => SubcontractorDropdownList.fromJson(json.decode(str));

String subcontractorDropdownListToJson(SubcontractorDropdownList data) => json.encode(data.toJson());

class SubcontractorDropdownList {
  bool? success;
  String? message;
  List<Result>? result;

  SubcontractorDropdownList({
    this.success,
    this.message,
    this.result,
  });

  factory SubcontractorDropdownList.fromJson(Map<String, dynamic> json) => SubcontractorDropdownList(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? subContId;
  String? subContName;
  String? subcontNameRpt;

  Result({
    this.subContId,
    this.subContName,
    this.subcontNameRpt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    subContId: json["id"],
    subContName: json["subcontractorName"],
    subcontNameRpt: json["subcontractName"],
  );

  Map<String, dynamic> toJson() => {
    "id": subContId,
    "subcontractorName": subContName,
    "subcontractName": subcontNameRpt,
  };
}

List<GetLabourDetails> getLabourDetailsFromJson(String str) => List<GetLabourDetails>.from(json.decode(str).map((x) => GetLabourDetails.fromJson(x)));

String getLabourDetailsToJson(List<GetLabourDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetLabourDetails {
  int? labourId;
  String? labourName;

  GetLabourDetails({
    this.labourId,
    this.labourName,
  });

  factory GetLabourDetails.fromJson(Map<String, dynamic> json) => GetLabourDetails(
    labourId: json["LabourId"],
    labourName: json["LabourName"],
  );

  Map<String, dynamic> toJson() => {
    "LabourId": labourId,
    "LabourName": labourName,
  };
}
