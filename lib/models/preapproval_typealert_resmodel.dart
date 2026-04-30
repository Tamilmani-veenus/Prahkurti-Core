import 'dart:convert';

List<PreapprovalTypeAlertResmodel> preapprovalTypeAlertResmodelFromJson(String str) => json.decode(str) == null ? [] : List<PreapprovalTypeAlertResmodel>.from(json.decode(str).map((x) => PreapprovalTypeAlertResmodel.fromJson(x)));

String preapprovalTypeAlertResmodelToJson(PreapprovalTypeAlertResmodel data) => json.encode(data.toJson());

class PreapprovalTypeAlertResmodel {
  PreapprovalTypeAlertResmodel({
    this.typeId,
    this.typeName,
  });

  int? typeId;
  String? typeName;

  factory PreapprovalTypeAlertResmodel.fromJson(Map<String, dynamic> json) => PreapprovalTypeAlertResmodel(
    typeId: json["TypeId"],
    typeName: json["TypeName"],
  );

  Map<String, dynamic> toJson() => {
    "TypeId": typeId,
    "TypeName": typeName,
  };
}
