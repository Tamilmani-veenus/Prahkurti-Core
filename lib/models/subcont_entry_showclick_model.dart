// To parse this JSON data, do
//
//     final subContEntryShowResponse = subContEntryShowResponseFromJson(jsonString);

import 'dart:convert';

SubContEntryShowResponse subContEntryShowResponseFromJson(String str) => SubContEntryShowResponse.fromJson(json.decode(str));

String subContEntryShowResponseToJson(SubContEntryShowResponse data) => json.encode(data.toJson());

class SubContEntryShowResponse {
  bool? success;
  String? message;
  List<Result>? result;

  SubContEntryShowResponse({
    this.success,
    this.message,
    this.result,
  });

  factory SubContEntryShowResponse.fromJson(Map<String, dynamic> json) => SubContEntryShowResponse(
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
  int? categoryId;
  String? categoryName;
  double? wages;
  double? dprWages;
  int? labourId;
  int? labCategoryId;
  String? dprcategoryName;
  double? nos;
  double? amount;
  double? otHrs;
  double? otAmount;

  Result({
    this.categoryId,
    this.categoryName,
    this.wages,
    this.dprWages,
    this.labourId,
    this.labCategoryId,
    this.dprcategoryName,
    this.nos,
    this.amount,
    this.otHrs,
    this.otAmount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    categoryId: json["id"],
    categoryName: json["labCategory"],
    wages: json["rate"],
    labourId: json["labourId"],
    labCategoryId: json["labCategoryId"],
    dprWages: json["wages"],
    nos: json["nos"],
    dprcategoryName: json["categoryName"],
    amount: json["amount"],
    otHrs: json["otHrs"],
    otAmount: json["otAmount"],
  );

  Map<String, dynamic> toJson() => {
    "id": categoryId,
    "labCategory": categoryName,
    "rate": wages,
    "labourId": labourId,
    "labCategoryId": labCategoryId,
    "wages": dprWages,
    "nos": nos,
    "categoryName": dprcategoryName,
    "amount": amount,
    "otHrs": otHrs,
    "otAmount": otAmount,
  };
}
