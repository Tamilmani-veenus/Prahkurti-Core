// To parse this JSON data, do
//
//     final nmrSaveRequest = nmrSaveRequestFromJson(jsonString);

import 'dart:convert';

NmrSaveRequest nmrSaveRequestFromJson(String str) => NmrSaveRequest.fromJson(json.decode(str));

String nmrSaveRequestToJson(NmrSaveRequest data) => json.encode(data.toJson());

class NmrSaveRequest {
  int? id;
  String? workNo;
  String? entryDate;
  int? projectId;
  int? siteId;
  int? subContractorId;
  String? fromDate;
  String? toDate;
  String? billNo;
  double? billAmount;
  double? foodAmount;
  double? bankCharges;
  double? debitAmount;
  String? debitRemarks;
  double? creditAmount;
  String? creditRemarks;
  double? advanceAmount;
  double? actualAdvanceAmount;
  double? roundOff;
  double? netPayAmount;
  double? netBillAmount;
  // double? balanceAmount;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? verifyStatus;
  String? approveStatus;
  List<SubContractorNmrBillDet>? subContractorNmrBillDetS;
  List<SubContractorNmrBillAddLessSetup>? subContractorNmrBillAddLessSetupS;

  NmrSaveRequest({
    this.id,
    this.workNo,
    this.entryDate,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.fromDate,
    this.toDate,
    this.billNo,
    this.billAmount,
    this.foodAmount,
    this.bankCharges,
    this.debitAmount,
    this.debitRemarks,
    this.creditAmount,
    this.creditRemarks,
    this.advanceAmount,
    this.actualAdvanceAmount,
    this.roundOff,
    this.netPayAmount,
    this.netBillAmount,
    // this.balanceAmount,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.verifyStatus,
    this.approveStatus,
    this.subContractorNmrBillDetS,
    this.subContractorNmrBillAddLessSetupS,
  });

  factory NmrSaveRequest.fromJson(Map<String, dynamic> json) => NmrSaveRequest(
    id: json["id"],
    workNo: json["workNo"],
    entryDate: json["entryDate"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    billNo: json["billNo"],
    billAmount: json["billAmount"],
    foodAmount: json["foodAmount"],
    bankCharges: json["bankCharges"],
    debitAmount: json["debitAmount"],
    debitRemarks: json["debitRemarks"],
    creditAmount: json["creditAmount"],
    creditRemarks: json["creditRemarks"],
    advanceAmount: json["advanceAmount"],
    actualAdvanceAmount: json["actualAdvanceAmount"],
    roundOff: json["roundOff"],
    netPayAmount: json["netPayAmount"],
    netBillAmount: json["netBillAmount"],
    // balanceAmount: json["balanceAmount"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    verifyStatus: json["verifyStatus"],
    approveStatus: json["approveStatus"],
    subContractorNmrBillDetS: List<SubContractorNmrBillDet>.from(json["subContractorNMRBillDetS"].map((x) => SubContractorNmrBillDet.fromJson(x))),
    subContractorNmrBillAddLessSetupS: List<SubContractorNmrBillAddLessSetup>.from(json["subContractorNMRBillAddLessSetupS"].map((x) => SubContractorNmrBillAddLessSetup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "entryDate": entryDate,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "fromDate": fromDate,
    "toDate": toDate,
    "billNo": billNo,
    "billAmount": billAmount,
    "foodAmount": foodAmount,
    "bankCharges": bankCharges,
    "debitAmount": debitAmount,
    "debitRemarks": debitRemarks,
    "creditAmount": creditAmount,
    "creditRemarks": creditRemarks,
    "advanceAmount": advanceAmount,
    "actualAdvanceAmount": actualAdvanceAmount,
    "roundOff": roundOff,
    "netPayAmount": netPayAmount,
    "netBillAmount": netBillAmount,
    // "balanceAmount": balanceAmount,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "verifyStatus": verifyStatus,
    "approveStatus": approveStatus,
    "subContractorNMRBillDetS": List<dynamic>.from(subContractorNmrBillDetS!.map((x) => x.toJson())),
    "subContractorNMRBillAddLessSetupS": List<dynamic>.from(subContractorNmrBillAddLessSetupS!.map((x) => x.toJson())),
  };
}

class SubContractorNmrBillAddLessSetup {
  int? id;
  int? addLessId;
  int? subContractorNmrBillMasId;
  double? percentValue;
  double? amount;

  SubContractorNmrBillAddLessSetup({
    this.id,
    this.addLessId,
    this.subContractorNmrBillMasId,
    this.percentValue,
    this.amount,
  });

  factory SubContractorNmrBillAddLessSetup.fromJson(Map<String, dynamic> json) => SubContractorNmrBillAddLessSetup(
    id: json["id"],
    addLessId: json["addLessId"],
    subContractorNmrBillMasId: json["subContractorNMRBillMasId"],
    percentValue: json["percentValue"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addLessId": addLessId,
    "subContractorNMRBillMasId": subContractorNmrBillMasId,
    "percentValue": percentValue,
    "amount": amount,
  };
}

class SubContractorNmrBillDet {
  int? id;
  int? subContractorNmrBillMasId;
  int? projectId;
  int? siteId;
  int? subContractorId;
  int? categoryId;
  double? nmrAmount;
  double? totalNos;
  double? totalOtAmount;

  SubContractorNmrBillDet({
    this.id,
    this.subContractorNmrBillMasId,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.categoryId,
    this.nmrAmount,
    this.totalNos,
    this.totalOtAmount,
  });

  factory SubContractorNmrBillDet.fromJson(Map<String, dynamic> json) => SubContractorNmrBillDet(
    id: json["id"],
    subContractorNmrBillMasId: json["subContractorNMRBillMasId"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    categoryId: json["categoryId"],
    nmrAmount: json["nmrAmount"],
    totalNos: json["totalNos"],
    totalOtAmount: json["totalOTAmount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractorNMRBillMasId": subContractorNmrBillMasId,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "categoryId": categoryId,
    "nmrAmount": nmrAmount,
    "totalNos": totalNos,
    "totalOTAmount": totalOtAmount,
  };
}


NMR_SaveDeduction_SaveResponse saveDeduction_SaveResponseFromJson(String str) => NMR_SaveDeduction_SaveResponse.fromJson(json.decode(str));

String saveDeduction_SaveResponseToJson(NMR_SaveDeduction_SaveResponse data) => json.encode(data.toJson());

class NMR_SaveDeduction_SaveResponse {
  NMR_SaveDeduction_SaveResponse({
    this.RetString,
  });

  String? RetString;

  factory NMR_SaveDeduction_SaveResponse.fromJson(Map<String, dynamic> json) => NMR_SaveDeduction_SaveResponse(
    RetString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": RetString,
  };
}
