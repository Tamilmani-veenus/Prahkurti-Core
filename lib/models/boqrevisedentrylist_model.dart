// To parse this JSON data, do
//
//     final boqRevisedEntrylistResponse = boqRevisedEntrylistResponseFromJson(jsonString);

import 'dart:convert';

List<BoqRevisedEntrylistResponse> boqRevisedEntrylistResponseFromJson(String str) => List<BoqRevisedEntrylistResponse>.from(json.decode(str).map((x) => BoqRevisedEntrylistResponse.fromJson(x)));

String boqRevisedEntrylistResponseToJson(List<BoqRevisedEntrylistResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoqRevisedEntrylistResponse {
  BoqRevisedEntrylistResponse({
    this.reviseId,
    this.reviseNo,
    this.reviseDate,
    this.project,
    this.siteName,
    this.preparedby,
  });

  int? reviseId;
  String? reviseNo;
  String? reviseDate;
  String? project;
  String? siteName;
  String? preparedby;

  factory BoqRevisedEntrylistResponse.fromJson(Map<String, dynamic> json) => BoqRevisedEntrylistResponse(
    reviseId: json["Revise_Id"],
    reviseNo: json["Revise_No"],
    reviseDate: json["Revise_Date"],
    project: json["Project"],
    siteName: json["SiteName"],
    preparedby: json["Preparedby"],
  );

  Map<String, dynamic> toJson() => {
    "Revise_Id": reviseId,
    "Revise_No": reviseNo,
    "Revise_Date": reviseDate,
    "Project": project,
    "SiteName": siteName,
    "Preparedby": preparedby,
  };
}
