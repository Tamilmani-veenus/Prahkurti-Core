import 'dart:convert';

ImagePayload imagePayloadFromJson(String str) => ImagePayload.fromJson(json.decode(str));

String imagePayloadToJson(ImagePayload data) => json.encode(data.toJson());

class ImagePayload {
  String? entryMode;
  String? inwardId;
  String? inwardNo;

  ImagePayload({
    this.entryMode,
    this.inwardId,
    this.inwardNo,
  });

  factory ImagePayload.fromJson(Map<String, dynamic> json) => ImagePayload(
    entryMode: json["EntryMode"],
    inwardId: json["InwardId"],
    inwardNo: json["Inward_No"],
  );

  Map<String, dynamic> toJson() => {
    "EntryMode": entryMode,
    "InwardId": inwardId,
    "Inward_No": inwardNo,
  };
}
