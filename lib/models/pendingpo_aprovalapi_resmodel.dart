import 'dart:convert';

PendingPoapprovalApiResmodel pendingPoapprovalApiResmodelFromJson(String str) => PendingPoapprovalApiResmodel.fromJson(json.decode(str));

String pendingPoapprovalApiResmodelToJson(PendingPoapprovalApiResmodel data) => json.encode(data.toJson());

class PendingPoapprovalApiResmodel {
  PendingPoapprovalApiResmodel({
    this.urlName,
    this.userId,
    this.deviceName,
    this.approvalDet,
  });

  String? urlName;
  String? userId;
  String? deviceName;
  List<ApprovalDet>? approvalDet;

  factory PendingPoapprovalApiResmodel.fromJson(Map<String, dynamic> json) => PendingPoapprovalApiResmodel(
    urlName: json["URLName"],
    userId: json["UserId"],
    deviceName: "DeviceName",
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
  ApprovalDet({
    this.id,
    this.no,
    this.poWoType,
    this.projectId,
  });

  int? id;
  String? no;
  String?poWoType;
  String?projectId;

  factory ApprovalDet.fromJson(Map<String, dynamic> json) => ApprovalDet(
    id: json["Id"],
    no: json["No"],
    poWoType:json["poWoType"],
    projectId:json["ProjectId"],
  );

  Map<String, dynamic> toJson()  {
  final data = {
    "Id": id,
    "No": no,
    "poWoType":poWoType,
    "ProjectId":projectId,
  };

  data.removeWhere((key, value) => value == null);
  return data;

  }
}
