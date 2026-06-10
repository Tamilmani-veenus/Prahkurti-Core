import 'dart:convert';
import 'dart:io';

DailywrkDoneDprItemlistSaveModel dailywrkDoneDprItemlistSaveModelFromJson(String str) => DailywrkDoneDprItemlistSaveModel.fromJson(json.decode(str));

String dailywrkDoneDprItemlistSaveModelToJson(DailywrkDoneDprItemlistSaveModel data) => json.encode(data.toJson());

class DailywrkDoneDprItemlistSaveModel {
  DailywrkDoneDprItemlistSaveModel({
    this.Id,
    this.workNo,
    this.workDate,
    this.workType,
    this.projectId,
    this.siteId,
    this.subContId,
    this.refNo,
    this.totalamt,
    this.entryType,
    this.dprType,
    this.billStatus,
    this.remarks,
    this.preparedby,
    this.approvedby,
    this.createdBy,
    this.createdDate,
    this.subContractDailyWorkDets,
    this.approveStatus,
    this.verifyStatus,
  });

  int? Id;
  String? workNo;
  String? workDate;
  String? workType;
  int? projectId;
  int? siteId;
  int? subContId;
  String? refNo;
  String? totalamt;
  String? entryType;
  int? dprType;
  String? billStatus;
  String? remarks;
  String? preparedby;
  String? approvedby;
  int? createdBy;
  String? createdDate;
  String? approveStatus;
  String? verifyStatus;
  List<SubContractDailyWorkDets>? subContractDailyWorkDets;

  factory DailywrkDoneDprItemlistSaveModel.fromJson(Map<String, dynamic> json) => DailywrkDoneDprItemlistSaveModel(
    Id: json["Id"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    workType: json["WorkType"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContractorId"],
    refNo: json["RefNo"],
    totalamt: json["TotalAmount"],
    entryType: json["EntryType"],
    dprType: json["DPRType"],
    billStatus: json["BillStatus"],
    remarks: json["Remarks"],
    preparedby: json["Preparedby"],
    approvedby: json["Approvedby"],
    createdBy: json["CreatedBy"],
    createdDate: json["CreatedDt"],
    approveStatus: json["ApproveStatus"],
    verifyStatus: json["VerifyStatus"],
    subContractDailyWorkDets: List<SubContractDailyWorkDets>.from(json["DprDet"].map((x) => SubContractDailyWorkDets.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "WorkType": workType,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContractorId": subContId,
    "RefNo": refNo,
    "TotalAmount": totalamt,
    "EntryType": entryType,
    "DPRType": dprType,
    "BillStatus": billStatus,
    "Remarks": remarks,
    "Preparedby": preparedby,
    "Approvedby": approvedby,
    "CreatedBy": createdBy,
    "CreatedDt": createdDate,
    "ApproveStatus": approveStatus,
    "VerifyStatus": verifyStatus,
    "SubContractDailyWorkDets": List<dynamic>.from(subContractDailyWorkDets!.map((x) => x.toJson())),
  };
}

class SubContractDailyWorkDets {
  int? cement;
  double? rate;
  int? subContractDailyWorkMasId;
  String? detRemarks;
  int? siteId;
  int? scaleId;
  int? subContarctWorkdetid;
  String? itemDescription;
  String? workType;
  int? headItemId;
  int? subItemId;
  String? boqCode;
  String? siteName;
  double? qty;
  double? amount;
  String? billStatus;
  int? avgLabRate;
  int? id;
  int? level3ItemId;
  String? workRemarks;

  SubContractDailyWorkDets({
    this.cement,
    this.rate,
    this.subContractDailyWorkMasId,
    this.detRemarks,
    this.siteId,
    this.scaleId,
    this.subContarctWorkdetid,
    this.itemDescription,
    this.workType,
    this.headItemId,
    this.subItemId,
    this.boqCode,
    this.siteName,
    this.qty,
    this.amount,
    this.billStatus,
    this.avgLabRate,
    this.id,
    this.level3ItemId,
    this.workRemarks
  });

  factory SubContractDailyWorkDets.fromJson(Map<String, dynamic> json) => SubContractDailyWorkDets(
    cement: json["cement"],
    rate: json["rate"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    detRemarks: json["workRemarks"],
    siteId: json["siteId"],
    scaleId: json["unit"],
    subContarctWorkdetid: json["subContarctWorkdetid"],
    itemDescription: json["itemDescription"],
    workType: json["workType"],
    headItemId: json["headItemId"],
    subItemId: json["subItemId"],
    boqCode: json["boqCode"],
    siteName: json["siteName"],
    qty: json["qty"],
    amount: json["amount"],
    billStatus: json["billStatus"],
    avgLabRate: json["avgLabRate"],
    id: json["id"],
    level3ItemId: json["level3ItemId"],
    workRemarks: json["workRemarks"]
  );

  Map<String, dynamic> toJson() => {
    "cement": cement,
    "rate": rate,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "workRemarks": detRemarks,
    "siteId": siteId,
    "unit": scaleId,
    "subContarctWorkdetid": subContarctWorkdetid,
    "itemDescription": itemDescription,
    "workType": workType,
    "headItemId": headItemId,
    "subItemId": subItemId,
    "boqCode": boqCode,
    "siteName": siteName,
    "qty": qty,
    "amount": amount,
    "billStatus": billStatus,
    "avgLabRate": avgLabRate,
    "id": id,
    "level3ItemId": level3ItemId,
    "workRemarks": workRemarks,
  };
}






