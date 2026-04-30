import 'dart:convert';

List<SubcontractorOsExpensesResponse> subcontractorOsExpensesResponseFromJson(String str) => List<SubcontractorOsExpensesResponse>.from(json.decode(str).map((x) => SubcontractorOsExpensesResponse.fromJson(x)));

String subcontractorOsExpensesResponseToJson(List<SubcontractorOsExpensesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubcontractorOsExpensesResponse {
  SubcontractorOsExpensesResponse({
    this.sNo,
    this.labourName,
    this.opnAmt,
    this.workAmt,
    this.issuepayment,
    this.balAmt,
  });

  int? sNo;
  String? labourName;
  double? opnAmt;
  double? workAmt;
  double? issuepayment;
  double? balAmt;

  factory SubcontractorOsExpensesResponse.fromJson(Map<String, dynamic> json) => SubcontractorOsExpensesResponse(
    sNo: json["SNo"],
    labourName: json["LabourName"],
    opnAmt: json["OpnAmt"],
    workAmt: json["WorkAmt"],
    issuepayment: json["Issuepayment"],
    balAmt: json["BalAmt"],
  );

  Map<String, dynamic> toJson() => {
    "SNo": sNo,
    "LabourName": labourName,
    "OpnAmt": opnAmt,
    "WorkAmt": workAmt,
    "Issuepayment": issuepayment,
    "BalAmt": balAmt,
  };
}
