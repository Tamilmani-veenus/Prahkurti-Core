import 'dart:convert';

BillDirectGenSaveApiReq billDirectGenSaveApiReqFromJson(String str) => BillDirectGenSaveApiReq.fromJson(json.decode(str));

String billDirectGenSaveApiReqToJson(BillDirectGenSaveApiReq data) => json.encode(data.toJson());

class BillDirectGenSaveApiReq {
  BillDirectGenSaveApiReq({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.entryType,
    this.billType,
    this.refWorkId,
    this.fromDate,
    this.toDate,
    this.rndOff,
    this.billAmt,
    this.actAdvAmt,
    this.advAmt,
    this.netPayAmt,
    this.debitAmt,
    this.creditAmt,
    this.debitRemarks,
    this.creditRemarks,
    this.remarks,
    this.workOrderId,
    this.billno,
    this.createdBy,
    this.createdDt,
    this.materialDebitAmount,
    this.materialDebitRemarks,
    this.partRateStatus,
    this.paymentDate,
    this.penaltyAmount,
    this.finalBillAmount,
    this.verifyStatus,
    this.approveStatus,
    this.subContractorWorkQtyDetS,
    this.subContractorBillAddLessSetupS,
  });

  int? workId;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContId;
  String? entryType;
  String? billType;
  int? refWorkId;
  String? fromDate;
  String? toDate;
  double? rndOff;
  double? billAmt;
  double? actAdvAmt;
  double? advAmt;
  double? netPayAmt;
  double? debitAmt;
  double? creditAmt;
  String? debitRemarks;
  String? creditRemarks;
  String? remarks;
  int? workOrderId;
  String? billno;
  int? createdBy;
  String? createdDt;
  double? materialDebitAmount;
  String? materialDebitRemarks;
  int? partRateStatus;
  String? paymentDate;
  double? penaltyAmount;
  double? finalBillAmount;
  String? verifyStatus;
  String? approveStatus;
  List<SubContractorWorkQtyDet>? subContractorWorkQtyDetS;
  List<SubContractorBillAddLessSetup>? subContractorBillAddLessSetupS;

  factory BillDirectGenSaveApiReq.fromJson(Map<String, dynamic> json) => BillDirectGenSaveApiReq(
    workId: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContId: json["subContractorId"],
    entryType: json["entryType"],
    billType: json["billType"],
    refWorkId: json["refWorkId"],
    fromDate: json["fromWorkDate"],
    toDate: json["toWorkDate"],
    rndOff: json["roundOff"],
    billAmt: json["netBillAmount"],
    actAdvAmt: json["actualAdvanceAmount"],
    advAmt: json["advanceAmount"],
    netPayAmt: json["netPayAmount"],
    debitAmt: json["debitAmount"],
    creditAmt: json["creditAmount"],
    debitRemarks: json["debitRemarks"],
    creditRemarks: json["creditRemarks"],
    remarks: json["remarks"],
    workOrderId: json["workOrderId"],
    billno: json["billNo"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    materialDebitAmount: json["materialDebitAmount"],
    materialDebitRemarks: json["materialDebitRemarks"],
    partRateStatus: json["partRateStatus"],
    paymentDate: json["paymentDate"],
    penaltyAmount: json["penaltyAmount"],
    finalBillAmount: json["finalBillAmount"],
    verifyStatus: json["verifyStatus"],
    approveStatus: json["approveStatus"],
    subContractorWorkQtyDetS: List<SubContractorWorkQtyDet>.from(json["subContractorWorkQtyDetS"].map((x) => SubContractorWorkQtyDet.fromJson(x))),
    subContractorBillAddLessSetupS: List<SubContractorBillAddLessSetup>.from(json["subContractorBillAddLessSetupS"].map((x) => SubContractorBillAddLessSetup.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "id": workId,
    "workNo": workNo,
    "workDate": workDate,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContId,
    "entryType": entryType,
    "billType": billType,
    "refWorkId": refWorkId,
    "fromWorkDate": fromDate,
    "toWorkDate": toDate,
    "roundOff": rndOff,
    "netBillAmount": billAmt,
    "actualAdvanceAmount": actAdvAmt,
    "advanceAmount": advAmt,
    "netPayAmount": netPayAmt,
    "debitAmount": debitAmt,
    "creditAmount": creditAmt,
    "debitRemarks": debitRemarks,
    "creditRemarks": creditRemarks,
    "remarks": remarks,
    "workOrderId": workOrderId,
    "billNo": billno,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "finalBillAmount": finalBillAmount,
    "penaltyAmount": penaltyAmount,
    "paymentDate": paymentDate,
    "partRateStatus": partRateStatus,
    "materialDebitRemarks": materialDebitRemarks,
    "materialDebitAmount": materialDebitAmount,
    "verifyStatus": verifyStatus,
    "approveStatus": approveStatus,
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
  int? id;
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
  String? itemDes;
  String? workType;
  double? actualQty;
  double? actualAmount;
  double? totalQty;
  String? qtysClosed;
  double? balanceBillQty;
  double? currentBillQty;
  double? balanceQty;
  int? partRateStatus;
  String? boqCode;

  SubContractorWorkQtyDet({
    this.id,
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
    this.itemDes,
    this.workType,
    this.actualQty,
    this.actualAmount,
    this.totalQty,
    this.qtysClosed,
    this.balanceBillQty,
    this.currentBillQty,
    this.balanceQty,
    this.partRateStatus,
    this.boqCode,
  });

  factory SubContractorWorkQtyDet.fromJson(Map<String, dynamic> json) =>
      SubContractorWorkQtyDet(
        id: json["id"],
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
        itemDes: json["itemDescription"],
        workType: json["workType"],
        actualQty: json["actualQty"],
        actualAmount: json["actualAmount"],
        totalQty: json["totalQty"],
        qtysClosed: json["qtysClosed"],
        balanceBillQty: json["balanceBillQty"],
        currentBillQty: json["currentBillQty"],
        balanceQty: json["balanceQty"],
        partRateStatus: json["partRateStatus"],
        boqCode: json["boqCode"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
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
        "itemDescription": itemDes,
        "workType": workType,
        "actualQty": actualQty,
        "actualAmount": actualAmount,
        "totalQty": totalQty,
        "qtysClosed": qtysClosed,
        "balanceBillQty": balanceBillQty,
        "currentBillQty": currentBillQty,
        "balanceQty": balanceQty,
        "partRateStatus": partRateStatus,
        "boqCode": boqCode,
      };
}



