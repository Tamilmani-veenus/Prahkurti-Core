import 'dart:convert';

ImageDelete imageDeleteFromJson(String str) => ImageDelete.fromJson(json.decode(str));

String imageDeleteToJson(ImageDelete data) => json.encode(data.toJson());

class ImageDelete {
  String? message;

  ImageDelete({
    required this.message,
  });

  factory ImageDelete.fromJson(Map<String, dynamic> json) => ImageDelete(
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
  };
}
