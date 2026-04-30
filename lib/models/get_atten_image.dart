// To parse this JSON data, do
//
//     final getAttenImage = getAttenImageFromJson(jsonString);

import 'dart:convert';

GetAttenImage getAttenImageFromJson(String str) => GetAttenImage.fromJson(json.decode(str));

String getAttenImageToJson(GetAttenImage data) => json.encode(data.toJson());

class GetAttenImage {
  List<ImageView>? imageView;

  GetAttenImage({
    this.imageView,
  });

  factory GetAttenImage.fromJson(Map<String, dynamic> json) => GetAttenImage(
    imageView: List<ImageView>.from(json["ImageView"].map((x) => ImageView.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ImageView": List<dynamic>.from(imageView!.map((x) => x.toJson())),
  };
}

class ImageView {
  int? imageId;
  String? labrAttnId;
  String? imageUrl;

  ImageView({
    this.imageId,
    this.labrAttnId,
    this.imageUrl,
  });

  factory ImageView.fromJson(Map<String, dynamic> json) => ImageView(
    imageId: json["ImageId"],
    labrAttnId: json["LabrAttn_Id"],
    imageUrl: json["ImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "ImageId": imageId,
    "LabrAttn_Id": labrAttnId,
    "ImageUrl": imageUrl,
  };
}
