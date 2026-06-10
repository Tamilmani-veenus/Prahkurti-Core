// To parse this JSON data, do
//
//     final dailywrkdonDprNewSaveReq = dailywrkdonDprNewSaveReqFromJson(jsonString);

import 'dart:convert';

DprNewSaveReq DprNewSaveReqFromJson(String str) => DprNewSaveReq.fromJson(json.decode(str));

String DprNewSaveReqToJson(DprNewSaveReq data) => json.encode(data.toJson());

class DprNewSaveReq {
  int? id;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContractorId;
  String? entryType;
  int? dprType;
  String? billStatus;
  double? totalAmount;
  String? refNo;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? approveStatus;
  String? verifyStatus;
  List<SubContractDailyWorkDet>? subContractDailyWorkDets;
  List<SubcontractDailyWorkCement>? subcontractDailyWorkCements;
  List<SubcontractDailyWorkLabour>? subcontractDailyWorkLabours;
  List<SubcontractDailyWorkMeasurement>? subcontractDailyWorkMeasurements;

  DprNewSaveReq({
    this.id,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.entryType,
    this.dprType,
    this.billStatus,
    this.totalAmount,
    this.refNo,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.approveStatus,
    this.verifyStatus,
    this.subContractDailyWorkDets,
    this.subcontractDailyWorkCements,
    this.subcontractDailyWorkLabours,
    this.subcontractDailyWorkMeasurements,
  });

  factory DprNewSaveReq.fromJson(Map<String, dynamic> json) => DprNewSaveReq(
    id: json["Id"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContractorId: json["SubContractorId"],
    entryType: json["EntryType"],
    dprType: json["DPRType"],
    billStatus: json["BillStatus"],
    totalAmount: json["TotalAmount"],
    refNo: json["RefNo"],
    remarks: json["Remarks"],
    createdBy: json["CreatedBy"],
    createdDt: json["CreatedDt"],
    approveStatus: json["ApproveStatus"],
    verifyStatus: json["VerifyStatus"],
    subContractDailyWorkDets: List<SubContractDailyWorkDet>.from(json["SubContractDailyWorkDets"].map((x) => SubContractDailyWorkDet.fromJson(x))),
    subcontractDailyWorkCements: List<SubcontractDailyWorkCement>.from(json["SubcontractDailyWorkCements"].map((x) => SubcontractDailyWorkCement.fromJson(x))),
    subcontractDailyWorkLabours: List<SubcontractDailyWorkLabour>.from(json["SubcontractDailyWorkLabours"].map((x) => SubcontractDailyWorkLabour.fromJson(x))),
    subcontractDailyWorkMeasurements: List<SubcontractDailyWorkMeasurement>.from(json["SubcontractDailyWorkMeasurements"].map((x) => SubcontractDailyWorkMeasurement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContractorId": subContractorId,
    "EntryType": entryType,
    "DPRType": dprType,
    "BillStatus": billStatus,
    "TotalAmount": totalAmount,
    "RefNo": refNo,
    "Remarks": remarks,
    "CreatedBy": createdBy,
    "CreatedDt": createdDt,
    "ApproveStatus": approveStatus,
    "VerifyStatus": verifyStatus,
    "SubContractDailyWorkDets": List<dynamic>.from(subContractDailyWorkDets!.map((x) => x.toJson())),
    "SubcontractDailyWorkCements": List<dynamic>.from(subcontractDailyWorkCements!.map((x) => x.toJson())),
    "SubcontractDailyWorkLabours": List<dynamic>.from(subcontractDailyWorkLabours!.map((x) => x.toJson())),
    "SubcontractDailyWorkMeasurements": List<dynamic>.from(subcontractDailyWorkMeasurements!.map((x) => x.toJson())),
  };
}

class SubContractDailyWorkDet {
  double? cement;
  double? rate;
  int? subContractDailyWorkMasId;
  String? workRemarks;
  int? siteId;
  int? scaleId;
  int? subContarctWorkdetid;
  String? itemDescription;
  String? workType;
  int? headItemId;
  int? subItemId;
  String? boqCode;
  double? qty;
  double? amount;
  String? billStatus;
  double? avgLabRate;
  int? id;
  int? level3ItemId;

  SubContractDailyWorkDet({
    this.cement,
    this.rate,
    this.subContractDailyWorkMasId,
    this.workRemarks,
    this.siteId,
    this.scaleId,
    this.subContarctWorkdetid,
    this.itemDescription,
    this.workType,
    this.headItemId,
    this.subItemId,
    this.boqCode,
    this.qty,
    this.amount,
    this.billStatus,
    this.avgLabRate,
    this.id,
    this.level3ItemId,
  });

  factory SubContractDailyWorkDet.fromJson(Map<String, dynamic> json) => SubContractDailyWorkDet(
    cement: json["cement"],
    rate: json["rate"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    workRemarks: json["workRemarks"],
    siteId: json["siteId"],
    scaleId: json["scaleId"],
    subContarctWorkdetid: json["subContarctWorkdetid"],
    itemDescription: json["itemDescription"],
    workType: json["workType"],
    headItemId: json["headItemId"],
    subItemId: json["subItemId"],
    boqCode: json["boqCode"],
    qty: json["qty"],
    amount: json["amount"],
    billStatus: json["billStatus"],
    avgLabRate: json["avgLabRate"],
    id: json["id"],
    level3ItemId: json["level3ItemId"],
  );

  Map<String, dynamic> toJson() => {
    "cement": cement,
    "rate": rate,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "workRemarks": workRemarks,
    "siteId": siteId,
    "scaleId": scaleId,
    "subContarctWorkdetid": subContarctWorkdetid,
    "itemDescription": itemDescription,
    "workType": workType,
    "headItemId": headItemId,
    "subItemId": subItemId,
    "boqCode": boqCode,
    "qty": qty,
    "amount": amount,
    "billStatus": billStatus,
    "avgLabRate": avgLabRate,
    "id": id,
    "level3ItemId": level3ItemId,
  };
}

class SubcontractDailyWorkCement {
  int? id;
  int? subContractDailyWorkMasId;
  int? materialId;
  int? scaleId;
  double? qty;

  SubcontractDailyWorkCement({
    this.id,
    this.subContractDailyWorkMasId,
    this.materialId,
    this.scaleId,
    this.qty,
  });

  factory SubcontractDailyWorkCement.fromJson(Map<String, dynamic> json) => SubcontractDailyWorkCement(
    id: json["id"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    materialId: json["materialId"],
    scaleId: json["scaleId"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "materialId": materialId,
    "scaleId": scaleId,
    "qty": qty,
  };
}

class SubcontractDailyWorkLabour {
  int? subContractDailyWorkMasId;
  double? otHrs;
  double? wages;
  int? subContractorId;
  double? nos;
  double? amount;
  int? categoryId;
  int? id;
  double? otAmount;

  SubcontractDailyWorkLabour({
    this.subContractDailyWorkMasId,
    this.otHrs,
    this.wages,
    this.subContractorId,
    this.nos,
    this.amount,
    this.categoryId,
    this.id,
    this.otAmount,
  });

  factory SubcontractDailyWorkLabour.fromJson(Map<String, dynamic> json) => SubcontractDailyWorkLabour(
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    otHrs: json["otHrs"],
    wages: json["wages"],
    subContractorId: json["subContractorId"],
    nos: json["nos"],
    amount: json["amount"],
    categoryId: json["categoryId"],
    id: json["id"],
    otAmount: json["otAmount"],
  );

  Map<String, dynamic> toJson() => {
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "otHrs": otHrs,
    "wages": wages,
    "subContractorId": subContractorId,
    "nos": nos,
    "amount": amount,
    "categoryId": categoryId,
    "id": id,
    "otAmount": otAmount,
  };
}

class SubcontractDailyWorkMeasurement {
  int? id;
  int? subContractDailyWorkMasId;
  String? descriptionWork;
  double? no;
  double? length;
  double? breadth;
  double? depth;
  double? qty;

  SubcontractDailyWorkMeasurement({
    this.id,
    this.subContractDailyWorkMasId,
    this.descriptionWork,
    this.no,
    this.length,
    this.breadth,
    this.depth,
    this.qty,
  });

  factory SubcontractDailyWorkMeasurement.fromJson(Map<String, dynamic> json) => SubcontractDailyWorkMeasurement(
    id: json["id"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    descriptionWork: json["descriptionWork"],
    no: json["no"],
    length: json["length"],
    breadth: json["breadth"],
    depth: json["depth"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "descriptionWork": descriptionWork,
    "no": no,
    "length": length,
    "breadth": breadth,
    "depth": depth,
    "qty": qty,
  };
}
