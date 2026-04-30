
import 'dart:convert';

List<MrnListReportsResponse> mrnListReportsResponseFromJson(String str) => List<MrnListReportsResponse>.from(json.decode(str).map((x) => MrnListReportsResponse.fromJson(x)));

String mrnListReportsResponseToJson(List<MrnListReportsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MrnListReportsResponse {
  MrnListReportsResponse({
    this.mrnReqId,
    this.mrnReqNo,
    this.mrnReqDate,
    this.projectName,
    this.siteName,
    this.mrnReqStatus,
    this.deviceName,
    this.purchaseType,
  });

  int? mrnReqId;
  String? mrnReqNo;
  String? mrnReqDate;
  String? projectName;
  String? siteName;
  String? mrnReqStatus;
  String? deviceName;
  String? purchaseType;

  factory MrnListReportsResponse.fromJson(Map<String, dynamic> json) => MrnListReportsResponse(
    mrnReqId: json["MrnReqId"],
    mrnReqNo: json["MrnReqNo"],
    mrnReqDate: json["MrnReqDate"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    mrnReqStatus: json["MrnReqStatus"],
    deviceName: json["DeviceName"],
    purchaseType: json["PurchaseType"],
  );

  Map<String, dynamic> toJson() => {
    "MrnReqId": mrnReqId,
    "MrnReqNo": mrnReqNo,
    "MrnReqDate": mrnReqDate,
    "ProjectName": projectName,
    "SiteName": siteName,
    "MrnReqStatus": mrnReqStatus,
    "DeviceName": deviceName,
    "PurchaseType" : purchaseType,
  };
}

