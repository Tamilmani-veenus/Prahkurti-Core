import 'dart:convert';

List<DprTypeSucontResponse> dprTypeSucontResponseFromJson(String str) => List<DprTypeSucontResponse>.from(json.decode(str).map((x) => DprTypeSucontResponse.fromJson(x)));

String dprTypeSucontResponseToJson(List<DprTypeSucontResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DprTypeSucontResponse {
  DprTypeSucontResponse({
    this.subContId,
    this.subContName,
  });

  int? subContId;
  String? subContName;

  factory DprTypeSucontResponse.fromJson(Map<String, dynamic> json) => DprTypeSucontResponse(
    subContId: json["SubContId"],
    subContName: json["SubContName"],
  );

  Map<String, dynamic> toJson() => {
    "SubContId": subContId,
    "SubContName": subContName,
  };
}
