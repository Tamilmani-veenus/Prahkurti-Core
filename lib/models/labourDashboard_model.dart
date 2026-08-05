// To parse this JSON data, do
//
//     final labourDashboardResponse = labourDashboardResponseFromJson(jsonString);

import 'dart:convert';

LabourDashboardResponse labourDashboardResponseFromJson(String str) => LabourDashboardResponse.fromJson(json.decode(str));

String labourDashboardResponseToJson(LabourDashboardResponse data) => json.encode(data.toJson());

class LabourDashboardResponse {
  bool? success;
  int? totalLabourStrength;
  int? totalLabourDifference;
  List<NmrLabourDetail>? nmrLabourDetails;
  List<RateWorkDetail>? rateWorkDetails;
  int? activeSubContractors;
  int? pendingAttendanceApprovals;
  List<LabourCategoryWise>? labourCategoryWise;
  double? totalLabourCount;
  List<TodayAttendance>? todayAttendance;
  List<LabourCost>? labourCost;
  List<TodayLabourCost>? todayLabourCost;
  List<ProjectWiseLabour>? projectWiseLabour;
  List<SubContractorWiseLabour>? subContractorWiseLabour;
  int? dprApproval;
  int? subContAttendanceApprovalPendingCount;
  int? subConNmrBillAppPending;
  int? billAppDirectCount;
  int? boqBillApprovalCount;
  List<SubContractPaymentPending>? subContractPaymentPending;
  List<SubContractorWiseLabourTradeChart>? subContractorWiseLabourTradeChart;


  LabourDashboardResponse({
    this.success,
    this.totalLabourStrength,
    this.totalLabourDifference,
    this.nmrLabourDetails,
    this.rateWorkDetails,
    this.activeSubContractors,
    this.pendingAttendanceApprovals,
    this.labourCategoryWise,
    this.totalLabourCount,
    this.todayAttendance,
    this.labourCost,
    this.todayLabourCost,
    this.projectWiseLabour,
    this.subContractorWiseLabour,
    this.dprApproval,
    this.subContAttendanceApprovalPendingCount,
    this.subConNmrBillAppPending,
    this.billAppDirectCount,
    this.boqBillApprovalCount,
    this.subContractPaymentPending,
    this.subContractorWiseLabourTradeChart,
  });

  factory LabourDashboardResponse.fromJson(Map<String, dynamic> json) => LabourDashboardResponse(
    success: json["success"],
    totalLabourStrength: json["totalLabourStrength"],
    totalLabourDifference: json["totalLabourDifference"],
    nmrLabourDetails: json["nmrLabourDetails"] == null
        ? []
        : List<NmrLabourDetail>.from(
      json["nmrLabourDetails"]
          .map((x) => NmrLabourDetail.fromJson(x)),
    ),
    rateWorkDetails: json["rateWorkDetails"] == null
        ? []
        : List<RateWorkDetail>.from(
      json["rateWorkDetails"]
          .map((x) => RateWorkDetail.fromJson(x)),
    ),
    activeSubContractors: json["activeSubContractors"],
    pendingAttendanceApprovals: json["pendingAttendanceApprovals"],
    labourCategoryWise: json["labourCategoryWise"] == null
        ? []
        : List<LabourCategoryWise>.from(
      json["labourCategoryWise"]
          .map((x) => LabourCategoryWise.fromJson(x)),
    ),
    totalLabourCount: json["totalLabourCount"],
    todayAttendance: json["todayAttendance"] == null
        ? []
        : List<TodayAttendance>.from(
      json["todayAttendance"]
          .map((x) => TodayAttendance.fromJson(x)),
    ),
    labourCost: json["labourCost"] == null
        ? []
        : List<LabourCost>.from(
      json["labourCost"]
          .map((x) => LabourCost.fromJson(x)),
    ),
    todayLabourCost: json["todayLabourCost"] == null
        ? []
        : List<TodayLabourCost>.from(
        json["todayLabourCost"].map((x) => TodayLabourCost.fromJson(x))
    ),
    projectWiseLabour: json["projectWiseLabour"] == null
        ? []
        : List<ProjectWiseLabour>.from(
        json["projectWiseLabour"].map((x) => ProjectWiseLabour.fromJson(x))
    ),
    subContractorWiseLabour: json["subContractorWiseLabour"] == null
        ? []
        : List<SubContractorWiseLabour>.from(
        json["subContractorWiseLabour"].map((x) => SubContractorWiseLabour.fromJson(x))
    ),
    dprApproval: json["dprApproval"],
    subContAttendanceApprovalPendingCount: json["subContAttendanceApprovalPendingCount"],
    subConNmrBillAppPending: json["subConNMRBillAppPending"],
    billAppDirectCount: json["billAppDirectCount"],
    boqBillApprovalCount: json["boqBillApprovalCount"],
    subContractPaymentPending: json["subContractPaymentPending"] == null
        ? []
        : List<SubContractPaymentPending>.from(
        json["subContractPaymentPending"].map((x) => SubContractPaymentPending.fromJson(x))
    ),
    subContractorWiseLabourTradeChart: json["subContractorWiseLabourTradeChart"] == null
        ? []
        : List<SubContractorWiseLabourTradeChart>.from(
        json["subContractorWiseLabourTradeChart"].map((x) => SubContractorWiseLabourTradeChart.fromJson(x))
    ),

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "totalLabourStrength": totalLabourStrength,
    "totalLabourDifference": totalLabourDifference,
    "nmrLabourDetails": List<dynamic>.from(nmrLabourDetails!.map((x) => x.toJson())),
    "rateWorkDetails": List<dynamic>.from(rateWorkDetails!.map((x) => x.toJson())),
    "activeSubContractors": activeSubContractors,
    "pendingAttendanceApprovals": pendingAttendanceApprovals,
    "labourCategoryWise": List<dynamic>.from(labourCategoryWise!.map((x) => x.toJson())),
    "totalLabourCount": totalLabourCount,
    "todayAttendance": List<dynamic>.from(todayAttendance!.map((x) => x.toJson())),
    "labourCost": List<dynamic>.from(labourCost!.map((x) => x.toJson())),
    "todayLabourCost": List<dynamic>.from(todayLabourCost!.map((x) => x.toJson())),
    "projectWiseLabour": List<dynamic>.from(projectWiseLabour!.map((x) => x.toJson())),
    "subContractorWiseLabour": List<dynamic>.from(subContractorWiseLabour!.map((x) => x.toJson())),
    "dprApproval": dprApproval,
    "subContAttendanceApprovalPendingCount": subContAttendanceApprovalPendingCount,
    "subConNMRBillAppPending": subConNmrBillAppPending,
    "billAppDirectCount": billAppDirectCount,
    "boqBillApprovalCount": boqBillApprovalCount,
    "subContractPaymentPending": List<dynamic>.from(subContractPaymentPending!.map((x) => x.toJson())),
    "subContractorWiseLabourTradeChart": List<dynamic>.from(subContractorWiseLabourTradeChart!.map((x) => x.toJson())),

  };
}

class LabourCategoryWise {
  int? labourCategoryId;
  String? categoryName;
  double? totalNos;

  LabourCategoryWise({
    this.labourCategoryId,
    this.categoryName,
    this.totalNos,
  });

  factory LabourCategoryWise.fromJson(Map<String, dynamic> json) => LabourCategoryWise(
    labourCategoryId: json["LabourCategoryId"],
    categoryName: json["CategoryName"],
    totalNos: json["TotalNos"],
  );

  Map<String, dynamic> toJson() => {
    "LabourCategoryId": labourCategoryId,
    "CategoryName": categoryName,
    "TotalNos": totalNos,
  };
}

class LabourCost {
  String? labourAttendanceDate;
  String? labourCost;

  LabourCost({
    this.labourAttendanceDate,
    this.labourCost,
  });

  factory LabourCost.fromJson(Map<String, dynamic> json) => LabourCost(
    labourAttendanceDate: json["LabourAttendanceDate"],
    labourCost: json["LabourCost"],
  );

  Map<String, dynamic> toJson() => {
    "LabourAttendanceDate": labourAttendanceDate,
    "LabourCost": labourCost,
  };
}

class NmrLabourDetail {
  double? totalNmrNos;
  String? totalNmrAmount;

  NmrLabourDetail({
    this.totalNmrNos,
    this.totalNmrAmount,
  });

  factory NmrLabourDetail.fromJson(Map<String, dynamic> json) => NmrLabourDetail(
    totalNmrNos: json["TotalNMRNos"],
    totalNmrAmount: json["TotalNMRAmount"],
  );

  Map<String, dynamic> toJson() => {
    "TotalNMRNos": totalNmrNos,
    "TotalNMRAmount": totalNmrAmount,
  };
}

class RateWorkDetail {
  double? totalNosRateWise;
  String? totalAmountRateWise;

  RateWorkDetail({
    this.totalNosRateWise,
    this.totalAmountRateWise,
  });

  factory RateWorkDetail.fromJson(Map<String, dynamic> json) => RateWorkDetail(
    totalNosRateWise: json["TotalNosRateWise"],
    totalAmountRateWise: json["TotalAmountRateWise"],
  );

  Map<String, dynamic> toJson() => {
    "TotalNosRateWise": totalNosRateWise,
    "TotalAmountRateWise": totalAmountRateWise,
  };
}

class TodayAttendance {
  int? id;
  String? labourAttendanceNo;
  String? labourAttendanceDate;
  String? workType;
  String? workTypName;
  String? workShift;
  int? projectId;
  String? projectName;
  int? siteId;
  String? siteName;
  int? subContractorId;
  String? subContractorName;
  int? createdBy;
  String? employeeName;
  double? totNos;
  double? totAmt;
  String? approveStatus;
  String? appType;

  TodayAttendance({
    this.id,
    this.labourAttendanceNo,
    this.labourAttendanceDate,
    this.workType,
    this.workTypName,
    this.workShift,
    this.projectId,
    this.projectName,
    this.siteId,
    this.siteName,
    this.subContractorId,
    this.subContractorName,
    this.createdBy,
    this.employeeName,
    this.totNos,
    this.totAmt,
    this.approveStatus,
    this.appType,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) => TodayAttendance(
    id: json["Id"],
    labourAttendanceNo: json["LabourAttendanceNo"],
    labourAttendanceDate: json["LabourAttendanceDate"],
    workType: json["WorkType"],
    workTypName: json["WorkTypName"],
    workShift: json["WorkShift"],
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    subContractorId: json["SubContractorId"],
    subContractorName: json["SubContractorName"],
    createdBy: json["CreatedBy"],
    employeeName: json["EmployeeName"],
    totNos: json["TotNos"],
    totAmt: json["TotAmt"].toDouble(),
    approveStatus: json["ApproveStatus"],
    appType: json["AppType"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "LabourAttendanceNo": labourAttendanceNo,
    "LabourAttendanceDate": labourAttendanceDate,
    "WorkType": workType,
    "WorkTypName": workTypName,
    "WorkShift": workShift,
    "ProjectId": projectId,
    "ProjectName": projectName,
    "SiteId": siteId,
    "SiteName": siteName,
    "SubContractorId": subContractorId,
    "SubContractorName": subContractorName,
    "CreatedBy": createdBy,
    "EmployeeName": employeeName,
    "TotNos": totNos,
    "TotAmt": totAmt,
    "ApproveStatus": approveStatus,
    "AppType": appType,
  };
}

class TodayLabourCost {
  String? todayLabourCost;
  String? yesterdayLabourCost;
  String? differenceAmount;
  double? differencePercentage;
  String? differenceType;

  TodayLabourCost({
    this.todayLabourCost,
    this.yesterdayLabourCost,
    this.differenceAmount,
    this.differencePercentage,
    this.differenceType,
  });

  factory TodayLabourCost.fromJson(Map<String, dynamic> json) => TodayLabourCost(
    todayLabourCost: json["TodayLabourCost"],
    yesterdayLabourCost: json["YesterdayLabourCost"],
    differenceAmount: json["DifferenceAmount"],
    differencePercentage: json["DifferencePercentage"],
    differenceType: json["DifferenceType"],
  );

  Map<String, dynamic> toJson() => {
    "TodayLabourCost": todayLabourCost,
    "YesterdayLabourCost": yesterdayLabourCost,
    "DifferenceAmount": differenceAmount,
    "DifferencePercentage": differencePercentage,
    "DifferenceType": differenceType,
  };
}

class ProjectWiseLabour {
  int? projectId;
  String? projectName;
  double? nmrNos;
  double? rateNos;
  double? totalNos;
  double? nmrPercent;
  double? ratePercent;

  ProjectWiseLabour({
    this.projectId,
    this.projectName,
    this.nmrNos,
    this.rateNos,
    this.totalNos,
    this.nmrPercent,
    this.ratePercent,
  });

  factory ProjectWiseLabour.fromJson(Map<String, dynamic> json) => ProjectWiseLabour(
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    nmrNos: json["NMRNos"]?.toDouble(),
    rateNos: json["RateNos"]?.toDouble(),
    totalNos: json["TotalNos"]?.toDouble(),
    nmrPercent: json["NMRPercent"]?.toDouble(),
    ratePercent: json["RatePercent"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "ProjectName": projectName,
    "NMRNos": nmrNos,
    "RateNos": rateNos,
    "TotalNos": totalNos,
    "NMRPercent": nmrPercent,
    "RatePercent": ratePercent,
  };


}


class SubContractorWiseLabour {
  int? subcontractorId;
  String? subcontractName;
  double? labourCount;

  SubContractorWiseLabour({
     this.subcontractorId,
     this.subcontractName,
     this.labourCount,
  });

  factory SubContractorWiseLabour.fromJson(Map<String, dynamic> json) => SubContractorWiseLabour(
    subcontractorId: json["SubcontractorId"],
    subcontractName: json["SubcontractName"],
    labourCount: json["LabourCount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "SubcontractorId": subcontractorId,
    "SubcontractName": subcontractName,
    "LabourCount": labourCount,
  };
}

class SubContractPaymentPending {
  int? paymentId;
  int? workId;
  String? workNo;
  String? workDate;
  int? projectId;
  String? projectName;
  int? siteid;
  String? siteName;
  int? subContractorId;
  String? subcontractName;
  String? billNo;
  double? netPayAmount;
  double? paidAmt;
  double? balAmt;
  String? billType;
  String? billTypeId;
  int? companyId;
  String? createdByName;
  String? approvedByName;

  SubContractPaymentPending({
    this.paymentId,
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.projectName,
    this.siteid,
    this.siteName,
    this.subContractorId,
    this.subcontractName,
    this.billNo,
    this.netPayAmount,
    this.paidAmt,
    this.balAmt,
    this.billType,
    this.billTypeId,
    this.companyId,
    this.createdByName,
    this.approvedByName,
  });

  factory SubContractPaymentPending.fromJson(Map<String, dynamic> json) => SubContractPaymentPending(
    paymentId: json["PaymentId"],
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    siteid: json["siteid"],
    siteName: json["SiteName"],
    subContractorId: json["SubContractorId"],
    subcontractName: json["SubcontractName"],
    billNo: json["BillNo"],
    netPayAmount: json["NetPayAmount"]?.toDouble(),
    paidAmt: json["PaidAmt"],
    balAmt: json["BalAmt"]?.toDouble(),
    billType: json["BillType"],
    billTypeId: json["BillTypeId"],
    companyId: json["CompanyID"],
    createdByName: json["CreatedByName"],
    approvedByName: json["ApprovedByName"],
  );

  Map<String, dynamic> toJson() => {
    "PaymentId": paymentId,
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "ProjectName": projectName,
    "siteid": siteid,
    "SiteName": siteName,
    "SubContractorId": subContractorId,
    "SubcontractName": subcontractName,
    "BillNo": billNo,
    "NetPayAmount": netPayAmount,
    "PaidAmt": paidAmt,
    "BalAmt": balAmt,
    "BillType": billType,
    "BillTypeId": billTypeId,
    "CompanyID": companyId,
    "CreatedByName": createdByName,
    "ApprovedByName": approvedByName,
  };
}

class SubContractorWiseLabourTradeChart {
  int? subcontractorId;
  String? subcontractName;
  double? nmrNos;
  double? rateNos;
  double? totalNos;
  double? nmrPercent;
  double? ratePercent;

  SubContractorWiseLabourTradeChart({
    this.subcontractorId,
    this.subcontractName,
    this.nmrNos,
    this.rateNos,
    this.totalNos,
    this.nmrPercent,
    this.ratePercent,
  });

  factory SubContractorWiseLabourTradeChart.fromJson(Map<String, dynamic> json) => SubContractorWiseLabourTradeChart(
    subcontractorId: json["SubcontractorId"],
    subcontractName: json["SubcontractName"],
    nmrNos: json["NMRNos"]?.toDouble(),
    rateNos: json["RateNos"]?.toDouble(),
    totalNos: json["TotalNos"]?.toDouble(),
    nmrPercent: json["NMRPercent"]?.toDouble(),
    ratePercent: json["RatePercent"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "SubcontractorId": subcontractorId,
    "SubcontractName": subcontractName,
    "NMRNos": nmrNos,
    "RateNos": rateNos,
    "TotalNos": totalNos,
    "NMRPercent": nmrPercent,
    "RatePercent": ratePercent,
  };
}















