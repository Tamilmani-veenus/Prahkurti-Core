// To parse this JSON data, do
//
//     final devicemodel = devicemodelFromJson(jsonString);

import 'dart:convert';


DeviceIDmodel deviceIDmodelFromJson(String str) => DeviceIDmodel.fromJson(json.decode(str));

String deviceIDmodelToJson(DeviceIDmodel data) => json.encode(data.toJson());

class DeviceIDmodel {
  String deviceId;

  DeviceIDmodel({
    required this.deviceId,
  });

  factory DeviceIDmodel.fromJson(Map<String, dynamic> json) => DeviceIDmodel(
    deviceId: json["DeviceID"],
  );

  Map<String, dynamic> toJson() => {
    "DeviceID": deviceId,
  };
}


Devicemodel devicemodelFromJson(String str) => Devicemodel.fromJson(json.decode(str));

String devicemodelToJson(Devicemodel data) => json.encode(data.toJson());

class Devicemodel {
  String? retString;

  Devicemodel({
    this.retString,
  });

  factory Devicemodel.fromJson(Map<String, dynamic> json) => Devicemodel(
    retString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": retString,
  };
}
