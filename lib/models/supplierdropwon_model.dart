// // To parse this JSON data, do
// //
// //     final supplierDropdownResponse = supplierDropdownResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// List<SupplierDropdownResponse> supplierDropdownResponseFromJson(String str) => List<SupplierDropdownResponse>.from(json.decode(str).map((x) => SupplierDropdownResponse.fromJson(x)));
//
// String supplierDropdownResponseToJson(List<SupplierDropdownResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class SupplierDropdownResponse {
//   SupplierDropdownResponse({
//     this.supplierId,
//     this.supplierName,
//   });
//
//   int? supplierId;
//   String? supplierName;
//
//   factory SupplierDropdownResponse.fromJson(Map<String, dynamic> json) => SupplierDropdownResponse(
//     supplierId: json["SupplierId"],
//     supplierName: json["SupplierName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SupplierId": supplierId,
//     "SupplierName": supplierName,
//   };
// }


// To parse this JSON data, do
//
//     final supplierDropdownResponse = supplierDropdownResponseFromJson(jsonString);

import 'dart:convert';

SupplierDropdownResponse supplierDropdownResponseFromJson(String str) => SupplierDropdownResponse.fromJson(json.decode(str));

String supplierDropdownResponseToJson(SupplierDropdownResponse data) => json.encode(data.toJson());

class SupplierDropdownResponse {
  bool? success;
  String? message;
  List<Response>? response;

  SupplierDropdownResponse({
    this.success,
    this.message,
    this.response,
  });

  factory SupplierDropdownResponse.fromJson(Map<String, dynamic> json) => SupplierDropdownResponse(
    success: json["success"],
    message: json["message"],
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "response": List<dynamic>.from(response!.map((x) => x.toJson())),
  };
}

class Response {
  int? id;
  String? supplierName;


  Response({
    this.id,
    this.supplierName,

  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    supplierName: json["supplierName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplierName": supplierName,
  };
}



