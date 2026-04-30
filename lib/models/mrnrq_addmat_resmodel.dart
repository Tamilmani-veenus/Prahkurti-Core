import 'dart:convert';

List<MrnReqAddMaterialResmodel> mrnReqAddMaterialResmodelFromJson(String str) => List<MrnReqAddMaterialResmodel>.from(json.decode(str).map((x) => MrnReqAddMaterialResmodel.fromJson(x)));

String mrnReqAddMaterialResmodelToJson(List<MrnReqAddMaterialResmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MrnReqAddMaterialResmodel {
  MrnReqAddMaterialResmodel({
    this.scaleId,
    this.scale,
  });

  int? scaleId;
  String? scale;

  factory MrnReqAddMaterialResmodel.fromJson(Map<String, dynamic> json) => MrnReqAddMaterialResmodel(
    scaleId: json["Scale_id"],
    scale: json["Scale"],
  );

  Map<String, dynamic> toJson() => {
    "Scale_id": scaleId,
    "Scale": scale,
  };
}
