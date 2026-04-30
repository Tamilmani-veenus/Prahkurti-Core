// import 'dart:convert';
//
// List<MaterialWiseSubHeadResponse> materialWiseSubHeadResponseFromJson(String str) => List<MaterialWiseSubHeadResponse>.from(json.decode(str).map((x) => MaterialWiseSubHeadResponse.fromJson(x)));
//
// String materialWiseSubHeadResponseToJson(List<MaterialWiseSubHeadResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class MaterialWiseSubHeadResponse {
//   MaterialWiseSubHeadResponse({
//     this.materialheadid,
//     this.materialHead,
//   });
//
//   int? materialheadid;
//   String? materialHead;
//
//   factory MaterialWiseSubHeadResponse.fromJson(Map<String, dynamic> json) => MaterialWiseSubHeadResponse(
//     materialheadid: json["Materialheadid"],
//     materialHead: json["material_head"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Materialheadid": materialheadid,
//     "material_head": materialHead,
//   };
// }


// To parse this JSON data, do
//
//     final materialWiseHeadResponse = materialWiseHeadResponseFromJson(jsonString);

import 'dart:convert';

MaterialWiseHeadResponse materialWiseHeadResponseFromJson(String str) => MaterialWiseHeadResponse.fromJson(json.decode(str));

String materialWiseHeadResponseToJson(MaterialWiseHeadResponse data) => json.encode(data.toJson());

class MaterialWiseHeadResponse {
  bool? success;
  String? message;
  List<Result>? result;

  MaterialWiseHeadResponse({
    this.success,
    this.message,
    this.result,
  });

  factory MaterialWiseHeadResponse.fromJson(Map<String, dynamic> json) => MaterialWiseHeadResponse(
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
  String? materialHeadName;
  int? mainCategoryId;
  bool? isAsset;
  int? createdBy;
  bool? active;
  DateTime? createdDt;
  dynamic? mainCategoryName;

  Result({
    this.id,
    this.materialHeadName,
    this.mainCategoryId,
    this.isAsset,
    this.createdBy,
    this.active,
    this.createdDt,
    this.mainCategoryName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    materialHeadName: json["materialHeadName"],
    mainCategoryId: json["mainCategoryID"],
    isAsset: json["isAsset"],
    createdBy: json["createdBy"],
    active: json["active"],
    createdDt: DateTime.parse(json["createdDt"]),
    mainCategoryName: json["mainCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialHeadName": materialHeadName,
    "mainCategoryID": mainCategoryId,
    "isAsset": isAsset,
    "createdBy": createdBy,
    "active": active,
    // "createdDt": createdDt.toIso8601String(),
    "mainCategoryName": mainCategoryName,
  };
}

