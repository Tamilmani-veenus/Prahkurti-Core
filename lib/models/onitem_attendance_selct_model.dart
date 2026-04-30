import 'dart:convert';

List<OnItemSelectAttendanceList> onItemSelectAttendanceListFromJson(String str) => List<OnItemSelectAttendanceList>.from(json.decode(str).map((x) => OnItemSelectAttendanceList.fromJson(x)));

String onItemSelectAttendanceListToJson(List<OnItemSelectAttendanceList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnItemSelectAttendanceList {
  OnItemSelectAttendanceList({
    this.siteId,
    this.siteName,
    this.categoryName,
    this.nos,
    this.otHrs,
    this.MOROTHrs,
    this.MOROTAmt,
    this.EVEOTHrs,
    this.EVEOTAmt,
    this.ExtraAmt,
    this.remarks,
    this.Rate,
    this.Wages,
    this.TotAmt,
    this.Extra
  });

  int? siteId;
  String? siteName;
  String? categoryName;
  double? nos;
  double? otHrs;
  double? MOROTHrs;
  double? MOROTAmt;
  double? EVEOTHrs;
  double? EVEOTAmt;
  double? ExtraAmt;
  String? remarks;
  double? Rate;
  double? Wages;
  double? TotAmt;
  double? Extra;


  factory OnItemSelectAttendanceList.fromJson(Map<String, dynamic> json) => OnItemSelectAttendanceList(
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    categoryName: json["CategoryName"],
    nos: json["Nos"],
    otHrs: json["OTHrs"],
    MOROTHrs: json["MOROTHrs"],
    MOROTAmt: json["MOROTAmt"],
    EVEOTHrs: json["EVEOTHrs"],
    EVEOTAmt: json["EVEOTAmt"],
    ExtraAmt: json["ExtraAmt"],
    remarks: json["Remarks"],
    Rate: json["Rate"],
    Wages: json["Wages"],
    TotAmt: json["TotAmt"],
    Extra: json["Extra"],
  );

  Map<String, dynamic> toJson() => {
    "SiteId": siteId,
    "SiteName": siteName,
    "CategoryName": categoryName,
    "Nos": nos,
    "OTHrs": otHrs,
    "OTHrs": MOROTHrs,
    "OTHrs": MOROTAmt,
    "OTHrs": EVEOTHrs,
    "OTHrs": EVEOTAmt,
    "OTHrs": ExtraAmt,
    "Remarks": remarks,
    "Rate":Rate,
    "Wages":Wages,
    "TotAmt":TotAmt,
    "Extra":Extra
  };
}
