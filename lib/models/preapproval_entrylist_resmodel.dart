import 'dart:convert';

List<PreAprovalentrylistResmodel> preAprovalentrylistResmodelFromJson(String str) => json.decode(str) == null ? [] : List<PreAprovalentrylistResmodel>.from(json.decode(str).map((x) => PreAprovalentrylistResmodel.fromJson(x)));

String preAprovalentrylistResmodelToJson(List<PreAprovalentrylistResmodel> data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())));

class PreAprovalentrylistResmodel {
  PreAprovalentrylistResmodel({
    this.preApprovalId,
    this.preApprovalNo,
    this.preApprovalDate,
    this.entryDate,
    this.typeName,
    this.project,
    this.preparedBy,
  });

  int? preApprovalId;
  String? preApprovalNo;
  String? preApprovalDate;
  String? entryDate;
  String? typeName;
  String? project;
  String? preparedBy;

  factory PreAprovalentrylistResmodel.fromJson(Map<String, dynamic> json) => PreAprovalentrylistResmodel(
    preApprovalId: json["PreApproval_Id"],
    preApprovalNo: json["PreApproval_No"],
    preApprovalDate: json["PreApproval_Date"],
    entryDate: json["EntryDate"],
    typeName: json["TypeName"],
    project: json["Project"],
    preparedBy: json["PreparedBy"],
  );

  Map<String, dynamic> toJson() => {
    "PreApproval_Id": preApprovalId,
    "PreApproval_No": preApprovalNo,
    "PreApproval_Date": preApprovalDate,
    "EntryDate": entryDate,
    "TypeName": typeName,
    "Project": project,
    "PreparedBy": preparedBy,
  };
}

