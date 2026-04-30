import 'dart:convert';

List<ProjectWiseDetailsListResponse> projectWiseDetailsListResponseFromJson(String str) => List<ProjectWiseDetailsListResponse>.from(json.decode(str).map((x) => ProjectWiseDetailsListResponse.fromJson(x)));

String projectWiseDetailsListResponseToJson(List<ProjectWiseDetailsListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectWiseDetailsListResponse {
  ProjectWiseDetailsListResponse({
    this.materialId,
    this.material,
    this.scale,
    this.opQty,
    this.purQty,
    this.transInQty,
    this.transOutQty,
    this.usageQty,
    this.clQty,
  });

  int? materialId;
  String? material;
  String? scale;
  double? opQty;
  double? purQty;
  double? transInQty;
  double? transOutQty;
  double? usageQty;
  double? clQty;

  factory ProjectWiseDetailsListResponse.fromJson(Map<String, dynamic> json) => ProjectWiseDetailsListResponse(
    materialId: json["MaterialID"],
    material: json["Material"],
    scale: json["Scale"],
    opQty: json["Op_Qty"].toDouble(),
    purQty: json["Pur_Qty"].toDouble(),
    transInQty: json["TransIn_Qty"],
    transOutQty: json["TransOut_Qty"],
    usageQty: json["Usage_Qty"],
    clQty: json["CL_QTY"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "MaterialID": materialId,
    "Material": material,
    "Scale": scale,
    "Op_Qty": opQty,
    "Pur_Qty": purQty,
    "TransIn_Qty": transInQty,
    "TransOut_Qty": transOutQty,
    "Usage_Qty": usageQty,
    "CL_QTY": clQty,
  };
}
