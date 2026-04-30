// To parse this JSON data, do
//
//     final advanceReqDeleteModel = advanceReqDeleteModelFromJson(jsonString);

import 'dart:convert';

AdvanceReqDeleteModel advanceReqDeleteModelFromJson(String str) => AdvanceReqDeleteModel.fromJson(json.decode(str));

String advanceReqDeleteModelToJson(AdvanceReqDeleteModel data) => json.encode(data.toJson());

class AdvanceReqDeleteModel {
  List<int> vocIds;
  List<String> vocNos;
  String userId;
  String deviceName;

  AdvanceReqDeleteModel({
    required this.vocIds,
    required this.vocNos,
    required this.userId,
    required this.deviceName,
  });

  factory AdvanceReqDeleteModel.fromJson(Map<String, dynamic> json) => AdvanceReqDeleteModel(
    vocIds: List<int>.from(json["VocIds"].map((x) => x)),
    vocNos: List<String>.from(json["VocNos"].map((x) => x)),
    userId: json["UserId"],
    deviceName: json["DeviceName"],
  );

  Map<String, dynamic> toJson() => {
    "VocIds": List<dynamic>.from(vocIds.map((x) => x)),
    "VocNos": List<dynamic>.from(vocNos.map((x) => x)),
    "UserId": userId,
    "DeviceName": deviceName,
  };
}


AdvanceResponseDeleteModel advanceResponseDeleteModelFromJson(String str) =>
    AdvanceResponseDeleteModel.fromJson(json.decode(str));

String advanceResponseDeleteModelToJson(AdvanceResponseDeleteModel data) =>
    json.encode(data.toJson());

class AdvanceResponseDeleteModel {
  AdvanceResponseDeleteModel({
    this.retString,
  });

  String? retString; // Use camelCase for variable names

  // Factory constructor to create an instance from JSON
  factory AdvanceResponseDeleteModel.fromJson(Map<String, dynamic> json) =>
      AdvanceResponseDeleteModel(
        retString: json["RetString"],
      );

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
    "RetString": retString,
  };
}