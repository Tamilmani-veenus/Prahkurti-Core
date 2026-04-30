// To parse this JSON data, do
//
//     final directTransfer = directTransferFromJson(jsonString);

import 'dart:convert';

DirectTransfer directTransferFromJson(String str) => DirectTransfer.fromJson(json.decode(str));

String directTransferToJson(DirectTransfer data) => json.encode(data.toJson());

class DirectTransfer {
  String? urlName;
  String? userId;
  String? deviceName;
  List<ApprovalDet>? approvalDet;

  DirectTransfer({
    this.urlName,
    this.userId,
    this.deviceName,
    this.approvalDet,
  });

  factory DirectTransfer.fromJson(Map<String, dynamic> json) => DirectTransfer(
    urlName: json["URLName"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    approvalDet: List<ApprovalDet>.from(json["ApprovalDet"].map((x) => ApprovalDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "URLName": urlName,
    "UserId": userId,
    "DeviceName": deviceName,
    "ApprovalDet": List<dynamic>.from(approvalDet!.map((x) => x.toJson())),
  };
}

class ApprovalDet {
  String? id;
  String? no;

  ApprovalDet({
   this.id,
   this.no,
  });

  factory ApprovalDet.fromJson(Map<String, dynamic> json) => ApprovalDet(
    id: json["Id"],
    no: json["No"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "No": no,
  };
}
