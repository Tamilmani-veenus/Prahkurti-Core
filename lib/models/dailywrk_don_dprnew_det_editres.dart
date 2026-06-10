// To parse this JSON data, do
//
//     final dprNewDetEditApi = dprNewDetEditApiFromJson(jsonString);

import 'dart:convert';

DprNewDetEditApi dprNewDetEditApiFromJson(String str) => DprNewDetEditApi.fromJson(json.decode(str));

String dprNewDetEditApiToJson(DprNewDetEditApi data) => json.encode(data.toJson());

class DprNewDetEditApi {
  bool? success;
  String? message;
  List<Result>? result;

  DprNewDetEditApi({
    this.success,
    this.message,
    this.result,
  });

  factory DprNewDetEditApi.fromJson(Map<String, dynamic> json) => DprNewDetEditApi(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  int? subContractDailyWorkMasId;
  int? subContarctWorkdetid;
  String? boqcode;
  String? fulldescription;
  int? unit;
  String? workType;
  double? cement;
  double? avgLabRate;
  String? workRemarks;
  double? boqqty;
  double? workQty;
  double? balQty;
  int? measureheadItemId;
  int? measuresubItemId;
  int? measureLevel3ItemId;
  int? siteId;
  String? siteName;
  String? scaleName;
  double? qty;
  double? rate;
  double? amount;

  Result({
    this.id,
    this.subContractDailyWorkMasId,
    this.subContarctWorkdetid,
    this.boqcode,
    this.fulldescription,
    this.unit,
    this.workType,
    this.cement,
    this.avgLabRate,
    this.workRemarks,
    this.boqqty,
    this.workQty,
    this.balQty,
    this.measureheadItemId,
    this.measuresubItemId,
    this.measureLevel3ItemId,
    this.siteId,
    this.siteName,
    this.scaleName,
    this.qty,
    this.rate,
    this.amount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    subContarctWorkdetid: json["SubContarctWorkdetid"],
    boqcode: json["boqcode"],
    fulldescription: json["Fulldescription"],
    unit: json["unit"],
    workType: json["WorkType"],
    cement: json["Cement"],
    avgLabRate: json["AVGLabRate"],
    workRemarks: json["WorkRemarks"],
    boqqty: json["Boqqty"],
    workQty: json["WorkQty"],
    balQty: json["balQty"],
    measureheadItemId: json["measureheadItemId"],
    measuresubItemId: json["measuresubItemId"],
    measureLevel3ItemId: json["measureLevel3ItemId"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    scaleName: json["ScaleName"],
    qty: json["Qty"],
    rate: json["Rate"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "SubContarctWorkdetid": subContarctWorkdetid,
    "boqcode": boqcode,
    "Fulldescription": fulldescription,
    "unit": unit,
    "WorkType": workType,
    "Cement": cement,
    "AVGLabRate": avgLabRate,
    "WorkRemarks": workRemarks,
    "Boqqty": boqqty,
    "WorkQty": workQty,
    "balQty": balQty,
    "measureheadItemId": measureheadItemId,
    "measuresubItemId": measuresubItemId,
    "measureLevel3ItemId": measureLevel3ItemId,
    "SiteId": siteId,
    "SiteName": siteName,
    "ScaleName": scaleName,
    "Qty": qty,
    "Rate": rate,
    "amount": amount,
  };
}
