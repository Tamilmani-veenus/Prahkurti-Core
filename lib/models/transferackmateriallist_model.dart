// To parse this JSON data, do
//
//     final transferAckMatList = transferAckMatListFromJson(jsonString);

import 'dart:convert';

List<TransferAckMatList> transferAckMatListFromJson(String str) => List<TransferAckMatList>.from(json.decode(str).map((x) => TransferAckMatList.fromJson(x)));

String transferAckMatListToJson(List<TransferAckMatList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferAckMatList {
  int? materialid;
  String? material;
  String? scale;
  double? qty;
  String? ackStatus;

  TransferAckMatList({
    this.materialid,
    this.material,
    this.scale,
    this.qty,
    this.ackStatus,
  });

  factory TransferAckMatList.fromJson(Map<String, dynamic> json) => TransferAckMatList(
    materialid: json["materialid"],
    material: json["Material"],
    scale: json["Scale"],
    qty: json["Qty"],
    ackStatus: json["Ack_status"],
  );

  Map<String, dynamic> toJson() => {
    "materialid": materialid,
    "Material": material,
    "Scale": scale,
    "Qty": qty,
    "Ack_status": ackStatus,
  };
}
