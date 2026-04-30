//
//
// // To parse this JSON data, do
// //
// //     final todayPunchInResponse = todayPunchInResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// TodayPunchInResponse todayPunchInResponseFromJson(String str) => TodayPunchInResponse.fromJson(json.decode(str));
//
// String todayPunchInResponseToJson(TodayPunchInResponse data) => json.encode(data.toJson());
//
// class TodayPunchInResponse {
//   List<EmployeeTimingTodaywise> employeeTimingTodaywise;
//
//   TodayPunchInResponse({
//     required this.employeeTimingTodaywise,
//   });
//
//   factory TodayPunchInResponse.fromJson(Map<String, dynamic> json) => TodayPunchInResponse(
//     employeeTimingTodaywise: List<EmployeeTimingTodaywise>.from(json["EmployeeTimingTodaywise"].map((x) => EmployeeTimingTodaywise.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "EmployeeTimingTodaywise": List<dynamic>.from(employeeTimingTodaywise.map((x) => x.toJson())),
//   };
// }
//
// class EmployeeTimingTodaywise {
//   String staffName;
//   List<PunchDetail> punchDetails;
//
//   EmployeeTimingTodaywise({
//     required this.staffName,
//     required this.punchDetails,
//   });
//
//   factory EmployeeTimingTodaywise.fromJson(Map<String, dynamic> json) => EmployeeTimingTodaywise(
//     staffName: json["StaffName"],
//     punchDetails: List<PunchDetail>.from(json["PunchDetails"].map((x) => PunchDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "StaffName": staffName,
//     "PunchDetails": List<dynamic>.from(punchDetails.map((x) => x.toJson())),
//   };
// }
//
// class PunchDetail {
//   DateTime punchInDate;
//   String punchOutDate;
//   String punchInProjectName;
//   String punchOutProjectName;
//   String punchInTime;
//   String punchOutTime;
//   String allocateStatus;
//   // String punchInOnDutyAddress;
//   // String punchOutOnDutyAddress;
//
//   PunchDetail({
//     required this.punchInDate,
//     required this.punchOutDate,
//     required this.punchInProjectName,
//     required this.punchOutProjectName,
//     required this.punchInTime,
//     required this.punchOutTime,
//     required this.allocateStatus,
//     // required this.punchInOnDutyAddress,
//     // required this.punchOutOnDutyAddress,
//   });
//
//   factory PunchDetail.fromJson(Map<String, dynamic> json) => PunchDetail(
//     punchInDate: DateTime.parse(json["PunchInDate"]),
//     punchOutDate: json["PunchOutDate"],
//     punchInProjectName: json["PunchInProjectName"],
//     punchOutProjectName: json["PunchOutProjectName"],
//     punchInTime: json["PunchInTime"],
//     punchOutTime: json["PunchOutTime"],
//     allocateStatus: json["PunchInStatus"],
//     // punchInOnDutyAddress: json["PunchInOnDutyAddress"],
//     // punchOutOnDutyAddress: json["PunchOutOnDutyAddress"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "PunchInDate": "${punchInDate.year.toString().padLeft(4, '0')}-${punchInDate.month.toString().padLeft(2, '0')}-${punchInDate.day.toString().padLeft(2, '0')}",
//     "PunchOutDate": punchOutDate,
//     "PunchInProjectName": punchInProjectName,
//     "PunchOutProjectName": punchOutProjectName,
//     "PunchInTime": punchInTime,
//     "PunchOutTime": punchOutTime,
//     "PunchInStatus": allocateStatus,
//     // "PunchInOnDutyAddress": punchInOnDutyAddress,
//     // "PunchOutOnDutyAddress": punchOutOnDutyAddress,
//   };
// }


// To parse this JSON data, do
//
//     final todayPunchInResponse = todayPunchInResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final todayPunchInResponse = todayPunchInResponseFromJson(jsonString);

import 'dart:convert';

TodayPunchInResponse todayPunchInResponseFromJson(String str) => TodayPunchInResponse.fromJson(json.decode(str));

String todayPunchInResponseToJson(TodayPunchInResponse data) => json.encode(data.toJson());

class TodayPunchInResponse {
  bool? success;
  String? message;
  List<Result>? result;

  TodayPunchInResponse({
    this.success,
    this.message,
    this.result,
  });

  factory TodayPunchInResponse.fromJson(Map<String, dynamic> json) => TodayPunchInResponse(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? staffName;
  int? employeeId;
  List<PunchDetail>? punchDetails;

  Result({
    this.staffName,
    this.employeeId,
    this.punchDetails,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    staffName: json["staffName"],
    employeeId: json["employeeId"],
    punchDetails: List<PunchDetail>.from(json["punchDetails"].map((x) => PunchDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "staffName": staffName,
    "employeeId": employeeId,
    "punchDetails": List<dynamic>.from(punchDetails!.map((x) => x.toJson())),
  };
}

class PunchDetail {
  String? designation;
  String? inLocation;
  String? projectAddress;
  String? punchInDate;
  String? punchInTime;
  String? outImage;
  String? punchoutDate;
  String? punchOutTime;
  String? outLocation;
  String? outProjectAddress;
  String? inImageUrl;
  String? outImageUrl;

  PunchDetail({
    this.designation,
    this.inLocation,
    this.projectAddress,
    this.punchInDate,
    this.punchInTime,
    this.outImage,
    this.punchoutDate,
    this.punchOutTime,
    this.outLocation,
    this.outProjectAddress,
    this.inImageUrl,
    this.outImageUrl,
  });

  factory PunchDetail.fromJson(Map<String, dynamic> json) => PunchDetail(
    designation: json["designation"],
    inLocation: json["inLocation"],
    projectAddress: json["projectAddress"],
    punchInDate: json["punchinDate"],
    punchInTime: json["punchinTime"],
    outImage: json["outImage"],
    punchoutDate: json["punchoutDate"],
    punchOutTime: json["punchoutTime"],
    outLocation: json["outLocation"],
    outProjectAddress: json["outProjectAddress"],
    inImageUrl: json["inImageUrl"],
    outImageUrl: json["outImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "designation": designation,
    "inLocation": inLocation,
    "projectAddress": projectAddress,
    "punchinDate": punchInDate,
    "punchinTime": punchInTime,
    "outImage": outImage,
    "punchoutDate": punchoutDate,
    "punchoutTime": punchOutTime,
    "outLocation": outLocation,
    "outProjectAddress": outProjectAddress,
    "inImageUrl": inImageUrl,
    "outImageUrl": outImageUrl,
  };
}



// import 'dart:convert';
//
// TodayPunchInResponse todayPunchInResponseFromJson(String str) => TodayPunchInResponse.fromJson(json.decode(str));
//
// String todayPunchInResponseToJson(TodayPunchInResponse data) => json.encode(data.toJson());
//
// class TodayPunchInResponse {
//   bool? success;
//   String? message;
//   List<Result>? result;
//
//   TodayPunchInResponse({
//     this.success,
//     this.message,
//     this.result,
//   });
//
//   factory TodayPunchInResponse.fromJson(Map<String, dynamic> json) => TodayPunchInResponse(
//     success: json["success"],
//     message: json["message"],
//     result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "result": List<dynamic>.from(result!.map((x) => x.toJson())),
//   };
// }
//
// class Result {
//   String? inImage;
//   String? staffname;
//   int? employeeId;
//   String? designation;
//   String? inLocation;
//   String? projectAddress;
//   String? punchInDate;
//   String? punchInTime;
//   String? outImage;
//   String? punchOutDatr;
//   String? punchOutTime;
//   String? outLoaction;
//   String? outProjectAddress;
//   String? inImageUrl;
//   String? outImageUrl;
//
//   Result({
//     this.inImage,
//     this.staffname,
//     this.employeeId,
//     this.designation,
//     this.inLocation,
//     this.projectAddress,
//     this.punchInDate,
//     this.punchInTime,
//     this.outImage,
//     this.punchOutDatr,
//     this.punchOutTime,
//     this.outLoaction,
//     this.outProjectAddress,
//     this.inImageUrl,
//     this.outImageUrl,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     inImage: json["inImage"],
//     staffname: json["staffname"],
//     employeeId: json["employeeId"],
//     designation: json["designation"],
//     inLocation: json["inLocation"],
//     projectAddress: json["projectAddress"],
//     punchInDate: json["punchInDate"],
//     punchInTime: json["punchInTime"],
//     outImage: json["outImage"],
//     punchOutDatr: json["punchOutDatr"],
//     punchOutTime: json["punchOutTime"],
//     outLoaction: json["outLoaction"],
//     outProjectAddress: json["outProjectAddress"],
//     inImageUrl: json["inImageUrl"],
//     outImageUrl: json["outImageUrl"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "inImage": inImage,
//     "staffname": staffname,
//     "employeeId": employeeId,
//     "designation": designation,
//     "inLocation": inLocation,
//     "projectAddress": projectAddress,
//     "punchInDate": punchInDate,
//     "punchInTime": punchInTime,
//     "outImage": outImage,
//     "punchOutDatr": punchOutDatr,
//     "punchOutTime": punchOutTime,
//     "outLoaction": outLoaction,
//     "outProjectAddress": outProjectAddress,
//     "inImageUrl": inImageUrl,
//     "outImageUrl": outImageUrl,
//   };
// }


