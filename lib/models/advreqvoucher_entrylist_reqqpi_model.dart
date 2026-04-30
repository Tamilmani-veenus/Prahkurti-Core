import 'dart:convert';

List<AdvReqvoucherentrylistResapi> advReqvoucherentrylistResapiFromJson(String str) => List<AdvReqvoucherentrylistResapi>.from(json.decode(str).map((x) => AdvReqvoucherentrylistResapi.fromJson(x)));

String advReqvoucherentrylistResapiToJson(List<AdvReqvoucherentrylistResapi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvReqvoucherentrylistResapi {
  AdvReqvoucherentrylistResapi({
    this.vocId,
    this.vocNo,
    this.vocDate,
    this.accName,
    this.vocAmt,
    this.bankid,
    this.payFor,
    this.accType,
    this.status,
    this.project,
    this.projectId,
    this.acctypeid,
    this.accnameid,
  });

  int? vocId;
  String? vocNo;
  String? vocDate;
  String? accName;
  double? vocAmt;
  int? bankid;
  String? payFor;
  String? accType;
  String? status;
  String? project;
  int? projectId;
  int? acctypeid;
  int? accnameid;


  factory AdvReqvoucherentrylistResapi.fromJson(Map<String, dynamic> json) => AdvReqvoucherentrylistResapi(
    vocId: json["voc_id"],
    vocNo: json["voc_no"],
    vocDate: json["voc_date"],
    accName: json["acc_name"] == null ? null : json["acc_name"],
    vocAmt: json["voc_amt"],
    bankid: json["bankid"],
    payFor: json["Pay_for"],
    accType: json["acc_type"],
    status: json["Status"],
    project: json["project"],
    projectId: json["ProjectId"],
    acctypeid: json["acc_typeid"],
    accnameid: json["acc_nameid"] ,
  );

  Map<String, dynamic> toJson() => {
    "voc_id": vocId,
    "voc_no": vocNo,
    "voc_date": vocDate,
    "acc_name": accName,
    "voc_amt": vocAmt,
    "bankid": bankid,
    "Pay_for": payFor,
    "acc_type": accType,
    "Status":status,
    "project": project,
    "ProjectId": projectId,
    "acc_typeid": acctypeid,
    "acc_nameid": accnameid,
  };
}



