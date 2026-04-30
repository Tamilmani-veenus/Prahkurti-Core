import 'dart:convert';

class PunchOutPayload {
  String? empId;
  String? date;
  String? timeOut;
  String? entryMode;
  String? userId;
  String? deviceName;
  String? locId;

  PunchOutPayload({
    this.empId,
    this.date,
    this.timeOut,
    this.entryMode,
    this.userId,
    this.deviceName,
    this.locId,
  });

  Map<String, dynamic> toMap() {
    return {
      'empId': empId,
      'date': date,
      'timeOut': timeOut,
      'entryMode': entryMode,
      'userId': userId,
      'deviceName': deviceName,
      'locId': locId,
    };
  }

  factory PunchOutPayload.fromMap(Map<String, dynamic> map) {
    return PunchOutPayload(
      empId: map['empId'],
      date: map['date'],
      timeOut: map['timeOut'],
      entryMode: map['entryMode'],
      userId: map['userId'],
      deviceName: map['deviceName'],
      locId: map['locId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PunchOutPayload.fromJson(String source) =>
      PunchOutPayload.fromMap(json.decode(source));
}
