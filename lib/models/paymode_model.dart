import 'dart:convert';

List<PayModereponse> payModereponseFromJson(String str) => List<PayModereponse>.from(json.decode(str).map((x) => PayModereponse.fromJson(x)));

String payModereponseToJson(List<PayModereponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PayModereponse {
  PayModereponse({
    this.paymodeid,
    this.paymode,
  });

  int? paymodeid;
  String? paymode;

  factory PayModereponse.fromJson(Map<String, dynamic> json) => PayModereponse(
    paymodeid: json["paymodeid"],
    paymode: json["paymode"],
  );

  Map<String, dynamic> toJson() => {
    "paymodeid": paymodeid,
    "paymode": paymode,
  };
}
