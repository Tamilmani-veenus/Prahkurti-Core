// To parse this JSON data, do
//
//     final billDirectWorkOrdDet = billDirectWorkOrdDetFromJson(jsonString);






// To parse this JSON data, do
//
//     final directbillEditApiResModel = directbillEditApiResModelFromJson(jsonString);


import 'dart:convert';

DirectbillEditApiResModel directbillEditApiResModelFromJson(String str) => DirectbillEditApiResModel.fromJson(json.decode(str));

String directbillEditApiResModelToJson(DirectbillEditApiResModel data) => json.encode(data.toJson());

class DirectbillEditApiResModel {
  bool? success;
  Result? result;
  String? message;

  DirectbillEditApiResModel({
    this.success,
    this.result,
    this.message,
  });

  factory DirectbillEditApiResModel.fromJson(Map<String, dynamic> json) => DirectbillEditApiResModel(
    success: json["success"],
      result: json["result"]==null?null:Result.fromJson(json["result"]),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?null:result!.toJson(),
    "message": message
  };
}

class Result {
  int? id;
  String? workNo;
  String? workDate;
  String? entryType;
  String? billType;
  int? projectId;
  int? siteId;
  int? subContId;
  int? workOrderId;
  int? refWorkId;
  String? fromWorkDate;
  String? toWorkDate;
  String? billNo;
  double? billAmount;
  double? finalBillAmount;
  double? netPayAmount;
  double? roundOff;
  double? penaltyAmount;
  double? advanceAmount;
  double? actualAdvanceAmount;
  double? balanceAmount;
  double? creditAmount;
  String? creditRemarks;
  double? debitAmount;
  String? debitRemarks;
  double? materialDebitAmount;
  String? materialDebitRemarks;
  int? partRateStatus;
  String? paymentDate;
  String? remarks;
  int? createdBy;
  String? createdDt;
  int? verifyBy;
  String? verifyStatus;
  String? verifyDt;
  int? approvedBy;
  String? approveStatus;
  String? approveDt;
  String? projectName;
  String? siteName;
  String? subContName;
  String? createdName;
  String? verifiedName;
  String? approvedName;
  String? status;
  String? billTypeDesc;
  String? entryTypeDesc;
  String? workOrderNo;
  List<SubContractorWorkQtyDet>? subContractorWorkQtyDetS;
  List<SubContractorBillAddLessSetup>? subContractorBillAddLessSetupS;

  Result({
    this.id,
    this.workNo,
    this.workDate,
    this.entryType,
    this.billType,
    this.projectId,
    this.siteId,
    this.subContId,
    this.workOrderId,
    this.refWorkId,
    this.fromWorkDate,
    this.toWorkDate,
    this.billNo,
    this.billAmount,
    this.finalBillAmount,
    this.netPayAmount,
    this.roundOff,
    this.penaltyAmount,
    this.advanceAmount,
    this.actualAdvanceAmount,
    this.balanceAmount,
    this.creditAmount,
    this.creditRemarks,
    this.debitAmount,
    this.debitRemarks,
    this.materialDebitAmount,
    this.materialDebitRemarks,
    this.partRateStatus,
    this.paymentDate,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.verifyBy,
    this.verifyStatus,
    this.verifyDt,
    this.approvedBy,
    this.approveStatus,
    this.approveDt,
    this.projectName,
    this.siteName,
    this.subContName,
    this.createdName,
    this.verifiedName,
    this.approvedName,
    this.status,
    this.billTypeDesc,
    this.entryTypeDesc,
    this.workOrderNo,
    this.subContractorWorkQtyDetS,
    this.subContractorBillAddLessSetupS,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    entryType: json["entryType"],
    billType: json["billType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContId: json["subContractorId"],
    workOrderId: json["workOrderId"],
    refWorkId: json["refWorkId"],
    fromWorkDate: json["fromWorkDate"],
    toWorkDate: json["toWorkDate"],
    billNo: json["billNo"],
    billAmount: json["netBillAmount"],
    finalBillAmount: json["finalBillAmount"],
    netPayAmount: json["netPayAmount"],
    roundOff: json["roundOff"],
    penaltyAmount: json["penaltyAmount"],
    advanceAmount: json["advanceAmount"],
    actualAdvanceAmount: json["actualAdvanceAmount"],
    balanceAmount: json["balanceAmount"],
    creditAmount: json["creditAmount"],
    creditRemarks: json["creditRemarks"],
    debitAmount: json["debitAmount"],
    debitRemarks: json["debitRemarks"],
    materialDebitAmount: json["materialDebitAmount"],
    materialDebitRemarks: json["materialDebitRemarks"],
    partRateStatus: json["partRateStatus"],
    paymentDate: json["paymentDate"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyBy: json["verifyBy"],
    verifyStatus: json["verifyStatus"],
    verifyDt: json["verifyDt"],
    approvedBy: json["approvedBy"],
    approveStatus: json["approveStatus"],
    approveDt: json["approveDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    subContName: json["subContractorName"],
    createdName: json["createdName"],
    verifiedName: json["verifiedName"],
    approvedName: json["approvedName"],
    status: json["status"],
    billTypeDesc: json["billTypeDesc"],
    entryTypeDesc: json["entryTypeDesc"],
    workOrderNo: json["workOrderNo"],
    subContractorWorkQtyDetS: List<SubContractorWorkQtyDet>.from(json["subContractorWorkQtyDetS"].map((x) => SubContractorWorkQtyDet.fromJson(x))),
    subContractorBillAddLessSetupS: List<SubContractorBillAddLessSetup>.from(json["subContractorBillAddLessSetupS"].map((x) => SubContractorBillAddLessSetup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "workDate": workDate,
    "entryType": entryType,
    "billType": billType,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContId,
    "workOrderId": workOrderId,
    "refWorkId": refWorkId,
    "fromWorkDate": fromWorkDate,
    "toWorkDate": toWorkDate,
    "billNo": billNo,
    "netBillAmount": billAmount,
    "finalBillAmount": finalBillAmount,
    "netPayAmount": netPayAmount,
    "roundOff": roundOff,
    "penaltyAmount": penaltyAmount,
    "advanceAmount": advanceAmount,
    "actualAdvanceAmount": actualAdvanceAmount,
    "balanceAmount": balanceAmount,
    "creditAmount": creditAmount,
    "creditRemarks": creditRemarks,
    "debitAmount": debitAmount,
    "debitRemarks": debitRemarks,
    "materialDebitAmount": materialDebitAmount,
    "materialDebitRemarks": materialDebitRemarks,
    "partRateStatus": partRateStatus,
    "paymentDate": paymentDate,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyBy": verifyBy,
    "verifyStatus": verifyStatus,
    "verifyDt": verifyDt,
    "approvedBy": approvedBy,
    "approveStatus": approveStatus,
    "approveDt": approveDt,
    "projectName": projectName,
    "siteName": siteName,
    "subContractorName": subContName,
    "createdName": createdName,
    "verifiedName": verifiedName,
    "approvedName": approvedName,
    "status": status,
    "billTypeDesc": billTypeDesc,
    "entryTypeDesc": entryTypeDesc,
    "workOrderNo": workOrderNo,
    "subContractorWorkQtyDetS": List<dynamic>.from(subContractorWorkQtyDetS!.map((x) => x.toJson())),
    "subContractorBillAddLessSetupS": List<dynamic>.from(subContractorBillAddLessSetupS!.map((x) => x.toJson())),
  };
}

class SubContractorBillAddLessSetup {
  int? id;
  int? subContractorWorkQtyMasId;
  String? workNo;
  int? addLessId;
  double? percentValue;
  double? amount;

  SubContractorBillAddLessSetup({
    this.id,
    this.subContractorWorkQtyMasId,
    this.workNo,
    this.addLessId,
    this.percentValue,
    this.amount,
  });

  factory SubContractorBillAddLessSetup.fromJson(Map<String, dynamic> json) => SubContractorBillAddLessSetup(
    id: json["id"],
    subContractorWorkQtyMasId: json["subContractorWorkQtyMasId"],
    workNo: json["workNo"],
    addLessId: json["addLessId"],
    percentValue: json["percentValue"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractorWorkQtyMasId": subContractorWorkQtyMasId,
    "workNo": workNo,
    "addLessId": addLessId,
    "percentValue": percentValue,
    "amount": amount,
  };
}

class SubContractorWorkQtyDet {
  int? reqDetId;
  int? subContractorWorkQtyMasId;
  int? siteId;
  int? headItemid;
  int? subItemid;
  int? level3ItemId;
  int? dbrWorkDetId;
  int? refWorkDetId;
  String? unit;
  double? rate;
  double? qty;
  double? amount;
  String? flatNo;
  String? itemDesc;
  String? workType;
  double? actualQty;
  double? actualAmount;
  double? totalqty;
  String? qtysClosed;
  double? balbillqty;
  double? CurBillQty;
  double? balanceQty;
  int? partRateStatus;
  dynamic? boqCode;

  SubContractorWorkQtyDet({
    this.reqDetId,
    this.subContractorWorkQtyMasId,
    this.siteId,
    this.headItemid,
    this.subItemid,
    this.level3ItemId,
    this.dbrWorkDetId,
    this.refWorkDetId,
    this.unit,
    this.rate,
    this.qty,
    this.amount,
    this.flatNo,
    this.itemDesc,
    this.workType,
    this.actualQty,
    this.actualAmount,
    this.totalqty,
    this.qtysClosed,
    this.balbillqty,
    this.CurBillQty,
    this.balanceQty,
    this.partRateStatus,
    this.boqCode,
  });

  factory SubContractorWorkQtyDet.fromJson(Map<String, dynamic> json) => SubContractorWorkQtyDet(
    reqDetId: json["id"],
    subContractorWorkQtyMasId: json["subContractorWorkQtyMasId"],
    siteId: json["siteId"],
    headItemid: json["headItemid"],
    subItemid: json["subItemid"],
    level3ItemId: json["level3ItemId"],
    dbrWorkDetId: json["dbrWorkDetId"],
    refWorkDetId: json["refWorkDetId"],
    unit: json["unit"],
    rate: json["rate"],
    qty: json["qty"],
    amount: json["amount"],
    flatNo: json["flatNo"],
    itemDesc: json["itemDescription"],
    workType: json["workType"],
    actualQty: json["actualQty"],
    actualAmount: json["actualAmount"],
    totalqty: json["totalQty"],
    qtysClosed: json["qtysClosed"],
    balbillqty: json["balanceBillQty"],
    CurBillQty: json["currentBillQty"],
    balanceQty: json["balanceQty"],
    partRateStatus: json["partRateStatus"],
    boqCode: json["boqCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": reqDetId,
    "subContractorWorkQtyMasId": subContractorWorkQtyMasId,
    "siteId": siteId,
    "headItemid": headItemid,
    "subItemid": subItemid,
    "level3ItemId": level3ItemId,
    "dbrWorkDetId": dbrWorkDetId,
    "refWorkDetId": refWorkDetId,
    "unit": unit,
    "rate": rate,
    "qty": qty,
    "amount": amount,
    "flatNo": flatNo,
    "itemDescription": itemDesc,
    "workType": workType,
    "actualQty": actualQty,
    "actualAmount": actualAmount,
    "totalQty": totalqty,
    "qtysClosed": qtysClosed,
    "balanceBillQty": balbillqty,
    "currentBillQty": CurBillQty,
    "balanceQty": balanceQty,
    "partRateStatus": partRateStatus,
    "boqCode": boqCode,
  };
}

