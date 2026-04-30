import 'dart:convert';

List<DailywrkDoneDprEntrylistResmodel> dailywrkDoneDprEntrylistResmodelFromJson(String str) => List<DailywrkDoneDprEntrylistResmodel>.from(json.decode(str).map((x) => DailywrkDoneDprEntrylistResmodel.fromJson(x)));

String dailywrkDoneDprEntrylistResmodelToJson(List<DailywrkDoneDprEntrylistResmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailywrkDoneDprEntrylistResmodel {
  DailywrkDoneDprEntrylistResmodel({
    this.workId,
    this.workNo,
    this.dailywrkDoneDprEntrylistResmodelWorkDate,
    this.workDate,
    this.workType,
    this.entryType,
    this.entrytype,
    this.project,
    this.siteName,
    this.subconName,
    this.allowStatus,
    this.appStatus,
    this.AppStatusName,
    this.preparedbyName,
  });

  int? workId;
  String? workNo;
  String? dailywrkDoneDprEntrylistResmodelWorkDate;
  String? workDate;
  String? workType;
  String? entryType;
  String? entrytype;
  String? project;
  String? siteName;
  String? subconName;
  String? allowStatus;
  String? appStatus;
  String? AppStatusName;
  String? preparedbyName;

  factory DailywrkDoneDprEntrylistResmodel.fromJson(Map<String, dynamic> json) => DailywrkDoneDprEntrylistResmodel(
    workId: json["Work_Id"],
    workNo: json["Work_No"],
    dailywrkDoneDprEntrylistResmodelWorkDate:json["Work_Date"],
    workDate: json["WorkDate"],
    workType: json["Work_Type"],
    entryType: json["entry_type"],
    entrytype: json["entrytype"],
    project: json["Project"],
    siteName: json["SiteName"],
    subconName: json["Subcon_name"],
    allowStatus: json["allow_status"],
    appStatus: json["App_Status"],
    AppStatusName: json["AppStatus"],
    preparedbyName: json["PreparedbyName"],
  );

  Map<String, dynamic> toJson() => {
    "Work_Id": workId,
    "Work_No": workNo,
    "Work_Date": dailywrkDoneDprEntrylistResmodelWorkDate,
    "WorkDate": workDate,
    "Work_Type": workType,
    "entry_type": entryType,
    "entrytype": entrytype,
    "Project": project,
    "SiteName": siteName,
    "Subcon_name": subconName,
    "allow_status": allowStatus,
    "App_Status": appStatus,
    "AppStatus": AppStatusName,
    "PreparedbyName": preparedbyName,
  };
}
