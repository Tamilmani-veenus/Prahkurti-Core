// To parse this JSON data, do
//
//     final mrnReqTrackerListModel = mrnReqTrackerListModelFromJson(jsonString);

import 'dart:convert';

MrnReqTrackerListModel mrnReqTrackerListModelFromJson(String str) => MrnReqTrackerListModel.fromJson(json.decode(str));

String mrnReqTrackerListModelToJson(MrnReqTrackerListModel data) => json.encode(data.toJson());

class MrnReqTrackerListModel {
  bool? success;
  String? message;
  List<ReqTrackResult>? result;

  MrnReqTrackerListModel({
    this.success,
    this.message,
    this.result,
  });

  factory MrnReqTrackerListModel.fromJson(Map<String, dynamic> json) => MrnReqTrackerListModel(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<ReqTrackResult>.from(json["result"].map((x) => ReqTrackResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class ReqTrackResult {
  String? projectName;
  String? siteName;
  String? mrnNo;
  int? sno;
  String? material;
  String? unit;
  double? reqQty;
  String? mrnDate;
  String? mrnTime;
  String? mrnPreparedBy;
  String? verifyDate;
  String? verifyTime;
  String? verifyBy;
  String? preAppovedDate;
  String? preApprovedTime;
  String? preApprovedBy;
  String? approveDate;
  String? approvedTime;
  String? approvedBy;
  double? appQty;
  String? poDate;
  String? poTime;
  String? poNo;
  double? poQty;
  String? poBy;
  String? poVerifyDate;
  String? poVerifyTime;
  String? poVerifyBy;
  String? poAppDate;
  String? poAppBy;
  String? poApprovedTime;
  String? invoiceDate;
  String? invoiceNo;
  int? inwardMasId;
  String? inwardDate;
  String? grnCreatedTime;
  String? inwardNo;
  double? inwQty;
  String? inwardBy;
  int? supplierQuoteMasId;
  String? quoteNo;
  String? quoteDate;
  int? quoteDetId;
  int? materialReqOrdDetId;
  int? materialId;
  int? quoteCreatedBy;
  String? quoteCreatedByName;
  String? quoteCreatedDate;
  String? quoteCreatedTime;
  String? quoteVerifyStatus;
  String? quoteVerifyDate;
  int? quoteVerifyBy;
  String? quoteApproveStatus;
  String? quoteApproveDate;
  int? quoteApproveBy;
  String? mrnVerifyStatus;
  String? mrnPreApproveStatus;
  String? mrnApproveStatus;
  String? poVerifyStatus;
  String? poApproveStatus;

  ReqTrackResult({
    this.projectName,
    this.siteName,
    this.mrnNo,
    this.sno,
    this.material,
    this.unit,
    this.reqQty,
    this.mrnDate,
    this.mrnTime,
    this.mrnPreparedBy,
    this.verifyDate,
    this.verifyTime,
    this.verifyBy,
    this.preAppovedDate,
    this.preApprovedTime,
    this.preApprovedBy,
    this.approveDate,
    this.approvedTime,
    this.approvedBy,
    this.appQty,
    this.poDate,
    this.poTime,
    this.poNo,
    this.poQty,
    this.poBy,
    this.poVerifyDate,
    this.poVerifyTime,
    this.poApprovedTime,
    this.poVerifyBy,
    this.poAppDate,
    this.poAppBy,
    this.invoiceDate,
    this.invoiceNo,
    this.inwardMasId,
    this.inwardDate,
    this.grnCreatedTime,
    this.inwardNo,
    this.inwQty,
    this.inwardBy,
    this.supplierQuoteMasId,
    this.quoteNo,
    this.quoteDate,
    this.quoteDetId,
    this.materialReqOrdDetId,
    this.materialId,
    this.quoteCreatedBy,
    this.quoteCreatedByName,
    this.quoteCreatedDate,
    this.quoteCreatedTime,
    this.quoteVerifyStatus,
    this.quoteVerifyDate,
    this.quoteVerifyBy,
    this.quoteApproveStatus,
    this.quoteApproveDate,
    this.quoteApproveBy,
    this.mrnVerifyStatus,
    this.mrnPreApproveStatus,
    this.mrnApproveStatus,
    this.poVerifyStatus,
    this.poApproveStatus,
  });

  factory ReqTrackResult.fromJson(Map<String, dynamic> json) => ReqTrackResult(
    projectName: json["projectName"],
    siteName: json["siteName"],
    mrnNo: json["mrnNo"],
    sno: json["sno"],
    material: json["material"],
    unit: json["unit"],
    reqQty: json["reqQty"],
    mrnDate: json["mrnDate"],
    mrnTime: json["mrnTime"],
    mrnPreparedBy: json["mrnPreparedBy"],
    verifyDate: json["verifyDate"],
    verifyTime: json["verifyTime"],
    verifyBy: json["verifyBy"],
    preAppovedDate: json["preAppovedDate"],
    preApprovedTime: json["preApprovedTime"],
    preApprovedBy: json["preApprovedBy"],
    approveDate: json["approveDate"],
    approvedTime: json["approvedTime"],
    approvedBy: json["approvedBy"],
    appQty: json["appQty"],
    poDate: json["poDate"],
    poTime: json["poTime"],
    poNo: json["poNo"],
    poQty: json["poQty"],
    poBy: json["poBy"],
    poVerifyDate: json["poVerifyDate"],
    poVerifyTime: json["poVerifyTime"],
    poVerifyBy: json["poVerifyBy"],
    poAppDate: json["poAppDate"],
    poApprovedTime: json["poApprovedTime"],
    poAppBy: json["poAppBy"],
    invoiceDate: json["invoiceDate"],
    invoiceNo: json["invoiceNo"],
    inwardMasId: json["inwardMasID"],
    inwardDate: json["inwardDate"],
    inwardNo: json["inwardNo"],
    grnCreatedTime: json["grnCreatedTime"],
    inwQty: json["inwQty"],
    inwardBy: json["inwardBy"],
    supplierQuoteMasId: json["supplierQuoteMasId"],
    quoteNo: json["quoteNo"],
    quoteDate: json["quoteDate"],
    quoteDetId: json["quoteDetId"],
    materialReqOrdDetId: json["materialReqOrdDetId"],
    materialId: json["materialId"],
    quoteCreatedBy: json["quoteCreatedBy"],
    quoteCreatedByName: json["quoteCreatedByName"],
    quoteCreatedDate: json["quoteCreatedDate"],
    quoteCreatedTime: json["quoteCreatedTime"],
    quoteVerifyStatus: json["quoteVerifyStatus"],
    quoteVerifyDate: json["quoteVerifyDate"],
    quoteVerifyBy: json["quoteVerifyBy"],
    quoteApproveStatus: json["quoteApproveStatus"],
    quoteApproveDate: json["quoteApproveDate"],
    quoteApproveBy: json["quoteApproveBy"],
    mrnVerifyStatus: json["mrnVerifyStatus"],
    mrnPreApproveStatus: json["mrnPreApproveStatus"],
    mrnApproveStatus: json["mrnApproveStatus"],
    poVerifyStatus: json["poVerifyStatus"],
    poApproveStatus: json["poApproveStatus"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "siteName": siteName,
    "mrnNo": mrnNo,
    "sno": sno,
    "material": material,
    "unit": unit,
    "reqQty": reqQty,
    "mrnDate": mrnDate,
    "mrnTime": mrnTime,
    "mrnPreparedBy": mrnPreparedBy,
    "verifyDate": verifyDate,
    "verifyTime": verifyTime,
    "verifyBy": verifyBy,
    "preAppovedDate": preAppovedDate,
    "preApprovedTime": preApprovedTime,
    "preApprovedBy": preApprovedBy,
    "poApprovedTime": poApprovedTime,
    "approveDate": approveDate,
    "approvedTime": approvedTime,
    "grnCreatedTime": grnCreatedTime,
    "approvedBy": approvedBy,
    "appQty": appQty,
    "poDate": poDate,
    "poTime": poTime,
    "poNo": poNo,
    "poQty": poQty,
    "poBy": poBy,
    "poVerifyDate": poVerifyDate,
    "poVerifyTime": poVerifyTime,
    "poVerifyBy": poVerifyBy,
    "poAppDate": poAppDate,
    "poAppBy": poAppBy,
    "invoiceDate": invoiceDate,
    "invoiceNo": invoiceNo,
    "inwardMasID": inwardMasId,
    "inwardDate": inwardDate,
    "inwardNo": inwardNo,
    "inwQty": inwQty,
    "inwardBy": inwardBy,
    "supplierQuoteMasId": supplierQuoteMasId,
    "quoteNo": quoteNo,
    "quoteDate": quoteDate,
    "quoteDetId": quoteDetId,
    "materialReqOrdDetId": materialReqOrdDetId,
    "materialId": materialId,
    "quoteCreatedBy": quoteCreatedBy,
    "quoteCreatedByName": quoteCreatedByName,
    "quoteCreatedDate": quoteCreatedDate,
    "quoteCreatedTime": quoteCreatedTime,
    "quoteVerifyStatus": quoteVerifyStatus,
    "quoteVerifyDate": quoteVerifyDate,
    "quoteVerifyBy": quoteVerifyBy,
    "quoteApproveStatus": quoteApproveStatus,
    "quoteApproveDate": quoteApproveDate,
    "quoteApproveBy": quoteApproveBy,
    "mrnVerifyStatus": mrnVerifyStatus,
    "mrnPreApproveStatus": mrnPreApproveStatus,
    "mrnApproveStatus": mrnApproveStatus,
    "poVerifyStatus": poVerifyStatus,
    "poApproveStatus": poApproveStatus,
  };
}
