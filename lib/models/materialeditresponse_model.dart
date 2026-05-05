// To parse this JSON data, do
//
//     final materialeditResponse = materialeditResponseFromJson(jsonString);

import 'dart:convert';

MaterialeditResponse materialeditResponseFromJson(String str) => MaterialeditResponse.fromJson(json.decode(str));

String materialeditResponseToJson(MaterialeditResponse data) => json.encode(data.toJson());

class MaterialeditResponse {
  bool? success;
  String? message;
  MaterialEditResult ? result;

  MaterialeditResponse({
    this.success,
    this.message,
    this.result,
  });

  factory MaterialeditResponse.fromJson(Map<String, dynamic> json) => MaterialeditResponse(
    success: json["success"],
    message: json["message"],
    result: MaterialEditResult .fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class MaterialEditResult  {
  MaterialEditResult ({
    this.reqId,
    this.reqNo,
    this.reqDate,
    this.reqDueDate,
    this.projectId,
    this.siteId,
    this.projectName,
    this.siteName,
    this.reqRemarks,
    this.preparedby,
    this.preparedbyName,
    this.purchaseType,
    this.purchaseVal,
    this.verifyStatus,
    this.approveStatus,
    this.preApproveStatus,
    this.requestDet,
  });

  int? reqId;
  String? reqNo;
  String? reqDate;
  String? reqDueDate;
  int? projectId;
  int? siteId;
  String? projectName;
  String? siteName;
  String? reqRemarks;
  int? preparedby;
  String? preparedbyName;
  String? purchaseType;
  String? purchaseVal;
  String? verifyStatus;
  String? approveStatus;
  String? preApproveStatus;
  List<RequestDet>? requestDet;

  factory MaterialEditResult .fromJson(Map<String, dynamic> json) => MaterialEditResult (
    reqId: json["id"],
    reqNo: json["reqOrdNo"],
    reqDate: json["reqOrdDate"],
    reqDueDate: json["reqdueDate"],
    projectId: json["projectID"],
    siteId: json["siteID"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    reqRemarks: json["reqRemarks"],
    preparedby: json["createdBy"],
    preparedbyName: json["createdName"],
    purchaseType: json["requestType"],
    purchaseVal: json["requestType"],
    verifyStatus: json["verifyStatus"],
    approveStatus: json["approveStatus"],
    preApproveStatus: json["preApproveStatus"],
    requestDet: List<RequestDet>.from(json["mMatReqMasLink"].map((x) => RequestDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": reqId,
    "reqOrdNo": reqNo,
    "reqOrdDate": reqDate,
    "reqdueDate": reqDueDate,
    "projectID": projectId,
    "siteID": siteId,
    "projectName": projectName,
    "siteName": siteName,
    "reqRemarks": reqRemarks,
    "createdBy": preparedby,
    "createdName": preparedbyName,
    "requestType": purchaseType,
    "requestType": purchaseVal,
    "verifyStatus": verifyStatus,
    "approveStatus": approveStatus,
    "preApproveStatus": preApproveStatus,
    "mMatReqMasLink": List<dynamic>.from(requestDet!.map((x) => x.toJson())),
  };
}

class RequestDet {
  RequestDet({
    this.reqDetId,
    this.matId,
    this.scaleId,
    this.matName,
    this.scale,
    this.qty,
    this.reqQty,
    this.balqty,
    this.stockqty,
    this.detRemarks,
    this.detDescription,
    this.preApproveStatus,
    this.approveStatus
  });

  int? reqDetId;
  int? matId;
  int? scaleId;
  String? matName;
  String? scale;
  double? qty;
  double? reqQty;
  double? balqty;
  double? stockqty;
  String? detRemarks;
  String? detDescription;
  String? approveStatus;
  String? preApproveStatus;

  factory RequestDet.fromJson(Map<String, dynamic> json) => RequestDet(
    reqDetId: json["id"],
    matId: json["materialID"],
    matName: json["materialName"],
    scale: json["scaleName"],
    scaleId: json["scaleID"],
    qty: json["qty"],
    reqQty: json["reqQty"],
    balqty: (json["balQty"] as num?)?.toDouble(),
    stockqty: (json["stockQty"] as num?)?.toDouble(),
    detRemarks: json["remarks"],
    detDescription: json["reqDescription"],
    preApproveStatus: json["preApproveStatus"],
    approveStatus: json["approveStatus"]
  );

  Map<String, dynamic> toJson() => {
    "id": reqDetId,
    "materialID": matId,
    "materialName": matName,
    "scaleName": scale,
    "scaleID": scaleId,
    "qty": qty,
    "reqQty": reqQty,
    "balQty": balqty,
    "stockQty": stockqty,
    "remarks": detRemarks,
    "reqDescription": detDescription,
    "approveStatus": approveStatus,
    "preApproveStatus": preApproveStatus
  };
}
