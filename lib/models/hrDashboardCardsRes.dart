// To parse this JSON data, do
//
//     final hrDashboardCardsListRes = hrDashboardCardsListResFromJson(jsonString);

import 'dart:convert';

HrDashboardCardsListRes hrDashboardCardsListResFromJson(String str) => HrDashboardCardsListRes.fromJson(json.decode(str));

String hrDashboardCardsListResToJson(HrDashboardCardsListRes data) => json.encode(data.toJson());

class HrDashboardCardsListRes {
  bool? success;
  Result? result;
  String? message;

  HrDashboardCardsListRes({
    this.success,
    this.result,
    this.message,
  });

  factory HrDashboardCardsListRes.fromJson(Map<String, dynamic> json) => HrDashboardCardsListRes(
    success: json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
    "message": message
  };
}

class Result {
  List<Employee>? activeEmployee;
  List<Employee>? presentEmployee;
  List<Employee>? onLeaveEmployee;
  List<Employee>? lateEmployee;
  List<Employee>? onTimeEmployee;
  List<Employee>? absentEmployee;

  Result({
    this.activeEmployee,
    this.presentEmployee,
    this.onLeaveEmployee,
    this.lateEmployee,
    this.onTimeEmployee,
    this.absentEmployee,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    activeEmployee: json["activeEmployee"] == null ? [] : List<Employee>.from(json["activeEmployee"]!.map((x) => Employee.fromJson(x))),
    presentEmployee: json["presentEmployee"] == null ? [] : List<Employee>.from(json["presentEmployee"]!.map((x) => Employee.fromJson(x))),
    onLeaveEmployee: json["onLeaveEmployee"] == null ? [] : List<Employee>.from(json["onLeaveEmployee"]!.map((x) => Employee.fromJson(x))),
    lateEmployee: json["lateEmployee"] == null ? [] : List<Employee>.from(json["lateEmployee"]!.map((x) => Employee.fromJson(x))),
    onTimeEmployee: json["onTimeEmployee"] == null ? [] : List<Employee>.from(json["onTimeEmployee"]!.map((x) => Employee.fromJson(x))),
    absentEmployee: json["absentEmployee"] == null ? [] : List<Employee>.from(json["absentEmployee"]!.map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "activeEmployee": activeEmployee == null ? [] : List<dynamic>.from(activeEmployee!.map((x) => x.toJson())),
    "presentEmployee": presentEmployee == null ? [] : List<dynamic>.from(presentEmployee!.map((x) => x.toJson())),
    "onLeaveEmployee": onLeaveEmployee == null ? [] : List<dynamic>.from(onLeaveEmployee!.map((x) => x)),
    "lateEmployee": lateEmployee == null ? [] : List<dynamic>.from(lateEmployee!.map((x) => x.toJson())),
    "onTimeEmployee": onTimeEmployee == null ? [] : List<dynamic>.from(onTimeEmployee!.map((x) => x.toJson())),
    "absentEmployee": absentEmployee == null ? [] : List<dynamic>.from(absentEmployee!.map((x) => x.toJson())),
  };
}

class Employee {
  String? employeeName;

  Employee({
    this.employeeName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    employeeName: json["EmployeeName"],
  );

  Map<String, dynamic> toJson() => {
    "EmployeeName": employeeName,
  };
}
