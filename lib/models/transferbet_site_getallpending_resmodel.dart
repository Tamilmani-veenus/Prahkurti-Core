// To parse this JSON data, do
//
//     final storeTransPendingView = storeTransPendingViewFromJson(jsonString);

import 'dart:convert';

StoreTransPendingView storeTransPendingViewFromJson(String str) => StoreTransPendingView.fromJson(json.decode(str));

String storeTransPendingViewToJson(StoreTransPendingView data) => json.encode(data.toJson());

class StoreTransPendingView {
  bool? success;
  String? message;
  Result? result;

  StoreTransPendingView({
    this.success,
    this.message,
    this.result,
  });

  factory StoreTransPendingView.fromJson(Map<String, dynamic> json) => StoreTransPendingView(
    success: json["success"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class Result {
  int? reqMasid;
  String? reqOrdNo;
  int? projectId;
  String? projectName;
  int? fromSiteId;
  String? fromSiteName;
  int? toSiteId;
  String? toSiteName;
  List<MReqDetList>? mReqDetList;

  Result({
    this.reqMasid,
    this.reqOrdNo,
    this.projectId,
    this.projectName,
    this.fromSiteId,
    this.fromSiteName,
    this.toSiteId,
    this.toSiteName,
    this.mReqDetList,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    reqMasid: json["ReqMasid"],
    reqOrdNo: json["ReqOrdNo"],
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    fromSiteId: json["FromSiteId"],
    fromSiteName: json["FromSiteName"],
    toSiteId: json["ToSiteId"],
    toSiteName: json["ToSiteName"],
    mReqDetList: List<MReqDetList>.from(json["mReqDetList"].map((x) => MReqDetList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReqMasid": reqMasid,
    "ReqOrdNo": reqOrdNo,
    "ProjectId": projectId,
    "ProjectName": projectName,
    "FromSiteId": fromSiteId,
    "FromSiteName": fromSiteName,
    "ToSiteId": toSiteId,
    "ToSiteName": toSiteName,
    "mReqDetList": List<dynamic>.from(mReqDetList!.map((x) => x.toJson())),
  };
}

class MReqDetList {
  int? reqdetid;
  int? reqMasid;
  int? materialid;
  String? materialName;
  String? scalename;
  double? stockQty;
  double? qty;
  double? balqty;

  MReqDetList({
    this.reqdetid,
    this.reqMasid,
    this.materialid,
    this.materialName,
    this.scalename,
    this.stockQty,
    this.qty,
    this.balqty,
  });

  factory MReqDetList.fromJson(Map<String, dynamic> json) => MReqDetList(
    reqdetid: json["Reqdetid"],
    reqMasid: json["ReqMasid"],
    materialid: json["materialid"],
    materialName: json["MaterialName"],
    scalename: json["Scalename"],
    stockQty: json["stockQty"],
    qty: json["qty"],
    balqty: json["balqty"],
  );

  Map<String, dynamic> toJson() => {
    "Reqdetid": reqdetid,
    "ReqMasid": reqMasid,
    "materialid": materialid,
    "MaterialName": materialName,
    "Scalename": scalename,
    "stockQty": stockQty,
    "qty": qty,
    "balqty": balqty,
  };
}
