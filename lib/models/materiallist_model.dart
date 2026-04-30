// // To parse this JSON data, do
// //
// //     final materiallistResponse = materiallistResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// List<MateriallistResponse> materiallistResponseFromJson(String str) => List<MateriallistResponse>.from(json.decode(str).map((x) => MateriallistResponse.fromJson(x)));
//
// String materiallistResponseToJson(List<MateriallistResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class MateriallistResponse {
//   MateriallistResponse({
//     this.materialId,
//     this.material,
//     this.scale,
//     this.fixQty,
//     this.reqQty,
//     this.addQty,
//     this.lessQty,
//     this.balqty,
//     this.stockQty,
//   });
//
//   int? materialId;
//   String? material;
//   String? scale;
//   double? fixQty;
//   double? reqQty;
//   double? addQty;
//   double? lessQty;
//   double? balqty;
//   double? stockQty;
//   String? nos='1';
//   bool? isCheck = false;
//
//   factory MateriallistResponse.fromJson(Map<String, dynamic> json) => MateriallistResponse(
//     materialId: json["MaterialId"],
//     material: json["MaterialName"],
//     scale: json["Scale"],
//     fixQty: json["FixQty"],
//     reqQty: json["ReqQty"],
//     addQty: json["addQty"],
//     lessQty: json["lessQty"],
//     balqty: json["BalQty"],
//     stockQty: json["StockQty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "MaterialId": materialId,
//     "MaterialName": material,
//     "Scale": scale,
//     "FixQty": fixQty,
//     "ReqQty": reqQty,
//     "addQty": addQty,
//     "lessQty": lessQty,
//     "BalQty": balqty,
//     "StockQty": stockQty,
//   };
// }


// To parse this JSON data, do
//
//     final materiallistResponse = materiallistResponseFromJson(jsonString);

import 'dart:convert';

MateriallistResponse materiallistResponseFromJson(String str) => MateriallistResponse.fromJson(json.decode(str));

String materiallistResponseToJson(MateriallistResponse data) => json.encode(data.toJson());

class MateriallistResponse {
  bool? success;
  String? message;
  List<Result>? result;

  MateriallistResponse({
    this.success,
    this.message,
    this.result,
  });

  factory MateriallistResponse.fromJson(Map<String, dynamic> json) => MateriallistResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null
        ? []
        : List<Result>.from(
        json["result"].map((x) => Result.fromJson(x))),  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? materialId;
  String? material;
  int? scaleId;
  String? scale;
  double? balqty;
  double? stockQty;
  bool? isCheck = false;

  Result({
    this.materialId,
    this.material,
    this.scaleId,
    this.scale,
    this.balqty,
    this.stockQty,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    materialId: json["id"],
    material: json["MaterialName"],
    scaleId: json["ScaleID"],
    scale: json["ScaleName"],
    balqty:  json["BalQty"],
    stockQty:  json["StockQty"],
  );

  Map<String, dynamic> toJson() => {
    "id": materialId,
    "MaterialName": material,
    "ScaleID": scaleId,
    "ScaleName": scale,
    "BalQty": balqty,
    "StockQty": stockQty,
  };
}
