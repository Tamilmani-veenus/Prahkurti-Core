// // To parse this JSON data, do
// //
// //     final poapprovalSupplierbuilldlListModel = poapprovalSupplierbuilldlListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<PoapprovalSupplierbuilldlListModel> poapprovalSupplierbuilldlListModelFromJson(String str) => List<PoapprovalSupplierbuilldlListModel>.from(json.decode(str).map((x) => PoapprovalSupplierbuilldlListModel.fromJson(x)));
//
// String poapprovalSupplierbuilldlListModelToJson(List<PoapprovalSupplierbuilldlListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class PoapprovalSupplierbuilldlListModel {
//   int supplierid;
//   String supplier;
//   double rate;
//   String billdate;
//
//   PoapprovalSupplierbuilldlListModel({
//     required this.supplierid,
//     required this.supplier,
//     required this.rate,
//     required this.billdate,
//   });
//
//   factory PoapprovalSupplierbuilldlListModel.fromJson(Map<String, dynamic> json) => PoapprovalSupplierbuilldlListModel(
//     supplierid: json["supplierid"],
//     supplier: json["supplier"],
//     rate: json["rate"]?.toDouble(),
//     billdate: json["billdate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "supplierid": supplierid,
//     "supplier": supplier,
//     "rate": rate,
//     "billdate": billdate,
//   };
// }



// To parse this JSON data, do
//
//     final poapprovalSupplierbuilldlListModel = poapprovalSupplierbuilldlListModelFromJson(jsonString);

import 'dart:convert';

PoapprovalSupplierbuilldlListModel poapprovalSupplierbuilldlListModelFromJson(String str) => PoapprovalSupplierbuilldlListModel.fromJson(json.decode(str));

String poapprovalSupplierbuilldlListModelToJson(PoapprovalSupplierbuilldlListModel data) => json.encode(data.toJson());

class PoapprovalSupplierbuilldlListModel {
  bool? success;
  List<Result>? result;

  PoapprovalSupplierbuilldlListModel({
    this.success,
    this.result,
  });

  factory PoapprovalSupplierbuilldlListModel.fromJson(Map<String, dynamic> json) => PoapprovalSupplierbuilldlListModel(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
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
