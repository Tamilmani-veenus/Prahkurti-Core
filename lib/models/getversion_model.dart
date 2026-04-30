import 'dart:convert';

List<AppVersionResponse> appVersionResponseFromJson(String str) => List<AppVersionResponse>.from(json.decode(str).map((x) => AppVersionResponse.fromJson(x)));

String appVersionResponseToJson(List<AppVersionResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppVersionResponse {
  AppVersionResponse({
    this.appVersion,
    this.iosVersion,
    this.iosBuild,
    this.type,
  });

  String? appVersion;
  String? iosVersion;
  int? iosBuild;
  String? type;

  factory AppVersionResponse.fromJson(Map<String, dynamic> json) => AppVersionResponse(
    appVersion: json["AppVersion"],
    iosVersion: json["iosVersion"],
    iosBuild: json["iosBuild"],
    type: json["Type"],
  );

  Map<String, dynamic> toJson() => {
    "AppVersion": appVersion,
    "iosVersion": iosVersion,
    "iosBuild": iosBuild,
    "Type": type,
  };
}
