import 'dart:convert';

MrnfinalapprovalApprovalResmodel mrnfinalapprovalApprovalResmodelFromJson(String str) => MrnfinalapprovalApprovalResmodel.fromJson(json.decode(str));

String mrnfinalapprovalApprovalResmodelToJson(MrnfinalapprovalApprovalResmodel data) => json.encode(data.toJson());

class MrnfinalapprovalApprovalResmodel {
  MrnfinalapprovalApprovalResmodel({
    this.reqId,
    this.reqNo,
    this.reqDate,
    this.reqDueDate,
    this.projectId,
    this.siteId,
    this.appNo,
    this.appDate,
    this.approvedby,
    this.appRemarks,
    this.reqRemarks,
    this.preparedBy,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.requestAppDet,
  });

  String? reqId;
  String? reqNo;
  String? reqDate;
  String? reqDueDate;
  String? projectId;
  String? siteId;
  String? appNo;
  String? appDate;
  String? approvedby;
  String? appRemarks;
  String? reqRemarks;
  String? preparedBy;
  String? userId;
  String? entryMode;
  String? deviceName;
  List<RequestAppDet>? requestAppDet;

  factory MrnfinalapprovalApprovalResmodel.fromJson(Map<String, dynamic> json) => MrnfinalapprovalApprovalResmodel(
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    reqDate: json["ReqDate"],
    reqDueDate: json["ReqDueDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    appNo: json["AppNo"],
    appDate: json["AppDate"],
    approvedby: json["Approvedby"],
    appRemarks: json["AppRemarks"],
    reqRemarks: json["ReqRemarks"],
    preparedBy: json["PreparedBy"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    requestAppDet: List<RequestAppDet>.from(json["RequestAppDet"].map((x) => RequestAppDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "ReqNo": reqNo,
    "ReqDate": reqDate,
    "ReqDueDate": reqDueDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "AppNo": appNo,
    "AppDate": appDate,
    "Approvedby": approvedby,
    "AppRemarks": appRemarks,
    "ReqRemarks": reqRemarks,
    "PreparedBy": preparedBy,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "RequestAppDet": List<dynamic>.from(requestAppDet!.map((x) => x.toJson())),
  };
}

class RequestAppDet {
  RequestAppDet({
    this.matId,
    this.reqDetId,
    this.scale,
    this.qty,
    this.appQty,
    this.appType,
    this.transferFrom,
    this.detRemarks,
    this.detDescription,
  });

  String? matId;
  String? reqDetId;
  String? scale;
  String? qty;
  String? appQty;
  String? appType;
  String? transferFrom;
  String? detRemarks;
  String? detDescription;

  factory RequestAppDet.fromJson(Map<String, dynamic> json) => RequestAppDet(
    matId: json["MatId"],
    reqDetId: json["ReqDetId"],
    scale: json["Scale"],
    qty: json["Qty"],
    appQty: json["AppQty"],
    appType: json["AppType"],
    transferFrom: json["TransferFrom"],
    detRemarks: json["DetRemarks"],
    detDescription: json["DetDescription"],
  );

  Map<String, dynamic> toJson() => {
    "MatId": matId,
    "ReqDetId": reqDetId,
    "Scale": scale,
    "Qty": qty,
    "AppQty": appQty,
    "AppType": appType,
    "TransferFrom": transferFrom,
    "DetRemarks": detRemarks,
    "DetDescription": detDescription,
  };
}
