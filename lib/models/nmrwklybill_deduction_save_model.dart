import 'dart:convert';

NmrSaveRequest subcontNmrSaveRequestFromJson(String str) => NmrSaveRequest.fromJson(json.decode(str));

String subcontNmrSaveRequestToJson(NmrSaveRequest data) => json.encode(data.toJson());

class NmrSaveRequest {
  NmrSaveRequest({
    this.workId,
    this.workNo,
    this.entryDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.fromDate,
    this.toDate,
    this.remarks,
    this.rndOff,
    this.billNo,
    this.billAmt,
    this.actAdvAmt,
    this.advAmt,
    this.netPayAmt,
    this.debitAmt,
    this.creditAmt,
    this.debitRemarks,
    this.creditRemarks,
    this.preparedby,
    this.userId,
    this.deviceName,
    this.entryMode,
    this.nmrBillDet,
  });

  String? workId;
  String? workNo;
  String? entryDate;
  String? projectId;
  String? siteId;
  String? subContId;
  String? fromDate;
  String? toDate;
  String? remarks;
  String? rndOff;
  String? billNo;
  String? billAmt;
  String? actAdvAmt;
  String? advAmt;
  String? netPayAmt;
  String? debitAmt;
  String? creditAmt;
  String? debitRemarks;
  String? creditRemarks;
  String? preparedby;
  String? userId;
  String? deviceName;
  String? entryMode;
  List<NmrBillDet>? nmrBillDet;

  factory NmrSaveRequest.fromJson(Map<String, dynamic> json) => NmrSaveRequest(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    entryDate: json["EntryDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    remarks: json["remarks"],
    rndOff: json["RndOff"],
    billNo: json["Billno"],
    billAmt: json["BillAmt"],
    actAdvAmt: json["ActAdvAmt"],
    advAmt: json["AdvAmt"],
    netPayAmt: json["NetPayAmt"],
    debitAmt: json["DebitAmt"],
    creditAmt: json["CreditAmt"],
    debitRemarks: json["DebitRemarks"],
    creditRemarks: json["CreditRemarks"],
    preparedby: json["Preparedby"],
    userId: json["UserId"],
    deviceName: json["DeviceName"],
    entryMode: json["EntryMode"],
    nmrBillDet: List<NmrBillDet>.from(json["NMRBillDet"].map((x) => NmrBillDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "EntryDate": entryDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "FromDate": fromDate,
    "ToDate": toDate,
    "remarks": remarks,
    "RndOff": rndOff,
    "Billno": billNo,
    "BillAmt": billAmt,
    "ActAdvAmt": actAdvAmt,
    "AdvAmt": advAmt,
    "NetPayAmt": netPayAmt,
    "DebitAmt": debitAmt,
    "CreditAmt": creditAmt,
    "DebitRemarks": debitRemarks,
    "CreditRemarks": creditRemarks,
    "Preparedby": preparedby,
    "UserId": userId,
    "DeviceName": deviceName,
    "EntryMode": entryMode,
    "NMRBillDet": List<dynamic>.from(nmrBillDet!.map((x) => x.toJson())),
  };
}

class NmrBillDet {
  NmrBillDet({
    this.projectId,
    this.siteId,
    this.categoryId,
    this.totnos,
    this.totalOtamt,
    this.nmrAmt,
    // this.wages,
    // this.amt,
    // this.totalOthrs,
  });

  String? projectId;
  String? siteId;
  String? categoryId;
  String? totnos;
  String? totalOtamt;
  String? nmrAmt;
  // String? wages;
  // String? amt;
  // String? totalOthrs;

  factory NmrBillDet.fromJson(Map<String, dynamic> json) => NmrBillDet(
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    categoryId: json["CategoryId"],
    totnos: json["Totnos"],
    totalOtamt: json["total_otamt"],
    nmrAmt: json["NMRAmt"],
    // wages: json["wages"],
    // amt: json["amt"],
    // totalOthrs: json["total_othrs"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "SiteId": siteId,
    "CategoryId": categoryId,
    "Totnos": totnos,
    "total_otamt": totalOtamt,
    "NMRAmt": nmrAmt,
    // "wages": wages,
    // "amt": amt,
    // "total_othrs": totalOthrs,
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

