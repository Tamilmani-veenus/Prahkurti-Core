// To parse this JSON data, do
//
//     final workOrderHeadItems = workOrderHeadItemsFromJson(jsonString);

import 'dart:convert';

WorkOrderHeadItems workOrderHeadItemsFromJson(String str) => WorkOrderHeadItems.fromJson(json.decode(str));

String workOrderHeadItemsToJson(WorkOrderHeadItems data) => json.encode(data.toJson());

class WorkOrderHeadItems {
  bool? success;
  List<Message>? message;

  WorkOrderHeadItems({
    this.success,
    this.message,
  });

  factory WorkOrderHeadItems.fromJson(Map<String, dynamic> json) => WorkOrderHeadItems(
    success: json["success"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message!.map((x) => x.toJson())),
  };
}

class Message {
  int? id;
  String? subItem;
  int? headItemid;
  int? projectid;
  double? subSeqNo;
  double? qty;
  double? rate;
  int? scaleId;
  dynamic? scaleName;
  double? materialrate;
  double? labourrate;
  int? categoryId;
  int? subWorkid;
  int? subItemid;
  String? workstatus;
  String? workcode;
  int? createdBy;
  String? createdDt;
  String? approveStatus;
  List<MeasureLevel3Item>? measureLevel3ItemS;

  Message({
    this.id,
    this.subItem,
    this.headItemid,
    this.projectid,
    this.subSeqNo,
    this.qty,
    this.rate,
    this.scaleId,
    this.scaleName,
    this.materialrate,
    this.labourrate,
    this.categoryId,
    this.subWorkid,
    this.subItemid,
    this.workstatus,
    this.workcode,
    this.createdBy,
    this.createdDt,
    this.approveStatus,
    this.measureLevel3ItemS,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    subItem: json["subItem"],
    headItemid: json["headItemid"],
    projectid: json["projectid"],
    subSeqNo: json["subSeqNo"]?.toDouble(),
    qty: json["qty"],
    rate: json["rate"],
    scaleId: json["scaleID"],
    scaleName: json["scaleName"],
    materialrate: json["materialrate"],
    labourrate: json["labourrate"],
    categoryId: json["categoryId"],
    subWorkid: json["subWorkid"],
    subItemid: json["subItemid"],
    workstatus: json["workstatus"],
    workcode: json["workcode"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    approveStatus: json["approveStatus"],
    measureLevel3ItemS: List<MeasureLevel3Item>.from(json["measureLevel3ItemS"].map((x) => MeasureLevel3Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subItem": subItem,
    "headItemid": headItemid,
    "projectid": projectid,
    "subSeqNo": subSeqNo,
    "qty": qty,
    "rate": rate,
    "scaleID": scaleId,
    "scaleName": scaleName,
    "materialrate": materialrate,
    "labourrate": labourrate,
    "categoryId": categoryId,
    "subWorkid": subWorkid,
    "subItemid": subItemid,
    "workstatus": workstatus,
    "workcode": workcode,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "approveStatus": approveStatus,
    "measureLevel3ItemS": List<dynamic>.from(measureLevel3ItemS!.map((x) => x.toJson())),
  };
}

class MeasureLevel3Item {
  int? id;
  int? projectid;
  int? siteId;
  int? subItemid;
  int? headItemid;
  String? level3Item;
  int? headSeqno;
  double? subSeqno;
  double? balqty;
  double? rate;
  int? scaleId;
  String? seqNo;
  int? workid;
  int? itemid;
  double? materialrate;
  double? labourrate;
  String? workstatus;
  String? workcode;
  String? approveStatus;
  int? decideFactor;
  double? overheadsrate;
  double? othersrate;
  double? machineryrate;
  int? createdBy;
  String? createdDt;
  dynamic startDate;
  dynamic endDate;
  dynamic totalDurationDays;
  String? projectName;
  String? siteName;
  String? scaleName;
  String? createdName;
  dynamic headandSubName;
  dynamic total;
  bool? isCheck=false;

  MeasureLevel3Item({
    this.id,
    this.projectid,
    this.siteId,
    this.subItemid,
    this.headItemid,
    this.level3Item,
    this.headSeqno,
    this.subSeqno,
    this.balqty,
    this.rate,
    this.scaleId,
    this.seqNo,
    this.workid,
    this.itemid,
    this.materialrate,
    this.labourrate,
    this.workstatus,
    this.workcode,
    this.approveStatus,
    this.decideFactor,
    this.overheadsrate,
    this.othersrate,
    this.machineryrate,
    this.createdBy,
    this.createdDt,
    this.startDate,
    this.endDate,
    this.totalDurationDays,
    this.projectName,
    this.siteName,
    this.scaleName,
    this.createdName,
    this.headandSubName,
    this.total,
  });

  factory MeasureLevel3Item.fromJson(Map<String, dynamic> json) => MeasureLevel3Item(
    id: json["id"],
    projectid: json["projectid"],
    siteId: json["siteId"],
    subItemid: json["subItemid"],
    headItemid: json["headItemid"],
    level3Item: json["level3Item"],
    headSeqno: json["headSeqno"],
    subSeqno: json["subSeqno"]?.toDouble(),
    balqty: json["qty"],
    rate: json["rate"],
    scaleId: json["scaleId"],
    seqNo: json["seqNo"],
    workid: json["workid"],
    itemid: json["itemid"],
    materialrate: json["materialrate"],
    labourrate: json["labourrate"],
    workstatus: json["workstatus"],
    workcode: json["workcode"],
    approveStatus: json["approveStatus"],
    decideFactor: json["decideFactor"],
    overheadsrate: json["overheadsrate"],
    othersrate: json["othersrate"],
    machineryrate: json["machineryrate"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    totalDurationDays: json["totalDurationDays"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    scaleName: json["scaleName"],
    createdName: json["createdName"],
    headandSubName: json["headandSubName"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectid": projectid,
    "siteId": siteId,
    "subItemid": subItemid,
    "headItemid": headItemid,
    "level3Item": level3Item,
    "headSeqno": headSeqno,
    "subSeqno": subSeqno,
    "qty": balqty,
    "rate": rate,
    "scaleId": scaleId,
    "seqNo": seqNo,
    "workid": workid,
    "itemid": itemid,
    "materialrate": materialrate,
    "labourrate": labourrate,
    "workstatus": workstatus,
    "workcode": workcode,
    "approveStatus": approveStatus,
    "decideFactor": decideFactor,
    "overheadsrate": overheadsrate,
    "othersrate": othersrate,
    "machineryrate": machineryrate,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "startDate": startDate,
    "endDate": endDate,
    "totalDurationDays": totalDurationDays,
    "projectName": projectName,
    "siteName": siteName,
    "scaleName": scaleName,
    "createdName": createdName,
    "headandSubName": headandSubName,
    "total": total,
  };
}
