import 'dart:convert';

InwardImageRes inwardImageResFromJson(String str) => InwardImageRes.fromJson(json.decode(str));

String inwardImageResToJson(InwardImageRes data) => json.encode(data.toJson());

class InwardImageRes {
  String? retString;

  InwardImageRes({
    this.retString,
  });

  factory InwardImageRes.fromJson(Map<String, dynamic> json) => InwardImageRes(
    retString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": retString,
  };
}
