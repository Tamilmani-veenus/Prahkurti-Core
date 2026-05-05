


// To parse this JSON data, do
//
//     final poapprovalSupplierbuilldlListModel = poapprovalSupplierbuilldlListModelFromJson(jsonString);

import 'dart:convert';

PoapprovalSupplierbuilldlListModel poapprovalSupplierbuilldlListModelFromJson(String str) => PoapprovalSupplierbuilldlListModel.fromJson(json.decode(str));

String poapprovalSupplierbuilldlListModelToJson(PoapprovalSupplierbuilldlListModel data) => json.encode(data.toJson());

class PoapprovalSupplierbuilldlListModel {
  bool? success;
  String? message;
  List<Result>? result;

  PoapprovalSupplierbuilldlListModel({
    this.success,
    this.message,
    this.result,
  });

  factory PoapprovalSupplierbuilldlListModel.fromJson(Map<String, dynamic> json) => PoapprovalSupplierbuilldlListModel(
    success: json["success"],
    message: json["message"],
  result: json["result"] == null
  ? []   // 👈 handle null case
      : List<Result>.from(
  json["result"].map((x) => Result.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? supplierid;
  String? supplier;
  double? rate;
  String? billdate;

  Result({
    this.supplierid,
    this.supplier,
    this.rate,
    this.billdate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    supplierid: json["supplierid"],
    supplier: json["supplier"],
    rate: json["rate"],
    billdate: json["billdate"],
  );

  Map<String, dynamic> toJson() => {
    "supplierid": supplierid,
    "supplier": supplier,
    "rate": rate,
    "billdate": billdate,
  };
}
