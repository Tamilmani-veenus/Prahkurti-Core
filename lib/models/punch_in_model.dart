import 'dart:convert';

class PunchInSaveModel {
  int? Id;
  int? EmployeeId;
  int? InLocid;
  String? InDate;
  String? InTime;
  String? InStatus;
  String? InNAPRemarks;
  String? OnPinInLatitude;
  String? OnPinInLongitude;
  String? OnPinInAddress;
  String? OnDutyRemarks;
  String? CreatedBy;
  String? CreatedDt;

  PunchInSaveModel({
    this.Id,
    this.EmployeeId,
    this.InLocid,
    this.InDate,
    this.InTime,
    this.InStatus,
    this.InNAPRemarks,
    this.OnPinInLatitude,
    this.OnPinInLongitude,
    this.OnPinInAddress,
    this.OnDutyRemarks,
    this.CreatedBy,
    this.CreatedDt,
  });

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "EmployeeId": EmployeeId,
    "InLocid": InLocid,
    "InDate": InDate,
    "InTime": InTime,
    "InNAPRemarks": InNAPRemarks,
    "OnPinInLatitude": OnPinInLatitude,
    "OnPinInLongitude": OnPinInLongitude,
    "OnPinInAddress": OnPinInAddress,
    "OnDutyRemarks": OnDutyRemarks,
    "InStatus": InStatus,
    "CreatedBy": CreatedBy,
    "remarks": CreatedDt,
  };
}

class PunchOutSaveModel {
  int? id;
  int? EmployeeId;
  int? OutLocId;
  String? OutDate;
  String? OutTime;
  String? OutStatus;
  String? TodayTask;
  String? TomorrowTask;
  String? OutNAPRemarks;
  String? OnPinOutLatitude;
  String? OnPinOutLongitude;
  String? OnPinOutAddress;
  String? InDate;
  String? OnDutyRemarks;

  PunchOutSaveModel({
    this.id,
    this.EmployeeId,
    this.OutLocId,
    this.OutDate,
    this.OutTime,
    this.OutStatus,
    this.TodayTask,
    this.TomorrowTask,
    this.OutNAPRemarks,
    this.OnPinOutLatitude,
    this.OnPinOutLongitude,
    this.OnPinOutAddress,
    this.InDate,
    this.OnDutyRemarks,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "EmployeeId": EmployeeId,
    "OutLocId": OutLocId,
    "OutDate": OutDate,
    "OutTime": OutTime,
    "OutStatus" : OutStatus,
    "TodayTask" : TodayTask,
    "TomorrowTask" : TomorrowTask,
    "OutNAPRemarks" : OutNAPRemarks,
    "OnPinOutLatitude" : OnPinOutLatitude,
    "OnPinOutLongitude" : OnPinOutLongitude,
    "OnPinOutAddress" : OnPinOutAddress,
    "InDate" : InDate,
    "OnDutyRemarks" : OnDutyRemarks,
  };
}

GetPunchSatusResponse getPunchSatusResponseFromJson(String str) => GetPunchSatusResponse.fromJson(json.decode(str));

String getPunchSatusResponseToJson(GetPunchSatusResponse data) => json.encode(data.toJson());

class GetPunchSatusResponse {
  bool? success;
  String? message;
  Result? result;

  GetPunchSatusResponse({
    this.success,
    this.message,
    this.result,
  });

  factory GetPunchSatusResponse.fromJson(Map<String, dynamic> json) => GetPunchSatusResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?null:Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?null:result!.toJson(),
  };
}

class Result {
  int? punchInandOutId;
  String? punchNo;
  String? punchInDate;
  String? punchStatus;
  String? punchInStatus;
  String? verifyStatus;
  String? approveStatus;

  Result({
    this.punchInandOutId,
    this.punchNo,
    this.punchInDate,
    this.punchStatus,
    this.punchInStatus,
    this.verifyStatus,
    this.approveStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    punchInandOutId: json["punchInandOutId"],
    punchNo: json["punchNo"],
    punchInDate: json["punchInDate"],
    punchStatus: json["punchStatus"],
    punchInStatus: json["punchInStatus"],
    verifyStatus: json["verifyStatus"],
    approveStatus: json["approveStatus"],
  );

  Map<String, dynamic> toJson() => {
    "punchInandOutId": punchInandOutId,
    "punchNo": punchNo,
    "punchInDate": punchInDate,
    "punchStatus": punchStatus,
    "punchInStatus": punchInStatus,
    "verifyStatus": verifyStatus,
    "approveStatus": approveStatus,
  };
}

