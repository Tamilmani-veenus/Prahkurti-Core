// To parse this JSON data, do
//
//     final staffReqTypeResponse = staffReqTypeResponseFromJson(jsonString);

import 'dart:convert';

StaffReqTypeResponse staffReqTypeResponseFromJson(String str) => StaffReqTypeResponse.fromJson(json.decode(str));

String staffReqTypeResponseToJson(StaffReqTypeResponse data) => json.encode(data.toJson());

class StaffReqTypeResponse {
  bool? success;
  String? message;
  List<Result>? result;

  StaffReqTypeResponse({
    this.success,
    this.message,
    this.result,
  });

  factory StaffReqTypeResponse.fromJson(Map<String, dynamic> json) => StaffReqTypeResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? requisitionTypeValue;
  String? requisitionType;

  Result({
    this.id,
    this.requisitionTypeValue,
    this.requisitionType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    requisitionTypeValue: json["requisitionTypeValue"],
    requisitionType: json["requisitionType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "requisitionTypeValue": requisitionTypeValue,
    "requisitionType": requisitionType,
  };
}
