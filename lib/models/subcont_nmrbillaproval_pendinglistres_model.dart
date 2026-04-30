import 'dart:convert';

SubContNmrBillAprovalPendinglistRes subContNmrBillAprovalPendinglistResFromJson(String str) => SubContNmrBillAprovalPendinglistRes.fromJson(json.decode(str));

String subContNmrBillAprovalPendinglistResToJson(SubContNmrBillAprovalPendinglistRes data) => json.encode(data.toJson());

class SubContNmrBillAprovalPendinglistRes {
  SubContNmrBillAprovalPendinglistRes({
    this.urlName,
    this.userId,
    this.deviceName,
    this.nmrApprovalDet,
  });

  String? urlName;
  String? userId;
  String? deviceName;
  List<NmrApprovalDet>? nmrApprovalDet;

  factory SubContNmrBillAprovalPendinglistRes.fromJson(Map<String, dynamic> json) => SubContNmrBillAprovalPendinglistRes(
    urlName: json["URLName"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    nmrApprovalDet: List<NmrApprovalDet>.from(json["NMRApprovalDet"].map((x) => NmrApprovalDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "URLName": urlName,
    "UserId": userId,
    "DeviceName": deviceName,
    "NMRApprovalDet": List<dynamic>.from(nmrApprovalDet!.map((x) => x.toJson())),
  };
}

class NmrApprovalDet {
  NmrApprovalDet({
    this.id,
    this.no,
  });

  int? id;
  String? no;

  factory NmrApprovalDet.fromJson(Map<String, dynamic> json) => NmrApprovalDet(
    id: json["Id"],
    no: json["No"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "No": no,
  };
}






BillGenBoqApprovalReq billGenBoqApprovalReqFromJson(String str) => BillGenBoqApprovalReq.fromJson(json.decode(str));

String billGenBoqApprovalReqToJson(BillGenBoqApprovalReq data) => json.encode(data.toJson());

class BillGenBoqApprovalReq {
  BillGenBoqApprovalReq({
    this.urlName,
    this.userId,
    this.deviceName,
    this.directApprovalDet,
  });

  String? urlName;
  String? userId;
  String? deviceName;
  List<DirectApprovalDet>? directApprovalDet;

  factory BillGenBoqApprovalReq.fromJson(Map<String, dynamic> json) => BillGenBoqApprovalReq(
    urlName: json["URLName"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    directApprovalDet: List<DirectApprovalDet>.from(json["DirectApprovalDet"].map((x) => DirectApprovalDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "URLName": urlName,
    "UserId": userId,
    "DeviceName": deviceName,
    "DirectApprovalDet": List<dynamic>.from(directApprovalDet!.map((x) => x.toJson())),
  };
}

class DirectApprovalDet {
  DirectApprovalDet({
    this.id,
    this.no,
  });

  int? id;
  String? no;

  factory DirectApprovalDet.fromJson(Map<String, dynamic> json) => DirectApprovalDet(
    id: json["Id"],
    no: json["No"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "No": no,
  };
}

