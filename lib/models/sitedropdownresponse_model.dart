// To parse this JSON data, do
//
//     final siteDropdownResponse = siteDropdownResponseFromJson(jsonString);

import 'dart:convert';

SiteDropdownResponse siteDropdownResponseFromJson(String str) => SiteDropdownResponse.fromJson(json.decode(str));

String siteDropdownResponseToJson(SiteDropdownResponse data) => json.encode(data.toJson());

class SiteDropdownResponse {
  bool? success;
  String? message;
  List<Result>? result;

  SiteDropdownResponse({
    this.success,
    this.message,
    this.result,
  });

  factory SiteDropdownResponse.fromJson(Map<String, dynamic> json) =>
      SiteDropdownResponse(
        success: json["success"],
        message: json["message"], // ✅ handle message
        result: json["result"] == null
            ? []
            : List<Result>.from(
          json["result"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? siteId;
  String? siteName;

  Result({
    this.siteId,
    this.siteName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    siteId: json["id"],
    siteName: json["siteName"],
  );

  Map<String, dynamic> toJson() => {
    "id": siteId,
    "siteName": siteName,
  };
}
