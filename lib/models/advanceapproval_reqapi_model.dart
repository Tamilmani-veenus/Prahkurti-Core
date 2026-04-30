import 'dart:convert';

AdvanceApprovalApiReq advanceApprovalApiReqFromJson(String str) => AdvanceApprovalApiReq.fromJson(json.decode(str));

String advanceApprovalApiReqToJson(AdvanceApprovalApiReq data) => json.encode(data.toJson());

class AdvanceApprovalApiReq {
  AdvanceApprovalApiReq({
    this.urlName,
    this.userId,
    this.deviceName,
    this.advApprovalDet,
  });

  String? urlName;
  String? userId;
  String? deviceName;
  List<AdvApprovalDet>? advApprovalDet;

  factory AdvanceApprovalApiReq.fromJson(Map<String, dynamic> json) => AdvanceApprovalApiReq(
    urlName: json["URLName"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    advApprovalDet: List<AdvApprovalDet>.from(json["AdvApprovalDet"].map((x) => AdvApprovalDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "URLName": urlName,
    "UserId": userId,
    "DeviceName": deviceName,
    "AdvApprovalDet": List<dynamic>.from(advApprovalDet!.map((x) => x.toJson())),
  };
}

class AdvApprovalDet {
  AdvApprovalDet({
    this.id,
    this.no,
  });

  int? id;
  String? no;

  factory AdvApprovalDet.fromJson(Map<String, dynamic> json) => AdvApprovalDet(
    id: json["Id"],
    no: json["No"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "No": no,
  };
}
