// To parse this JSON data, do
//
//     final projectExpensesResponse = projectExpensesResponseFromJson(jsonString);

import 'dart:convert';

List<ProjectExpensesResponse> projectExpensesResponseFromJson(String str) => List<ProjectExpensesResponse>.from(json.decode(str).map((x) => ProjectExpensesResponse.fromJson(x)));

String projectExpensesResponseToJson(List<ProjectExpensesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectExpensesResponse {
  ProjectExpensesResponse({
    this.projectId,
    this.project,
    this.siteid,
    this.sitename,
    this.opnExpAmt,
    this.mtrExpAmt,
    this.nLbrExpAmt,
    this.gLbrExpAmt,
    this.sbCnExpAmt,
    this.miscExpAmt,
    this.siteMatrExpAmt,
    this.totExpAmt,
    this.clntRptAmt,
    this.stat,
    this.amtDiff,
  });

  int? projectId;
  String? project;
  int? siteid;
  String? sitename;
  int? opnExpAmt;
  double? mtrExpAmt;
  double? nLbrExpAmt;
  double? gLbrExpAmt;
  double? sbCnExpAmt;
  double? miscExpAmt;
  double? siteMatrExpAmt;
  double? totExpAmt;
  int? clntRptAmt;
  String? stat;
  double? amtDiff;

  factory ProjectExpensesResponse.fromJson(Map<String, dynamic> json) => ProjectExpensesResponse(
    projectId: json["ProjectID"],
    project: json["Project"],
    siteid: json["Siteid"],
    sitename: json["Sitename"],
    opnExpAmt: json["OPNExpAmt"],
    mtrExpAmt: json["MtrExpAmt"],
    nLbrExpAmt: json["NLbrExpAmt"],
    gLbrExpAmt: json["GLbrExpAmt"]?.toDouble(),
    sbCnExpAmt: json["SbCnExpAmt"],
    miscExpAmt: json["MiscExpAmt"],
    siteMatrExpAmt: json["SiteMatrExpAmt"],
    totExpAmt: json["TotExpAmt"]?.toDouble(),
    clntRptAmt: json["ClntRptAmt"],
    stat: json["Stat"],
    amtDiff: json["AmtDiff"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ProjectID": projectId,
    "Project": project,
    "Siteid": siteid,
    "Sitename": sitename,
    "OPNExpAmt": opnExpAmt,
    "MtrExpAmt": mtrExpAmt,
    "NLbrExpAmt": nLbrExpAmt,
    "GLbrExpAmt": gLbrExpAmt,
    "SbCnExpAmt": sbCnExpAmt,
    "MiscExpAmt": miscExpAmt,
    "SiteMatrExpAmt": siteMatrExpAmt,
    "TotExpAmt": totExpAmt,
    "ClntRptAmt": clntRptAmt,
    "Stat": stat,
    "AmtDiff": amtDiff,
  };
}


