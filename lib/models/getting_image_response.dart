// To parse this JSON data, do
//
//     final gettingImage = gettingImageFromJson(jsonString);

import 'dart:convert';

List<GettingImage> gettingImageFromJson(String str) => List<GettingImage>.from(json.decode(str).map((x) => GettingImage.fromJson(x)));

String gettingImageToJson(List<GettingImage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GettingImage {
  int? id;
  String? name;
  String? url;

  GettingImage({
    this.id,
    this.name,
    this.url,
  });

  factory GettingImage.fromJson(Map<String, dynamic> json) => GettingImage(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}
