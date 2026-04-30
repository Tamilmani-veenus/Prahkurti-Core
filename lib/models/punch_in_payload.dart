import 'dart:convert';

class PunchInPayload {
  String? empId;
  String? dateIn;
  String? entryMode;
  String? locId;
  String? userId;
  String? deviceName;
  String? punchTimeIn;
  String? imagePath;

  PunchInPayload({
    this.empId,
    this.dateIn,
    this.entryMode,
    this.locId,
    this.userId,
    this.deviceName,
    this.punchTimeIn,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'empId': empId,
      'dateIn': dateIn,
      'entryMode': entryMode,
      'locId': locId,
      'userId': userId,
      'deviceName': deviceName,
      'punchTimeIn': punchTimeIn,
      'imagePath': imagePath,
    };
  }

  factory PunchInPayload.fromMap(Map<String, dynamic> map) {
    return PunchInPayload(
      empId: map['empId'],
      dateIn: map['dateIn'],
      entryMode: map['entryMode'],
      locId: map['locId'],
      userId: map['userId'],
      deviceName: map['deviceName'],
      punchTimeIn: map['punchTimeIn'],
      imagePath: map['imagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PunchInPayload.fromJson(String source) =>
      PunchInPayload.fromMap(json.decode(source));
}
