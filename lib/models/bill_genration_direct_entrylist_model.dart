import 'dart:convert';

List<BillDirectentrylist> billDirectentrylistFromJson(String str) => List<BillDirectentrylist>.from(json.decode(str).map((x) => BillDirectentrylist.fromJson(x)));

String billDirectentrylistToJson(List<BillDirectentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillDirectentrylist {
  BillDirectentrylist({
    this.workId,
    this.workNo,
    this.workDate,
    this.fdate,
    this.tdate,
    this.project,
    this.siteName,
    this.subconName,
    this.projectId,
    this.subContId,
    this.fworkDate,
    this.tworkDate,
    this.workOrderid,
    this.status,
    this.partRate,
    this.netPayAmt,
    this.preparedby,
    this.preparedbyName,
  });

  int? workId;
  String? workNo;
  String? workDate;
  String? fdate;
  String? tdate;
  String? project;
  String? siteName;
  String? subconName;
  int? projectId;
  int? subContId;
  String? fworkDate;
  String? tworkDate;
  int? workOrderid;
  String? status;
  String? partRate;
  double? netPayAmt;
  int? preparedby;
  String? preparedbyName;

  factory BillDirectentrylist.fromJson(Map<String, dynamic> json) => BillDirectentrylist(
    workId: json["Work_Id"],
    workNo: json["Work_No"],
    workDate: json["Work_Date"],
    fdate: json["fdate"],
    tdate: json["tdate"],
    project: json["Project"],
    siteName: json["SiteName"],
    subconName: json["Subcon_name"],
    projectId: json["ProjectId"],
    subContId: json["SubContId"],
    fworkDate: json["fwork_date"],
    tworkDate: json["twork_date"],
    workOrderid: json["work_orderid"],
    status: json["Status"],
    partRate: json["Part_rate"],
    netPayAmt: json["net_pay_amt"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedByName"],
  );

  Map<String, dynamic> toJson() => {
    "Work_Id": workId,
    "Work_No": workNo,
    "Work_Date": workDate,
    "fdate": fdate,
    "tdate": tdate,
    "Project": project,
    "SiteName": siteName,
    "Subcon_name": subconName,
    "ProjectId": projectId,
    "SubContId": subContId,
    "fwork_date": fworkDate,
    "twork_date": tworkDate,
    "work_orderid": workOrderid,
    "Status": status,
    "Part_rate": partRate,
    "net_pay_amt": netPayAmt,
    "Preparedby": preparedby,
    "PreparedByName": preparedbyName,
  };
}
