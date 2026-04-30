

import 'dart:convert';

List<WklyReportResponse> wklyReportResponseFromJson(String str) => List<WklyReportResponse>.from(json.decode(str).map((x) => WklyReportResponse.fromJson(x)));

String wklyReportResponseToJson(List<WklyReportResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WklyReportResponse {
  WklyReportResponse({
    this.nmrWorkId,
    this.nmrDate,
    this.workNo,
    this.projectid,
    this.subContId,
    this.projectname,
    this.subconName,
    this.appStatus,
    this.verifyAmt,
    this.preApprovalAmt,
    this.approvalAmt,
    this.billamt,
    this.type,
  });

  int? nmrWorkId;
  String? nmrDate;
  String? workNo;
  int? projectid;
  int? subContId;
  String? projectname;
  String? subconName;
  String? appStatus;
  double? verifyAmt;
  double? preApprovalAmt;
  double? approvalAmt;
  double? billamt;
  String? type;

  factory WklyReportResponse.fromJson(Map<String, dynamic> json) => WklyReportResponse(
    nmrWorkId: json["NMR_Work_Id"],
    nmrDate: json["NmrDate"],
    workNo: json["Work_No"],
    projectid: json["projectid"],
    subContId: json["SubContId"],
    projectname: json["Projectname"],
    subconName: json["Subcon_name"],
    appStatus: json["App_status"],
    verifyAmt: json["VerifyAmt"],
    preApprovalAmt: json["PreApprovalAmt"],
    approvalAmt: json["ApprovalAmt"],
    billamt: json["Billamt"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "NMR_Work_Id": nmrWorkId,
    "NmrDate": nmrDate,
    "Work_No": workNo,
    "projectid": projectid,
    "SubContId": subContId,
    "Projectname": projectname,
    "Subcon_name": subconName,
    "App_status": appStatus,
    "VerifyAmt": verifyAmt,
    "PreApprovalAmt": preApprovalAmt,
    "ApprovalAmt": approvalAmt,
    "Billamt": billamt,
    "type": type,
  };
}
