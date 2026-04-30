// To parse this JSON data, do
//
//     final punchFilterResponse = punchFilterResponseFromJson(jsonString);

import 'dart:convert';

PunchFilterResponse punchFilterResponseFromJson(String str) => PunchFilterResponse.fromJson(json.decode(str));

String punchFilterResponseToJson(PunchFilterResponse data) => json.encode(data.toJson());

class PunchFilterResponse {
  List<EmployeeTiming>? employeeTiming;

  PunchFilterResponse({
    this.employeeTiming,
  });

  factory PunchFilterResponse.fromJson(Map<String, dynamic> json) => PunchFilterResponse(
    employeeTiming: List<EmployeeTiming>.from(json["EmployeeTiming"].map((x) => EmployeeTiming.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "EmployeeTiming": List<dynamic>.from(employeeTiming!.map((x) => x.toJson())),
  };
}

class EmployeeTiming {
  String? staffName;
  List<PunchDetail>? punchDetails;

  EmployeeTiming({
    this.staffName,
    this.punchDetails,
  });

  factory EmployeeTiming.fromJson(Map<String, dynamic> json) => EmployeeTiming(
    staffName: json["StaffName"],
    punchDetails: List<PunchDetail>.from(json["PunchDetails"].map((x) => PunchDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "StaffName": staffName,
    "PunchDetails": List<dynamic>.from(punchDetails!.map((x) => x.toJson())),
  };
}

class PunchDetail {
  String? punchInDate;
  String? punchOutDate;
  String? punchInProjectName;
  String? punchOutProjectName;
  String? punchInTime;
  String? punchOutTime;
  String? punchInOnDutyStatus;
  String? punchOutOnDutyStatus;
  String? punchInOnDutyAddress;
  String? punchOutOnDutyAddress;
  String? isDifference;

  PunchDetail({
    this.punchInDate,
    this.punchOutDate,
    this.punchInProjectName,
    this.punchOutProjectName,
    this.punchInTime,
    this.punchOutTime,
    this.punchInOnDutyStatus,
    this.punchOutOnDutyStatus,
    this.punchInOnDutyAddress,
    this.punchOutOnDutyAddress,
    this.isDifference,
  });

  factory PunchDetail.fromJson(Map<String, dynamic> json) => PunchDetail(
    punchInDate: json["PunchInDate"],
    punchOutDate: json["PunchOutDate"],
    punchInProjectName: json["PunchInProjectName"],
    punchOutProjectName: json["PunchOutProjectName"],
    punchInTime: json["PunchInTime"],
    punchOutTime: json["PunchOutTime"],
    punchInOnDutyStatus: json["PunchInOnDutyStatus"],
    punchOutOnDutyStatus: json["PunchOutOnDutyStatus"],
    punchInOnDutyAddress: json["PunchInOnDutyAddress"],
    punchOutOnDutyAddress: json["PunchOutOnDutyAddress"],
    isDifference: json["IsDifference"],
  );

  Map<String, dynamic> toJson() => {
    "PunchInDate": punchInDate,
    "PunchOutDate": punchOutDate,
    "PunchInProjectName": punchInProjectName,
    "PunchOutProjectName": punchOutProjectName,
    "PunchInTime": punchInTime,
    "PunchOutTime": punchOutTime,
    "PunchInOnDutyStatus": punchInOnDutyStatus,
    "PunchOutOnDutyStatus": punchOutOnDutyStatus,
    "PunchInOnDutyAddress": punchInOnDutyAddress,
    "PunchOutOnDutyAddress": punchOutOnDutyAddress,
    "IsDifference": isDifference,
  };
}
