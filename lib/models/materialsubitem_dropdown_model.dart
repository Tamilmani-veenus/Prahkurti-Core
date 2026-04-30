//
// import 'dart:convert';
//
// List<MaterialSubDropdownResponse> materialSubDropdownResponseFromJson(String str) => List<MaterialSubDropdownResponse>.from(json.decode(str).map((x) => MaterialSubDropdownResponse.fromJson(x)));
//
// String materialSubDropdownResponseToJson(List<MaterialSubDropdownResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class MaterialSubDropdownResponse {
//   MaterialSubDropdownResponse({
//     this.materialSubId,
//     this.materialSubname,
//   });
//
//   int? materialSubId;
//   String? materialSubname;
//
//   factory MaterialSubDropdownResponse.fromJson(Map<String, dynamic> json) => MaterialSubDropdownResponse(
//     materialSubId: json["MaterialSubId"],
//     materialSubname: json["MaterialSubname"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "MaterialSubId": materialSubId,
//     "MaterialSubname": materialSubname,
//   };
// }


// To parse this JSON data, do
//
//     final materialWiseHeadSubResponse = materialWiseHeadSubResponseFromJson(jsonString);

import 'dart:convert';

MaterialWiseHeadSubResponse materialWiseHeadSubResponseFromJson(String str) => MaterialWiseHeadSubResponse.fromJson(json.decode(str));

String materialWiseHeadSubResponseToJson(MaterialWiseHeadSubResponse data) => json.encode(data.toJson());

class MaterialWiseHeadSubResponse {
  bool? success;
  String? message;
  List<Result>? result;

  MaterialWiseHeadSubResponse({
    this.success,
    this.message,
    this.result,
  });

  factory MaterialWiseHeadSubResponse.fromJson(Map<String, dynamic> json) => MaterialWiseHeadSubResponse(
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
  String? materialSubName;
  int? createdBy;
  bool? active;
  int? materialHeadId;
  dynamic? materialHeadMasName;
  DateTime? createdDt;

  Result({
    this.id,
    this.materialSubName,
    this.createdBy,
    this.active,
    this.materialHeadId,
    this.materialHeadMasName,
    this.createdDt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    materialSubName: json["materialSubName"],
    createdBy: json["createdBy"],
    active: json["active"],
    materialHeadId: json["materialHeadID"],
    materialHeadMasName: json["materialHeadMasName"],
    createdDt: DateTime.parse(json["createdDt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialSubName": materialSubName,
    "createdBy": createdBy,
    "active": active,
    "materialHeadID": materialHeadId,
    "materialHeadMasName": materialHeadMasName,
    // "createdDt": createdDt.toIso8601String(),
  };
}

