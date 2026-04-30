// To parse this JSON data, do
//
//     final staffNameResponse = staffNameResponseFromJson(jsonString);

import 'dart:convert';

StaffNameResponse staffNameResponseFromJson(String str) => StaffNameResponse.fromJson(json.decode(str));

String staffNameResponseToJson(StaffNameResponse data) => json.encode(data.toJson());

class StaffNameResponse {
  bool? success;
  String? message;
  List<Result>? result;

  StaffNameResponse({
    this.success,
    this.message,
    this.result,
  });

  factory StaffNameResponse.fromJson(Map<String, dynamic> json) => StaffNameResponse(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? staffName;

  Result({
    this.id,
    this.staffName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    staffName: json["staffName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "staffName": staffName,
  };
}
