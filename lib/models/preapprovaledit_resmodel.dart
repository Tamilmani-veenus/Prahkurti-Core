import 'dart:convert';

List<PreapprovalEditResModel> preapprovalEditResModelFromJson(String str) => json.decode(str) == null ? [] : List<PreapprovalEditResModel>.from(json.decode(str).map((x) => PreapprovalEditResModel.fromJson(x)));

String preapprovalEditResModelToJson(List<PreapprovalEditResModel> data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())));

class PreapprovalEditResModel {
  PreapprovalEditResModel({
    this.preApprovalId,
    this.preApprovalNo,
    this.preApprovalDate,
    this.preApprovalType,
    this.PreApprovalTypeID,
    this.projectId,
    this.project,
    this.location,
    this.description,
    this.approxHrs,
    this.approxQty,
    this.equipment,
    this.chemicalUsed,
    this.plannedDate,
    this.preparedby,
    this.preparedbyName,
  });

  int? preApprovalId;
  String? preApprovalNo;
  String? preApprovalDate;
  String? preApprovalType;
  int? PreApprovalTypeID;
  int? projectId;
  String? project;
  String? location;
  String? description;
  String? approxHrs;
  String? approxQty;
  String? equipment;
  String? chemicalUsed;
  String? plannedDate;
  int? preparedby;
  String? preparedbyName;

  factory PreapprovalEditResModel.fromJson(Map<String, dynamic> json) => PreapprovalEditResModel(
    preApprovalId: json["PreApprovalId"],
    preApprovalNo: json["PreApprovalNo"],
    preApprovalDate: json["PreApprovalDate"],
    preApprovalType: json["PreApprovalType"],
    PreApprovalTypeID: json["PreApprovalTypeID"],
    projectId: json["ProjectId"],
    project: json["Project"],
    location: json["Location"],
    description: json["Description"],
    approxHrs: json["Approx_Hrs"],
    approxQty: json["Approx_Qty"],
    equipment: json["Equipment_Used"],
    chemicalUsed: json["Chemical_Used"],
    plannedDate: json["Planned_Date"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
  );

  Map<String, dynamic> toJson() => {
    "PreApprovalId": preApprovalId,
    "PreApprovalNo": preApprovalNo,
    "PreApprovalDate": preApprovalDate,
    "PreApprovalType": preApprovalType,
    "PreApprovalTypeID": PreApprovalTypeID,
    "ProjectId": projectId,
    "Project": project,
    "Location": location,
    "Description": description,
    "Approx_Hrs": approxHrs,
    "Approx_Qty": approxQty,
    "Equipment_Used": equipment,
    "Chemical_Used": chemicalUsed,
    "Planned_Date": plannedDate,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
  };
}
