// To parse this JSON data, do
//
//     final dailyEntrysubcontRightsEntrylistRes = dailyEntrysubcontRightsEntrylistResFromJson(jsonString);

import 'dart:convert';

DailyEntrysubcontRightsEntrylistRes dailyEntrysubcontRightsEntrylistResFromJson(String str) => DailyEntrysubcontRightsEntrylistRes.fromJson(json.decode(str));

String dailyEntrysubcontRightsEntrylistResToJson(DailyEntrysubcontRightsEntrylistRes data) => json.encode(data.toJson());

class DailyEntrysubcontRightsEntrylistRes {
  bool? success;
  Result? result;
  String? message;

  DailyEntrysubcontRightsEntrylistRes({
    this.success,
    this.result,
    this.message,
  });

  factory DailyEntrysubcontRightsEntrylistRes.fromJson(Map<String, dynamic> json) => DailyEntrysubcontRightsEntrylistRes(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  bool? allowAdd;
  bool? allowEdit;
  bool? allowDelete;

  Result({
    this.allowAdd,
    this.allowEdit,
    this.allowDelete,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    allowAdd: json["allowAdd"],
    allowEdit: json["allowEdit"],
    allowDelete: json["allowDelete"],
  );

  Map<String, dynamic> toJson() => {
    "allowAdd": allowAdd,
    "allowEdit": allowEdit,
    "allowDelete": allowDelete,
  };
}
