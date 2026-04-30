import 'dart:convert';

PunchInapprovalApiResmodel punchInapprovalApiResmodelFromJson(String str) => PunchInapprovalApiResmodel.fromJson(json.decode(str));

String punchInapprovalApiResmodelToJson(PunchInapprovalApiResmodel data) => json.encode(data.toJson());

class PunchInapprovalApiResmodel {
  PunchInapprovalApiResmodel({
    this.urlName,
    this.userId,
    this.deviceName,
    this.approvalDet,
  });

  String? urlName;
  String? userId;
  String? deviceName;
  List<ApprovalPunchInDet>? approvalDet;

  factory PunchInapprovalApiResmodel.fromJson(Map<String, dynamic> json) => PunchInapprovalApiResmodel(
    urlName: json["URLName"],
    userId: json["UserId"],
    deviceName: "DeviceName",
    approvalDet: List<ApprovalPunchInDet>.from(json["ApprovalDet"].map((x) => ApprovalPunchInDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "URLName": urlName,
    "UserId": userId,
    "DeviceName": deviceName,
    "ApprovalDet": List<dynamic>.from(approvalDet!.map((x) => x.toJson())),
  };
}

class ApprovalPunchInDet {
  ApprovalPunchInDet({
    this.id,
    this.no,
  });

  int? id;
  String? no;

  factory ApprovalPunchInDet.fromJson(Map<String, dynamic> json) => ApprovalPunchInDet(
    id: json["Id"],
    no: json["No"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "No": no,
  };
}
