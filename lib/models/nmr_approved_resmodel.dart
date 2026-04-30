import 'dart:convert';

List<GetNmrAprovedstatusmodel> getNmrAprovedstatusmodelFromJson(String str) => List<GetNmrAprovedstatusmodel>.from(json.decode(str).map((x) => GetNmrAprovedstatusmodel.fromJson(x)));

String getNmrAprovedstatusmodelToJson(List<GetNmrAprovedstatusmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetNmrAprovedstatusmodel {
  GetNmrAprovedstatusmodel({
    this.labrAttnDate,
    this.labrAttnNo,
    this.appStatus,
  });

  String? labrAttnDate;
  String? labrAttnNo;
  String? appStatus;

  factory GetNmrAprovedstatusmodel.fromJson(Map<String, dynamic> json) => GetNmrAprovedstatusmodel(
    labrAttnDate: json["LabrAttn_Date"],
    labrAttnNo: json["LabrAttn_No"],
    appStatus: json["App_Status"],
  );

  Map<String, dynamic> toJson() => {
    "LabrAttn_Date": labrAttnDate,
    "LabrAttn_No": labrAttnNo,
    "App_Status": appStatus,
  };
}








List<GetNmrstatuscountresmodel> getNmrstatuscountresmodelFromJson(String str) => List<GetNmrstatuscountresmodel>.from(json.decode(str).map((x) => GetNmrstatuscountresmodel.fromJson(x)));

String getNmrstatuscountresmodelToJson(List<GetNmrstatuscountresmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class GetNmrstatuscountresmodel {
  GetNmrstatuscountresmodel({
    this.reccount,
    this.appCount,
  });

  int? reccount;
  int? appCount;

  factory GetNmrstatuscountresmodel.fromJson(Map<String, dynamic> json) => GetNmrstatuscountresmodel(
    reccount: json["Reccount"],
    appCount: json["AppCount"],
  );

  Map<String, dynamic> toJson() => {
    "Reccount": reccount,
    "AppCount": appCount,
  };
}


