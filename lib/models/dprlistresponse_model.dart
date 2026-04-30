
import 'dart:convert';

List<DprListResponse> dprListResponseFromJson(String str) => List<DprListResponse>.from(json.decode(str).map((x) => DprListResponse.fromJson(x)));

String dprListResponseToJson(List<DprListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DprListResponse {
  DprListResponse({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectName,
    this.siteName,
    this.subContName,
    this.invNo,
    this.poNo,
    this.appStatus,
  });

  int? workId;
  String? workNo;
  String? workDate;
  String? projectName;
  String? siteName;
  String? subContName;
  String? invNo;
  String? poNo;
  String? appStatus;

  factory DprListResponse.fromJson(Map<String, dynamic> json) => DprListResponse(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subContName: json["SubContName"],
    invNo: json["InvNo"],
    poNo: json["PONo"],
    appStatus: json["AppStatus"],
  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SubContName": subContName,
    "InvNo": invNo,
    "PONo": poNo,
    "AppStatus": appStatus,
  };
}
