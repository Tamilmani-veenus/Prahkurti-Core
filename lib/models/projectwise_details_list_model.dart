// To parse this JSON data, do
//
//     final projectWiseDetailsListResponse = projectWiseDetailsListResponseFromJson(jsonString);

import 'dart:convert';

ProjectWiseDetailsListResponse projectWiseDetailsListResponseFromJson(String str) => ProjectWiseDetailsListResponse.fromJson(json.decode(str));

String projectWiseDetailsListResponseToJson(ProjectWiseDetailsListResponse data) => json.encode(data.toJson());

class ProjectWiseDetailsListResponse {
  bool? success;
  List<Result>? result;
  String? message;

  ProjectWiseDetailsListResponse({
    this.success,
    this.result,
    this.message,
  });

  factory ProjectWiseDetailsListResponse.fromJson(Map<String, dynamic> json) => ProjectWiseDetailsListResponse(
    success: json["success"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  String? materialHeadName;
  int? materialId;
  String? materialName;
  int? scaleId;
  String? scaleName;
  double? opQty;
  double? purQty;
  double? transInQty;
  double? transOutQty;
  double? usageQty;
  double? clQty;

  Result({
    this.materialHeadName,
    this.materialId,
    this.materialName,
    this.scaleId,
    this.scaleName,
    this.opQty,
    this.purQty,
    this.transInQty,
    this.transOutQty,
    this.usageQty,
    this.clQty,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    materialHeadName: json["MaterialHeadName"],
    materialId: json["MaterialID"],
    materialName: json["MaterialName"],
    scaleId: json["ScaleId"],
    scaleName: json["ScaleName"],
    opQty: json["Op_Qty"],
    purQty: json["Pur_Qty"],
    transInQty: json["TransIn_Qty"],
    transOutQty: json["TransOut_Qty"],
    usageQty: json["Usage_Qty"],
    clQty: json["CL_QTY"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialHeadName": materialHeadName,
    "MaterialID": materialId,
    "MaterialName": materialName,
    "ScaleId": scaleId,
    "ScaleName": scaleName,
    "Op_Qty": opQty,
    "Pur_Qty": purQty,
    "TransIn_Qty": transInQty,
    "TransOut_Qty": transOutQty,
    "Usage_Qty": usageQty,
    "CL_QTY": clQty,
  };
}
