// To parse this JSON data, do
//
//     final hrDashboardResponse = hrDashboardResponseFromJson(jsonString);

import 'dart:convert';

HrDashboardResponse hrDashboardResponseFromJson(String str) => HrDashboardResponse.fromJson(json.decode(str));

String hrDashboardResponseToJson(HrDashboardResponse data) => json.encode(data.toJson());

class HrDashboardResponse {
  bool? success;
  Result? result;

  HrDashboardResponse({
    this.success,
    this.result,
  });

  factory HrDashboardResponse.fromJson(Map<String, dynamic> json) => HrDashboardResponse(
    success: json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?null:result!.toJson(),
  };
}

class Result {
  KpiCards? kpiCards;
  StaffAttendance? staffAttendance;
  TodayPunchOverview? todayPunchOverview;
  LeaveOverview? leaveOverview;
  PendingLeaveRequest? pendingLeaveRequest;
  List<RecentActivity>? recentActivity;
  List<UpcomingHoliday>? upcomingHoliday;
  List<MonthlyAttendance>? monthlyAttendance;

  Result({
    this.kpiCards,
    this.staffAttendance,
    this.todayPunchOverview,
    this.leaveOverview,
    this.pendingLeaveRequest,
    this.recentActivity,
    this.upcomingHoliday,
    this.monthlyAttendance,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    kpiCards: json["kpiCards"] == null ? null : KpiCards.fromJson(json["kpiCards"]),
    staffAttendance: json["staffAttendance"] == null ? null : StaffAttendance.fromJson(json["staffAttendance"]),
    todayPunchOverview: json["todayPunchOverview"] == null ? null : TodayPunchOverview.fromJson(json["todayPunchOverview"]),
    leaveOverview: json["leaveOverview"] == null ? null : LeaveOverview.fromJson(json["leaveOverview"]),
    pendingLeaveRequest: json["pendingLeaveRequest"] == null ? null : PendingLeaveRequest.fromJson(json["pendingLeaveRequest"]),
    recentActivity: json["recentActivity"] == null ? [] : List<RecentActivity>.from(json["recentActivity"]!.map((x) => RecentActivity.fromJson(x))),
    upcomingHoliday: json["upcomingHoliday"] == null ? [] : List<UpcomingHoliday>.from(json["upcomingHoliday"]!.map((x) => UpcomingHoliday.fromJson(x))),
    monthlyAttendance: json["monthlyAttendance"] == null ? [] : List<MonthlyAttendance>.from(json["monthlyAttendance"]!.map((x) => MonthlyAttendance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kpiCards": kpiCards?.toJson(),
    "staffAttendance": staffAttendance?.toJson(),
    "todayPunchOverview": todayPunchOverview?.toJson(),
    "leaveOverview": leaveOverview?.toJson(),
    "pendingLeaveRequest": pendingLeaveRequest?.toJson(),
    "recentActivity": recentActivity == null ? [] : List<dynamic>.from(recentActivity!.map((x) => x.toJson())),
    "upcomingHoliday": upcomingHoliday == null ? [] : List<dynamic>.from(upcomingHoliday!.map((x) => x.toJson())),
    "monthlyAttendance": monthlyAttendance == null ? [] : List<dynamic>.from(monthlyAttendance!.map((x) => x.toJson())),
  };
}

class KpiCards {
  int? activeEmployee;
  int? totalPresentEmployee;
  String? presentPercentage;
  int? onLeaveEmployee;
  String? onLeavePercentage;
  int? latePunchinEmployee;
  String? latePunchInPercentage;
  int? onTimePunchinEmployee;
  String? onTimePunchinPercentage;
  int? absentEmployee;
  String? absentPercentage;

  KpiCards({
    this.activeEmployee,
    this.totalPresentEmployee,
    this.presentPercentage,
    this.onLeaveEmployee,
    this.onLeavePercentage,
    this.latePunchinEmployee,
    this.latePunchInPercentage,
    this.onTimePunchinEmployee,
    this.onTimePunchinPercentage,
    this.absentEmployee,
    this.absentPercentage,
  });

  factory KpiCards.fromJson(Map<String, dynamic> json) => KpiCards(
    activeEmployee: json["activeEmployee"],
    totalPresentEmployee: json["totalPresentEmployee"],
    presentPercentage: json["presentPercentage"],
    onLeaveEmployee: json["onLeaveEmployee"],
    onLeavePercentage: json["onLeavePercentage"],
    latePunchinEmployee: json["latePunchinEmployee"],
    latePunchInPercentage: json["latePunchInPercentage"],
    onTimePunchinEmployee: json["onTimePunchinEmployee"],
    onTimePunchinPercentage: json["onTimePunchinPercentage"],
    absentEmployee: json["absentEmployee"],
    absentPercentage: json["absentPercentage"],
  );

  Map<String, dynamic> toJson() => {
    "activeEmployee": activeEmployee,
    "totalPresentEmployee": totalPresentEmployee,
    "presentPercentage": presentPercentage,
    "onLeaveEmployee": onLeaveEmployee,
    "onLeavePercentage": onLeavePercentage,
    "latePunchinEmployee": latePunchinEmployee,
    "latePunchInPercentage": latePunchInPercentage,
    "onTimePunchinEmployee": onTimePunchinEmployee,
    "onTimePunchinPercentage": onTimePunchinPercentage,
    "absentEmployee": absentEmployee,
    "absentPercentage": absentPercentage,
  };
}

class LeaveOverview {
  int? leaveUsed;
  int? remainingLeave;
  double? remainingLeavePercentage;
  double? leaveUsedPercentage;

  LeaveOverview({
    this.leaveUsed,
    this.remainingLeave,
    this.remainingLeavePercentage,
    this.leaveUsedPercentage,
  });

  factory LeaveOverview.fromJson(Map<String, dynamic> json) => LeaveOverview(
    leaveUsed: json["leaveUsed"],
    remainingLeave: json["remainingLeave"],
    remainingLeavePercentage: json["remainingLeavePercentage"],
    leaveUsedPercentage: json["leaveUsedPercentage"],
  );

  Map<String, dynamic> toJson() => {
    "leaveUsed": leaveUsed,
    "remainingLeave": remainingLeave,
    "remainingLeavePercentage": remainingLeavePercentage,
    "leaveUsedPercentage": leaveUsedPercentage,
  };
}

class MonthlyAttendance {
  int? monthNum;
  String? monthName;
  int? presentCount;
  int? activeEmployeeCount;
  double? attendancePercentage;

  MonthlyAttendance({
    this.monthNum,
    this.monthName,
    this.presentCount,
    this.activeEmployeeCount,
    this.attendancePercentage,
  });

  factory MonthlyAttendance.fromJson(Map<String, dynamic> json) => MonthlyAttendance(
    monthNum: json["MonthNum"],
    monthName: json["MonthName"],
    presentCount: json["PresentCount"],
    activeEmployeeCount: json["ActiveEmployeeCount"],
    attendancePercentage: json["AttendancePercentage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "MonthNum": monthNum,
    "MonthName": monthName,
    "PresentCount": presentCount,
    "ActiveEmployeeCount": activeEmployeeCount,
    "AttendancePercentage": attendancePercentage,
  };
}

class PendingLeaveRequest {
  int? pendingLeaveRequest;
  int? pendingPermissionRequest;
  int? pendingCompensateLeaveRequest;
  int? pendingOnDutyLeaveRequest;

  PendingLeaveRequest({
    this.pendingLeaveRequest,
    this.pendingPermissionRequest,
    this.pendingCompensateLeaveRequest,
    this.pendingOnDutyLeaveRequest,
  });

  factory PendingLeaveRequest.fromJson(Map<String, dynamic> json) => PendingLeaveRequest(
    pendingLeaveRequest: json["pendingLeaveRequest"],
    pendingPermissionRequest: json["pendingPermissionRequest"],
    pendingCompensateLeaveRequest: json["pendingCompensateLeaveRequest"],
    pendingOnDutyLeaveRequest: json["pendingOnDutyLeaveRequest"],
  );

  Map<String, dynamic> toJson() => {
    "pendingLeaveRequest": pendingLeaveRequest,
    "pendingPermissionRequest": pendingPermissionRequest,
    "pendingCompensateLeaveRequest": pendingCompensateLeaveRequest,
    "pendingOnDutyLeaveRequest": pendingOnDutyLeaveRequest,
  };
}

class StaffAttendance {
  double? presentPercentage;
  double? onLeavePercentage;
  double? latePunchInPercentage;
  double? absentPercentage;

  StaffAttendance({
    this.presentPercentage,
    this.onLeavePercentage,
    this.latePunchInPercentage,
    this.absentPercentage,
  });

  factory StaffAttendance.fromJson(Map<String, dynamic> json) => StaffAttendance(
    presentPercentage: json["presentPercentage"],
    onLeavePercentage: json["onLeavePercentage"],
    latePunchInPercentage: json["latePunchInPercentage"],
    absentPercentage: json["absentPercentage"],
  );

  Map<String, dynamic> toJson() => {
    "presentPercentage": presentPercentage,
    "onLeavePercentage": onLeavePercentage,
    "latePunchInPercentage": latePunchInPercentage,
    "absentPercentage": absentPercentage,
  };
}

class TodayPunchOverview {
  int? totalPunchOut;
  int? missingpunchout;
  int? latePunchOutEmployee;

  TodayPunchOverview({
    this.totalPunchOut,
    this.missingpunchout,
    this.latePunchOutEmployee,
  });

  factory TodayPunchOverview.fromJson(Map<String, dynamic> json) => TodayPunchOverview(
    totalPunchOut: json["totalPunchOut"],
    missingpunchout: json["missingpunchout"],
    latePunchOutEmployee: json["latePunchOutEmployee"],
  );

  Map<String, dynamic> toJson() => {
    "totalPunchOut": totalPunchOut,
    "missingpunchout": missingpunchout,
    "latePunchOutEmployee": latePunchOutEmployee,
  };
}

class UpcomingHoliday {
  String? dateValue;
  String? holidayRemarks;
  int? remainingDays;

  UpcomingHoliday({
    this.dateValue,
    this.holidayRemarks,
    this.remainingDays,
  });

  factory UpcomingHoliday.fromJson(Map<String, dynamic> json) => UpcomingHoliday(
    dateValue: json["DateValue"],
    holidayRemarks: json["HolidayRemarks"],
    remainingDays: json["RemainingDays"],
  );

  Map<String, dynamic> toJson() => {
    "DateValue": dateValue,
    "HolidayRemarks": holidayRemarks,
    "RemainingDays": remainingDays,
  };
}

class RecentActivity {
  String? punchNo;
  String? employeeName;
  String? indate;
  String? inTime;
  String? outDate;
  String? outTime;
  String? inLoc;
  String? outLoc;
  String? instatus;
  String? outstatus;
  String? onpininaddress;
  String? onpinoutaddress;

  RecentActivity({
    this.punchNo,
    this.employeeName,
    this.indate,
    this.inTime,
    this.outDate,
    this.outTime,
    this.inLoc,
    this.outLoc,
    this.instatus,
    this.outstatus,
    this.onpininaddress,
    this.onpinoutaddress,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) => RecentActivity(
    punchNo: json["PunchNo"],
    employeeName: json["EmployeeName"],
    indate: json["Indate"],
    inTime: json["InTime"],
    outDate: json["OutDate"],
    outTime: json["OutTime"],
    inLoc: json["InLoc"],
    outLoc: json["OutLoc"],
    instatus: json["instatus"],
    outstatus: json["outstatus"],
    onpininaddress: json["onpininaddress"],
    onpinoutaddress: json["onpinoutaddress"],
  );

  Map<String, dynamic> toJson() => {
    "PunchNo": punchNo,
    "EmployeeName": employeeName,
    "Indate": indate,
    "InTime": inTime,
    "OutDate": outDate,
    "OutTime": outTime,
    "InLoc": inLoc,
    "OutLoc": outLoc,
    "instatus": instatus,
    "outstatus": outstatus,
    "onpininaddress": onpininaddress,
    "onpinoutaddress": onpinoutaddress,
  };
}
