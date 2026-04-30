import 'dart:convert';

SetProjectLocation setProjectLocationFromJson(String str) => SetProjectLocation.fromJson(json.decode(str));

String setProjectLocationToJson(SetProjectLocation data) => json.encode(data.toJson());

class SetProjectLocation {
  String retString;

  SetProjectLocation({
    required this.retString,
  });

  factory SetProjectLocation.fromJson(Map<String, dynamic> json) => SetProjectLocation(
    retString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": retString,
  };
}
