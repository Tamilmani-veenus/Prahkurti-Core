// To parse this JSON data, do
//
//     final materiasaveResPreIndent = materiasaveResPreIndentFromJson(jsonString);

import 'dart:convert';

MateriasaveResPreIndent materiasaveResPreIndentFromJson(String str) => MateriasaveResPreIndent.fromJson(json.decode(str));

String materiasaveResPreIndentToJson(MateriasaveResPreIndent data) => json.encode(data.toJson());

class MateriasaveResPreIndent {

  MateriasaveResPreIndent({
    this.reqId,
    this.reqNo,
    this.reqDate,
    this.reqDueDate,
    this.projectId,
    this.preparedBy,
    this.siteId,
    this.userId,
    this.entryMode,
    this.deviceName,
    this.reqRemarks,
    this.VerifyBy,
    this.Approvedby,
    this.requestPurType,
    this.requestPreIndentDet,
  });

  String? reqId;
  String? reqNo;
  String? reqDate;
  String? reqDueDate;
  String? projectId;
  String? preparedBy;
  String? siteId;
  String? userId;
  String? entryMode;
  String? deviceName;
  String? reqRemarks;
  String? VerifyBy;
  String? Approvedby;
  String? requestPurType;
  List<RequestPreIndentDet>? requestPreIndentDet;

  factory MateriasaveResPreIndent.fromJson(Map<String, dynamic> json) => MateriasaveResPreIndent(
    reqId: json["ReqId"],
    reqNo: json["ReqNo"],
    reqDate: json["ReqDate"],
    reqDueDate: json["ReqDueDate"],
    projectId: json["ProjectId"],
    preparedBy: json["PreparedBy"],
    siteId: json["SiteId"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
    reqRemarks: json["ReqRemarks"],
    VerifyBy: json["VerifyBy"],
    Approvedby: json["Approvedby"],
    requestPurType: json["PurchasType"],
    requestPreIndentDet: List<RequestPreIndentDet>.from(json["RequestPreIndentDet"].map((x) => RequestPreIndentDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReqId": reqId,
    "ReqNo": reqNo,
    "ReqDate": reqDate,
    "ReqDueDate": reqDueDate,
    "ProjectId": projectId,
    "PreparedBy": preparedBy,
    "SiteId": siteId,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
    "ReqRemarks": reqRemarks,
    "VerifyBy": VerifyBy,
    "Approvedby": Approvedby,
    "PurchasType": requestPurType,
    "RequestPreIndentDet": List<dynamic>.from(requestPreIndentDet!.map((x) => x.toJson())),
  };
}

class RequestPreIndentDet {
  RequestPreIndentDet({
    this.matId,
    this.scale,
    this.qty,
    this.detRemarks,
    this.detDescription,
  });

  String? matId;
  String? scale;
  String? qty;
  String? detRemarks;
  String? detDescription;


  factory RequestPreIndentDet.fromJson(Map<String, dynamic> json) => RequestPreIndentDet(
    matId: json["MatId"],
    scale: json["Scale"],
    qty: json["Qty"],
    detRemarks: json["DetRemarks"],
    detDescription: json["DetDescription"],
  );

  Map<String, dynamic> toJson() => {
    "MatId": matId,
    "Scale": scale,
    "Qty": qty,
    "DetRemarks": detRemarks,
    "DetDescription": detDescription,
  };
}
