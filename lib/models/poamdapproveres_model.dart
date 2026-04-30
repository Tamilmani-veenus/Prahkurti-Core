// // To parse this JSON data, do
// //
// //     final poAmendmentApproveResModel = poAmendmentApproveResModelFromJson(jsonString);
//
// import 'dart:convert';
//
// PoAmendmentApproveResModel poAmendmentApproveResModelFromJson(String str) => PoAmendmentApproveResModel.fromJson(json.decode(str));
//
// String poAmendmentApproveResModelToJson(PoAmendmentApproveResModel data) => json.encode(data.toJson());
//
// class PoAmendmentApproveResModel {
//   String? purOrdAmdId;
//   String? inwardNo;
//   String? inwardDate;
//   String? id;
//   String? remarks;
//   String? preparedby;
//   String? projectId;
//   String? siteId;
//   String? inwardId;
//   String? entryMode;
//   String? userId;
//   String? deviceName;
//   List<InwardDetList>? inwardDet;
//
//   PoAmendmentApproveResModel({
//    this.purOrdAmdId,
//    this.inwardNo,
//    this.inwardDate,
//    this.id,
//    this.remarks,
//    this.preparedby,
//    this.projectId,
//    this.siteId,
//    this.inwardId,
//    this.entryMode,
//    this.userId,
//    this.deviceName,
//    this.inwardDet,
//   });
//
//   factory PoAmendmentApproveResModel.fromJson(Map<String, dynamic> json) => PoAmendmentApproveResModel(
//     purOrdAmdId: json["pur_ordAmd_id"],
//     inwardNo: json["InwardNo"],
//     inwardDate: json["InwardDate"],
//     id: json["Id"],
//     remarks: json["Remarks"],
//     preparedby: json["Preparedby"],
//     projectId: json["ProjectId"],
//     siteId: json["SiteId"],
//     inwardId: json["InwardId"],
//     entryMode: json["EntryMode"],
//     userId: json["UserId"],
//     deviceName: json["DeviceName"],
//     inwardDet: List<InwardDetList>.from(json["InwardDet"].map((x) => InwardDetList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pur_ordAmd_id": purOrdAmdId,
//     "InwardNo": inwardNo,
//     "InwardDate": inwardDate,
//     "Id": id,
//     "Remarks": remarks,
//     "Preparedby": preparedby,
//     "ProjectId": projectId,
//     "SiteId": siteId,
//     "InwardId": inwardId,
//     "EntryMode": entryMode,
//     "UserId": userId,
//     "DeviceName": deviceName,
//     "InwardDet": List<dynamic>.from(inwardDet!.map((x) => x.toJson())),
//   };
// }
//
// class InwardDetList {
//   String? purOrdDetId;
//   String? materialId;
//   String? qty;
//   String? addQty;
//   String? lessQty;
//
//   InwardDetList({
//    this.purOrdDetId,
//    this.materialId,
//    this.qty,
//    this.addQty,
//    this.lessQty,
//   });
//
//   factory InwardDetList.fromJson(Map<String, dynamic> json) => InwardDetList(
//     purOrdDetId: json["PurOrdDetId"],
//     materialId: json["MaterialId"],
//     qty: json["Qty"],
//     addQty: json["AddQty"],
//     lessQty: json["LessQty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "PurOrdDetId": purOrdDetId,
//     "MaterialId": materialId,
//     "Qty": qty,
//     "AddQty": addQty,
//     "LessQty": lessQty,
//   };
// }
//
//
// PoAmendmentApproveSaveResModel poAmendmentApproveSaveResModelFromJson(String str) => PoAmendmentApproveSaveResModel.fromJson(json.decode(str));
//
// String poAmendmentApproveSaveResModelToJson(PoAmendmentApproveSaveResModel data) => json.encode(data.toJson());
//
// class PoAmendmentApproveSaveResModel {
//   String retString;
//
//   PoAmendmentApproveSaveResModel({
//     required this.retString,
//   });
//
//   factory PoAmendmentApproveSaveResModel.fromJson(Map<String, dynamic> json) => PoAmendmentApproveSaveResModel(
//     retString: json["RetString"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "RetString": retString,
//   };
// }


// To parse this JSON data, do
//
//     final poAmendmentApproveResModel = poAmendmentApproveResModelFromJson(jsonString);

import 'dart:convert';

PoAmendmentApproveResModel poAmendmentApproveResModelFromJson(String str) => PoAmendmentApproveResModel.fromJson(json.decode(str));

String poAmendmentApproveResModelToJson(PoAmendmentApproveResModel data) => json.encode(data.toJson());

class PoAmendmentApproveResModel {
  int? purOrdOId;
  int? woOrdId;
  String? amdDate;
  int? projectId;
  int? siteId;
  String? amdType;
  String? inwardType;
  List<InwardAmdsaveDetLink>? inwardAmdsaveDetLink;

  PoAmendmentApproveResModel({
    this.purOrdOId,
    this.woOrdId,
    this.amdDate,
    this.projectId,
    this.siteId,
    this.amdType,
    this.inwardType,
    this.inwardAmdsaveDetLink
  });

  factory PoAmendmentApproveResModel.fromJson(Map<String, dynamic> json) => PoAmendmentApproveResModel(
    purOrdOId: json["purOrdOId"],
    woOrdId: json["woOrdId"],
    amdDate: json["amdDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    amdType: json["amdType"],
    inwardType: json["inwardType"],
    inwardAmdsaveDetLink: List<InwardAmdsaveDetLink>.from(json["inwardAmdsaveDetLink"].map((x) => InwardAmdsaveDetLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "purOrdOId": purOrdOId,
    "woOrdId": woOrdId,
    "amdDate": amdDate,
    "projectId": projectId,
    "siteId": siteId,
    "amdType": amdType,
    "inwardType": inwardType,
    "inwardAmdsaveDetLink": inwardAmdsaveDetLink,
  };
}

class InwardAmdsaveDetLink {
  int? purDetId;
  int? workOrdDetId;
  int? materialid;
  int? scaleid;
  int? addQty;
  int? lessQty;

  InwardAmdsaveDetLink({
    this.purDetId,
    this.workOrdDetId,
    this.materialid,
    this.scaleid,
    this.addQty,
    this.lessQty,
  });

  factory InwardAmdsaveDetLink.fromJson(Map<String, dynamic> json) => InwardAmdsaveDetLink(
    purDetId: json["purDetId"],
    workOrdDetId: json["workOrdDetId"],
    materialid: json["materialid"],
    scaleid: json["scaleid"],
    addQty: json["addQty"],
    lessQty: json["lessQty"],
  );

  Map<String, dynamic> toJson() => {
    "purDetId": purDetId,
    "workOrdDetId": workOrdDetId,
    "materialid": materialid,
    "scaleid": scaleid,
    "addQty": addQty,
    "lessQty": lessQty,
  };
}
