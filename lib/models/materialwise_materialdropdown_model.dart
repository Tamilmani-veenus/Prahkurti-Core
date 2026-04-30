// import 'dart:convert';
//
// List<MaterialWiseMaterialDropdownResponse> materialWiseMaterialDropdownResponseFromJson(String str) => List<MaterialWiseMaterialDropdownResponse>.from(json.decode(str).map((x) => MaterialWiseMaterialDropdownResponse.fromJson(x)));
//
// String materialWiseMaterialDropdownResponseToJson(List<MaterialWiseMaterialDropdownResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class MaterialWiseMaterialDropdownResponse {
//   MaterialWiseMaterialDropdownResponse({
//     this.materialId,
//     this.materialName,
//     this.scale,
//   });
//
//   int? materialId;
//   String? materialName;
//   String? scale;
//
//   factory MaterialWiseMaterialDropdownResponse.fromJson(Map<String, dynamic> json) => MaterialWiseMaterialDropdownResponse(
//     materialId: json["MaterialId"],
//     materialName: json["MaterialName"],
//     scale: json["Scale"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "MaterialId": materialId,
//     "MaterialName": materialName,
//     "Scale": scale,
//   };
// }
//


// To parse this JSON data, do
//
//     final materialWiseMaterialDropdownResponse = materialWiseMaterialDropdownResponseFromJson(jsonString);

import 'dart:convert';

MaterialWiseMaterialDropdownResponse materialWiseMaterialDropdownResponseFromJson(String str) => MaterialWiseMaterialDropdownResponse.fromJson(json.decode(str));

String materialWiseMaterialDropdownResponseToJson(MaterialWiseMaterialDropdownResponse data) => json.encode(data.toJson());

class MaterialWiseMaterialDropdownResponse {
  bool? success;
  String? message;
  List<Result>? result;

  MaterialWiseMaterialDropdownResponse({
    this.success,
    this.message,
    this.result,
  });

  factory MaterialWiseMaterialDropdownResponse.fromJson(Map<String, dynamic> json) => MaterialWiseMaterialDropdownResponse(
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
  int? id;
  String? materialName;


  Result({
    this.id,
    this.materialName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    materialName: json["materialName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialName": materialName,
  };
}
