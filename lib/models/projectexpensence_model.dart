// // To parse this JSON data, do
// //
// //     final projectExpensesResponse = projectExpensesResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// List<ProjectExpensesResponse> projectExpensesResponseFromJson(String str) => List<ProjectExpensesResponse>.from(json.decode(str).map((x) => ProjectExpensesResponse.fromJson(x)));
//
// String projectExpensesResponseToJson(List<ProjectExpensesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class ProjectExpensesResponse {
//   ProjectExpensesResponse({
//     this.projectId,
//     this.project,
//     this.siteid,
//     this.sitename,
//     this.opnExpAmt,
//     this.mtrExpAmt,
//     this.nLbrExpAmt,
//     this.gLbrExpAmt,
//     this.sbCnExpAmt,
//     this.miscExpAmt,
//     this.siteMatrExpAmt,
//     this.totExpAmt,
//     this.clntRptAmt,
//     this.stat,
//     this.amtDiff,
//   });
//
//   int? projectId;
//   String? project;
//   int? siteid;
//   String? sitename;
//   int? opnExpAmt;
//   double? mtrExpAmt;
//   double? nLbrExpAmt;
//   double? gLbrExpAmt;
//   double? sbCnExpAmt;
//   double? miscExpAmt;
//   double? siteMatrExpAmt;
//   double? totExpAmt;
//   int? clntRptAmt;
//   String? stat;
//   double? amtDiff;
//
//   factory ProjectExpensesResponse.fromJson(Map<String, dynamic> json) => ProjectExpensesResponse(
//     projectId: json["ProjectID"],
//     project: json["Project"],
//     siteid: json["Siteid"],
//     sitename: json["Sitename"],
//     opnExpAmt: json["OPNExpAmt"],
//     mtrExpAmt: json["MtrExpAmt"],
//     nLbrExpAmt: json["NLbrExpAmt"],
//     gLbrExpAmt: json["GLbrExpAmt"]?.toDouble(),
//     sbCnExpAmt: json["SbCnExpAmt"],
//     miscExpAmt: json["MiscExpAmt"],
//     siteMatrExpAmt: json["SiteMatrExpAmt"],
//     totExpAmt: json["TotExpAmt"]?.toDouble(),
//     clntRptAmt: json["ClntRptAmt"],
//     stat: json["Stat"],
//     amtDiff: json["AmtDiff"]?.toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ProjectID": projectId,
//     "Project": project,
//     "Siteid": siteid,
//     "Sitename": sitename,
//     "OPNExpAmt": opnExpAmt,
//     "MtrExpAmt": mtrExpAmt,
//     "NLbrExpAmt": nLbrExpAmt,
//     "GLbrExpAmt": gLbrExpAmt,
//     "SbCnExpAmt": sbCnExpAmt,
//     "MiscExpAmt": miscExpAmt,
//     "SiteMatrExpAmt": siteMatrExpAmt,
//     "TotExpAmt": totExpAmt,
//     "ClntRptAmt": clntRptAmt,
//     "Stat": stat,
//     "AmtDiff": amtDiff,
//   };
// }
//
//


// To parse this JSON data, do
//
//     final projectExpensesResponse = projectExpensesResponseFromJson(jsonString);

import 'dart:convert';

ProjectExpensesResponse projectExpensesResponseFromJson(String str) => ProjectExpensesResponse.fromJson(json.decode(str));

String projectExpensesResponseToJson(ProjectExpensesResponse data) => json.encode(data.toJson());

class ProjectExpensesResponse {
  bool? success;
  List<ProjectExpense>? result;
  GrandTotal? grandTotal;
  String? message;

  ProjectExpensesResponse({
    this.success,
    this.result,
    this.grandTotal,
    this.message,
  });

  factory ProjectExpensesResponse.fromJson(Map<String, dynamic> json) {
    return ProjectExpensesResponse(
      success: json["success"],
      result: json["result"] == null
          ? []
          : List<ProjectExpense>.from(
        json["result"].map((x) => ProjectExpense.fromJson(x)),
      ),
      grandTotal: json["grandTotal"] == null
          ? null
          : GrandTotal.fromJson(json["grandTotal"]),
      message: json["message"]
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
    "grandTotal": grandTotal?.toJson(),
    "message": message
  };
}

class ProjectExpense {
  String? project;
  dynamic openingExpenseAmount;
  dynamic materialExpenseAmount;
  dynamic companyLabourExpenseAmount;
  dynamic nmrLabourExpenseAmount;
  dynamic subcontractorExpenseAmount;
  dynamic miscellaneousExpenseAmount;
  dynamic siteMaterialExpenseAmount;
  dynamic journalExpenseAmount;
  dynamic totalExpenseAmount;
  dynamic clntRptAmt;
  double? amtDiff;
  List<Site>? sites;

  ProjectExpense({
    this.project,
    this.openingExpenseAmount,
    this.materialExpenseAmount,
    this.companyLabourExpenseAmount,
    this.nmrLabourExpenseAmount,
    this.subcontractorExpenseAmount,
    this.miscellaneousExpenseAmount,
    this.siteMaterialExpenseAmount,
    this.journalExpenseAmount,
    this.totalExpenseAmount,
    this.clntRptAmt,
    this.amtDiff,
    this.sites,
  });

  factory ProjectExpense.fromJson(Map<String, dynamic> json) {
    return ProjectExpense(
      project: json["projectName"],
      openingExpenseAmount: json["openingExpenseAmount"] ?? 0,
      materialExpenseAmount: json["materialExpenseAmount"] ?? 0,
      companyLabourExpenseAmount: json["companyLabourExpenseAmount"] ?? 0,
      nmrLabourExpenseAmount: json["nmrLabourExpenseAmount"] ?? 0,
      subcontractorExpenseAmount: json["subcontractorExpenseAmount"] ?? 0,
      miscellaneousExpenseAmount: json["miscellaneousExpenseAmount"] ?? 0,
      siteMaterialExpenseAmount: json["siteMaterialExpenseAmount"] ?? 0,
      journalExpenseAmount: json["journalExpenseAmount"] ?? 0,
      totalExpenseAmount: json["totalExpenseAmount"] ?? 0,
      clntRptAmt: json["clntRptAmt"] ?? 0,
      amtDiff: json["amtDiff"] ?? 0,
      sites: json["sites"] == null
          ? []
          : List<Site>.from(
        json["sites"].map((x) => Site.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "projectName": project,
    "openingExpenseAmount": openingExpenseAmount,
    "materialExpenseAmount": materialExpenseAmount,
    "companyLabourExpenseAmount": companyLabourExpenseAmount,
    "nmrLabourExpenseAmount": nmrLabourExpenseAmount,
    "subcontractorExpenseAmount": subcontractorExpenseAmount,
    "miscellaneousExpenseAmount": miscellaneousExpenseAmount,
    "siteMaterialExpenseAmount": siteMaterialExpenseAmount,
    "journalExpenseAmount": journalExpenseAmount,
    "totalExpenseAmount": totalExpenseAmount,
    "clntRptAmt": clntRptAmt,
    "amtDiff": amtDiff,
    "sites": sites == null
        ? []
        : List<dynamic>.from(sites!.map((x) => x.toJson())),
  };
}

class Site {
  int? siteId;
  String? siteName;
  dynamic openingExpenseAmount;
  dynamic materialExpenseAmount;
  dynamic companyLabourExpenseAmount;
  dynamic nmrLabourExpenseAmount;
  dynamic subcontractorExpenseAmount;
  dynamic miscellaneousExpenseAmount;
  dynamic siteMaterialExpenseAmount;
  dynamic journalExpenseAmount;
  dynamic totalExpenseAmount;
  dynamic clntRptAmt;
  dynamic amtDiff;
  String? stat;

  Site({
    this.siteId,
    this.siteName,
    this.openingExpenseAmount,
    this.materialExpenseAmount,
    this.companyLabourExpenseAmount,
    this.nmrLabourExpenseAmount,
    this.subcontractorExpenseAmount,
    this.miscellaneousExpenseAmount,
    this.siteMaterialExpenseAmount,
    this.journalExpenseAmount,
    this.totalExpenseAmount,
    this.clntRptAmt,
    this.amtDiff,
    this.stat,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      siteId: json["siteId"],
      siteName: json["siteName"],
      openingExpenseAmount: json["openingExpenseAmount"] ?? 0,
      materialExpenseAmount: json["materialExpenseAmount"] ?? 0,
      companyLabourExpenseAmount: json["companyLabourExpenseAmount"] ?? 0,
      nmrLabourExpenseAmount: json["nmrLabourExpenseAmount"] ?? 0,
      subcontractorExpenseAmount: json["subcontractorExpenseAmount"] ?? 0,
      miscellaneousExpenseAmount: json["miscellaneousExpenseAmount"] ?? 0,
      siteMaterialExpenseAmount: json["siteMaterialExpenseAmount"] ?? 0,
      journalExpenseAmount: json["journalExpenseAmount"] ?? 0,
      totalExpenseAmount: json["totalExpenseAmount"] ?? 0,
      clntRptAmt: json["clntRptAmt"] ?? 0,
      amtDiff: json["amtDiff"] ?? 0,
      stat: json["stat"],
    );
  }

  Map<String, dynamic> toJson() => {
    "siteId": siteId,
    "siteName": siteName,
    "openingExpenseAmount": openingExpenseAmount,
    "materialExpenseAmount": materialExpenseAmount,
    "companyLabourExpenseAmount": companyLabourExpenseAmount,
    "nmrLabourExpenseAmount": nmrLabourExpenseAmount,
    "subcontractorExpenseAmount": subcontractorExpenseAmount,
    "miscellaneousExpenseAmount": miscellaneousExpenseAmount,
    "siteMaterialExpenseAmount": siteMaterialExpenseAmount,
    "journalExpenseAmount": journalExpenseAmount,
    "totalExpenseAmount": totalExpenseAmount,
    "clntRptAmt": clntRptAmt,
    "amtDiff": amtDiff,
    "stat": stat,
  };
}

class GrandTotal {
  dynamic openingExpenseAmount;
  dynamic materialExpenseAmount;
  dynamic companyLabourExpenseAmount;
  dynamic nmrLabourExpenseAmount;
  dynamic subcontractorExpenseAmount;
  dynamic miscellaneousExpenseAmount;
  dynamic siteMaterialExpenseAmount;
  dynamic totalExpenseAmount;
  dynamic clntRptAmt;
  dynamic amtDiff;

  GrandTotal({
    this.openingExpenseAmount,
    this.materialExpenseAmount,
    this.companyLabourExpenseAmount,
    this.nmrLabourExpenseAmount,
    this.subcontractorExpenseAmount,
    this.miscellaneousExpenseAmount,
    this.siteMaterialExpenseAmount,
    this.totalExpenseAmount,
    this.clntRptAmt,
    this.amtDiff,
  });

  factory GrandTotal.fromJson(Map<String, dynamic> json) {
    return GrandTotal(
      openingExpenseAmount: json["openingExpenseAmount"] ?? 0,
      materialExpenseAmount: json["materialExpenseAmount"] ?? 0,
      companyLabourExpenseAmount: json["companyLabourExpenseAmount"] ?? 0,
      nmrLabourExpenseAmount: json["nmrLabourExpenseAmount"] ?? 0,
      subcontractorExpenseAmount: json["subcontractorExpenseAmount"] ?? 0,
      miscellaneousExpenseAmount: json["miscellaneousExpenseAmount"] ?? 0,
      siteMaterialExpenseAmount: json["siteMaterialExpenseAmount"] ?? 0,
      totalExpenseAmount: json["totalExpenseAmount"] ?? 0,
      clntRptAmt: json["clntRptAmt"] ?? 0,
      amtDiff: json["amtDiff"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "openingExpenseAmount": openingExpenseAmount,
    "materialExpenseAmount": materialExpenseAmount,
    "companyLabourExpenseAmount": companyLabourExpenseAmount,
    "nmrLabourExpenseAmount": nmrLabourExpenseAmount,
    "subcontractorExpenseAmount": subcontractorExpenseAmount,
    "miscellaneousExpenseAmount": miscellaneousExpenseAmount,
    "siteMaterialExpenseAmount": siteMaterialExpenseAmount,
    "totalExpenseAmount": totalExpenseAmount,
    "clntRptAmt": clntRptAmt,
    "amtDiff": amtDiff,
  };
}
