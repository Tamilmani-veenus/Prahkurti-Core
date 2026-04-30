import 'dart:convert';

PreapprovalSaveReqModel preapprovalSaveReqModelFromJson(String str) => PreapprovalSaveReqModel.fromJson(json.decode(str));

String preapprovalSaveReqModelToJson(PreapprovalSaveReqModel data) => json.encode(data.toJson());

class PreapprovalSaveReqModel {
  PreapprovalSaveReqModel({
    this.preApprovalId,
    this.preApprovalNo,
    this.preApprovalDate,
    this.preApprovalType,
    this.projectId,
    this.location,
    this.description,
    this.approxHrs,
    this.approxQty,
    this.equipment,
    this.chemicalUsed,
    this.plannedDate,
    this.preparedby,
    this.approvedby,
    this.userId,
    this.entryMode,
    this.deviceName,
  });

  String? preApprovalId;
  String? preApprovalNo;
  String? preApprovalDate;
  String? preApprovalType;
  String? projectId;
  String? location;
  String? description;
  String? approxHrs;
  String? approxQty;
  String? equipment;
  String? chemicalUsed;
  String? plannedDate;
  String? preparedby;
  String? approvedby;
  String? userId;
  String? entryMode;
  String? deviceName;

  factory PreapprovalSaveReqModel.fromJson(Map<String, dynamic> json) => PreapprovalSaveReqModel(
    preApprovalId: json["PreApprovalId"],
    preApprovalNo: json["PreApprovalNo"],
    preApprovalDate: json["PreApprovalDate"],
    preApprovalType: json["PreApprovalType"],
    projectId: json["ProjectId"],
    location: json["Location"],
    description: json["Description"],
    approxHrs: json["Approx_Hrs"],
    approxQty: json["Approx_Qty"],
    equipment: json["Equipment_Used"],
    chemicalUsed: json["Chemical_Used"],
    plannedDate: json["Planned_Date"],
    preparedby: json["Preparedby"],
    approvedby: json["Approvedby"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    deviceName: json["DeviceName"],
  );

  Map<String, dynamic> toJson() => {
    "PreApprovalId": preApprovalId,
    "PreApprovalNo": preApprovalNo,
    "PreApprovalDate": preApprovalDate,
    "PreApprovalType": preApprovalType,
    "ProjectId": projectId,
    "Location": location,
    "Description": description,
    "Approx_Hrs": approxHrs,
    "Approx_Qty": approxQty,
    "Equipment_Used": equipment,
    "Chemical_Used": chemicalUsed,
    "Planned_Date": plannedDate,
    "Preparedby": preparedby,
    "Approvedby": approvedby,
    "UserId": userId,
    "EntryMode": entryMode,
    "DeviceName": deviceName,
  };
}
