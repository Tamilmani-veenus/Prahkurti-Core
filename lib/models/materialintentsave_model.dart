// // To parse this JSON data, do
// //
// //     final materiasaveResponse = materiasaveResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// MateriasaveResponse materiasaveResponseFromJson(String str) => MateriasaveResponse.fromJson(json.decode(str));
//
// String materiasaveResponseToJson(MateriasaveResponse data) => json.encode(data.toJson());
//
// class MateriasaveResponse {
//   MateriasaveResponse({
//     this.reqId,
//     this.reqNo,
//     this.reqDate,
//     this.reqDueDate,
//     this.projectId,
//     this.preparedBy,
//     this.siteId,
//     this.userId,
//     this.entryMode,
//     this.deviceName,
//     this.reqRemarks,
//     this.requestDet,
//     this.Approvedby,
//     this.requestPurType,
//   });
//
//   String? reqId;
//   String? reqNo;
//   String? reqDate;
//   String? reqDueDate;
//   String? projectId;
//   String? preparedBy;
//   String? siteId;
//   String? userId;
//   String? entryMode;
//   String? deviceName;
//   String? reqRemarks;
//   String? Approvedby;
//   String? requestPurType;
//   List<RequestDet>? requestDet;
//
//   factory MateriasaveResponse.fromJson(Map<String, dynamic> json) => MateriasaveResponse(
//     reqId: json["ReqId"],
//     reqNo: json["ReqNo"],
//     reqDate: json["ReqDate"],
//     reqDueDate: json["ReqDueDate"],
//     projectId: json["ProjectId"],
//     preparedBy: json["PreparedBy"],
//     siteId: json["SiteId"],
//     userId: json["UserId"],
//     entryMode: json["EntryMode"],
//     deviceName: json["DeviceName"],
//     reqRemarks: json["ReqRemarks"],
//     Approvedby: json["Approvedby"],
//     requestPurType: json["PucrhaseType"],
//     requestDet: List<RequestDet>.from(json["RequestDet"].map((x) => RequestDet.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ReqId": reqId,
//     "ReqNo": reqNo,
//     "ReqDate": reqDate,
//     "ReqDueDate": reqDueDate,
//     "ProjectId": projectId,
//     "PreparedBy": preparedBy,
//     "SiteId": siteId,
//     "UserId": userId,
//     "EntryMode": entryMode,
//     "DeviceName": deviceName,
//     "ReqRemarks": reqRemarks,
//     "Approvedby": Approvedby,
//     "PucrhaseType": requestPurType,
//     "RequestDet": List<dynamic>.from(requestDet!.map((x) => x.toJson())),
//   };
// }
//
// class RequestDet {
//   RequestDet({
//     this.matId,
//     this.scale,
//     this.scaleId,
//     this.qty,
//     this.detRemarks,
//     this.detDescription,
//   });
//
//   String? matId;
//   String? scale;
//   String? scaleId;
//   String? qty;
//   String? detRemarks;
//   String? detDescription;
//
//   factory RequestDet.fromJson(Map<String, dynamic> json) => RequestDet(
//     matId: json["MatId"],
//     scale: json["Scale"],
//     scaleId: json["scaleId"],
//     qty: json["Qty"],
//     detRemarks: json["DetRemarks"],
//     detDescription: json["DetDescription"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "MatId": matId,
//     "Scale": scale,
//     "scaleId": scaleId,
//     "Qty": qty,
//     "DetRemarks": detRemarks,
//     "DetDescription": detDescription,
//   };
// }



// To parse this JSON data, do
//
//     final materiasaveResponse = materiasaveResponseFromJson(jsonString);

import 'dart:convert';

MateriasaveResponse materiasaveResponseFromJson(String str) => MateriasaveResponse.fromJson(json.decode(str));

String materiasaveResponseToJson(MateriasaveResponse data) => json.encode(data.toJson());

class MateriasaveResponse {
  int? id;
  String? reqOrdNo;
  String? reqOrdDate;
  String? reqdueDate;
  int? projectId;
  int? siteId;
  String? reqRemarks;
  String? approveRemarks;
  String? approveStatus;
  int? verifyBy;
  String? verifyStatus;
  String? requestType;
  String? verifyDate;
  int? createdBy;
  String? createdDt;
  bool? isEdit;
  String? updatedDate;
  int? updatedBy;
  String? projectName;
  String? fromProjectName;
  String? siteName;
  String? createdName;
  String? verifyName;
  String? approvedName;
  String? approveNo;
  int? preApproveBy;
  String? preApproveStatus;
  String? preApproveDate;
  int? approvedBy;
  String? approveDate;
  List<MMatReqMasLink>? mMatReqMasLink;

  MateriasaveResponse({
    this.id,
    this.reqOrdNo,
    this.reqOrdDate,
    this.reqdueDate,
    this.projectId,
    this.siteId,
    this.reqRemarks,
    this.approveRemarks,
    this.approveStatus,
    this.verifyBy,
    this.verifyStatus,
    this.requestType,
    this.verifyDate,
    this.createdBy,
    this.createdDt,
    this.isEdit,
    this.updatedDate,
    this.updatedBy,
    this.projectName,
    this.fromProjectName,
    this.siteName,
    this.createdName,
    this.verifyName,
    this.approvedName,
    this.approveNo,
    this.preApproveBy,
    this.preApproveStatus,
    this.preApproveDate,
    this.approvedBy,
    this.approveDate,
    this.mMatReqMasLink,
  });

  factory MateriasaveResponse.fromJson(Map<String, dynamic> json) => MateriasaveResponse(
    id: json["id"],
    reqOrdNo: json["reqOrdNo"],
    reqOrdDate: json["reqOrdDate"],
    reqdueDate: json["reqdueDate"],
    projectId: json["projectID"],
    siteId: json["siteID"],
    reqRemarks: json["reqRemarks"],
    approveRemarks: json["approveRemarks"],
    approveStatus: json["approveStatus"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    requestType: json["requestType"],
    verifyDate: json["verifyDate"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    isEdit: json["isEdit"],
    updatedDate: json["updatedDate"],
    updatedBy: json["updatedBy"],
    projectName: json["projectName"],
    fromProjectName: json["fromProjectName"],
    siteName: json["siteName"],
    createdName: json["createdName"],
    verifyName: json["verifyName"],
    approvedName: json["approvedName"],
    approveNo: json["approveNo"],
    preApproveBy: json["preApproveBy"],
    preApproveStatus: json["preApproveStatus"],
    preApproveDate: json["preApproveDate"],
    approvedBy: json["approvedBy"],
    approveDate: json["approveDate"],
    mMatReqMasLink: List<MMatReqMasLink>.from(json["mMatReqMasLink"].map((x) => MMatReqMasLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() {
    final data = {
      "id": id,
      "reqOrdNo": reqOrdNo,
      "reqOrdDate": reqOrdDate,
      "reqdueDate": reqdueDate,
      "projectID": projectId,
      "siteID": siteId,
      "reqRemarks": reqRemarks,
      "approveRemarks": approveRemarks,
      "approveStatus": approveStatus,
      "verifyBy": verifyBy,
      "verifyStatus": verifyStatus,
      "requestType": requestType,
      "verifyDate": verifyDate,
      "createdBy": createdBy,
      "createdDt": createdDt,
      "isEdit": isEdit,
      "updatedDate": updatedDate,
      "updatedBy": updatedBy,
      "projectName": projectName,
      "fromProjectName": fromProjectName,
      "siteName": siteName,
      "createdName": createdName,
      "verifyName": verifyName,
      "approvedName": approvedName,
      "approveNo": approveNo,
      "preApproveBy": preApproveBy,
      "preApproveStatus": preApproveStatus,
      "preApproveDate": preApproveDate,
      "approvedBy": approvedBy,
      "approveDate": approveDate,
      "mMatReqMasLink": mMatReqMasLink?.map((x) => x.toJson()).toList(),
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

class MMatReqMasLink {
  int? id;
  int? materialReqOrdMasid;
  int? materialId;
  double? qty;
  int? scaleId;
  int? siteId;
  String? approveStatus;
  String? approveType;
  int? refProjectId;
  double? reqQty;
  String? remarks;
  String? reqDescription;
  String? preApproveType;
  String? preApproveStatus;
  String? materialName;
  String? scaleName;
  String? refProjectName;

  MMatReqMasLink({
    this.id,
    this.materialReqOrdMasid,
    this.materialId,
    this.qty,
    this.scaleId,
    this.siteId,
    this.approveStatus,
    this.approveType,
    this.refProjectId,
    this.reqQty,
    this.remarks,
    this.reqDescription,
    this.preApproveType,
    this.preApproveStatus,
    this.materialName,
    this.scaleName,
    this.refProjectName,
  });

  factory MMatReqMasLink.fromJson(Map<String, dynamic> json) => MMatReqMasLink(
    id: json["id"],
    materialReqOrdMasid: json["materialReqOrdMasid"],
    materialId: json["materialID"],
    qty: json["qty"],
    scaleId: json["scaleID"],
    siteId: json["siteID"],
    approveStatus: json["approveStatus"],
    approveType: json["approveType"],
    refProjectId: json["refProjectId"],
    reqQty: json["reqQty"],
    remarks: json["remarks"],
    reqDescription: json["reqDescription"],
    preApproveType: json["preApproveType"],
    preApproveStatus: json["preApproveStatus"],
    materialName: json["materialName"],
    scaleName: json["scaleName"],
    refProjectName: json["refProjectName"],
  );

  Map<String, dynamic> toJson() {
    final data = {
      "id": id,
      "materialReqOrdMasid": materialReqOrdMasid,
      "materialID": materialId,
      "qty": qty,
      "scaleID": scaleId,
      "siteID": siteId,
      "approveStatus": approveStatus,
      "approveType": approveType,
      "refProjectId": refProjectId,
      "reqQty": reqQty,
      "remarks": remarks,
      "reqDescription": reqDescription,
      "preApproveType": preApproveType,
      "preApproveStatus": preApproveStatus,
      "materialName": materialName,
      "scaleName": scaleName,
      "refProjectName": refProjectName,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }}
