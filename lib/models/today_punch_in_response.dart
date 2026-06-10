
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
  String? onPinInAddress;
  String? onPinOutAddress;
  String? instatus;
  String? outStatus;



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
    this.onPinInAddress,
    this.onPinOutAddress,
    this.instatus,
    this.outStatus,


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
    onPinInAddress: json["onPinInAddress"],
    onPinOutAddress: json["onPinOutAddress"],
    instatus: json["instatus"],
    outStatus: json["outStatus"],


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
    "onPinInAddress": onPinInAddress,
    "onPinOutAddress": onPinOutAddress,
    "instatus": instatus,
    "outStatus": outStatus,



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


