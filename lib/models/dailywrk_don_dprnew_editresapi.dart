// To parse this JSON data, do
//
//     final dailywrkdonDprNewEditApiRes = dailywrkdonDprNewEditApiResFromJson(jsonString);

import 'dart:convert';

DailywrkdonDprNewEditApiRes dailywrkdonDprNewEditApiResFromJson(String str) => DailywrkdonDprNewEditApiRes.fromJson(json.decode(str));

String dailywrkdonDprNewEditApiResToJson(DailywrkdonDprNewEditApiRes data) => json.encode(data.toJson());

class DailywrkdonDprNewEditApiRes {
  bool? success;
  String? message;
  Result? result;

  DailywrkdonDprNewEditApiRes({
    this.success,
    this.message,
    this.result,
  });

  factory DailywrkdonDprNewEditApiRes.fromJson(Map<String, dynamic> json) => DailywrkdonDprNewEditApiRes(
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
  int? id;
  String? workNo;
  String? workDate;
  String? workType;
  int? projectId;
  int? siteId;
  int? subContractorId;
  String? entryType;
  int? dprType;
  String? billStatus;
  double? totalAmount;
  String? refNo;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? projectName;
  String? siteName;
  String? status;
  String? subcontractorName;
  String? createdName;
  String? entryTypeDesc;
  String? workTypeDesc;
  int? headItemId;
  String? headItemName;
  List<SubcontractDailyWorkCement>? subcontractDailyWorkCements;
  List<SubcontractDailyWorkLabour>? subcontractDailyWorkLabours;
  List<SubcontractDailyWorkMeasurement>? subcontractDailyWorkMeasurements;

  Result({
    this.id,
    this.workNo,
    this.workDate,
    this.workType,
    this.projectId,
    this.siteId,
    this.subContractorId,
    this.entryType,
    this.dprType,
    this.billStatus,
    this.totalAmount,
    this.refNo,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.projectName,
    this.siteName,
    this.status,
    this.subcontractorName,
    this.createdName,
    this.entryTypeDesc,
    this.workTypeDesc,
    this.headItemName,
    this.headItemId,
    this.subcontractDailyWorkCements,
    this.subcontractDailyWorkLabours,
    this.subcontractDailyWorkMeasurements,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    workNo: json["workNo"],
    workDate: json["workDate"],
    workType: json["workType"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    subContractorId: json["subContractorId"],
    entryType: json["entryType"],
    dprType: json["dprType"],
    billStatus: json["billStatus"],
    totalAmount: json["totalAmount"],
    refNo: json["refNo"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    status: json["status"],
    subcontractorName: json["subcontractorName"],
    createdName: json["createdName"],
    entryTypeDesc: json["entryTypeDesc"],
    workTypeDesc: json["workTypeDesc"],
    headItemId: json["headItemId"],
    headItemName: json["headItemName"],
    subcontractDailyWorkCements: List<SubcontractDailyWorkCement>.from(json["subcontractDailyWorkCements"].map((x) => SubcontractDailyWorkCement.fromJson(x))),
    subcontractDailyWorkLabours: List<SubcontractDailyWorkLabour>.from(json["subcontractDailyWorkLabours"].map((x) => SubcontractDailyWorkLabour.fromJson(x))),
    subcontractDailyWorkMeasurements: List<SubcontractDailyWorkMeasurement>.from(json["subcontractDailyWorkMeasurements"].map((x) => SubcontractDailyWorkMeasurement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "workNo": workNo,
    "workDate": workDate,
    "workType": workType,
    "projectId": projectId,
    "siteId": siteId,
    "subContractorId": subContractorId,
    "entryType": entryType,
    "dprType": dprType,
    "billStatus": billStatus,
    "totalAmount": totalAmount,
    "refNo": refNo,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "projectName": projectName,
    "siteName": siteName,
    "status": status,
    "subcontractorName": subcontractorName,
    "createdName": createdName,
    "entryTypeDesc": entryTypeDesc,
    "workTypeDesc": workTypeDesc,
    "headItemId": headItemId,
    "headItemName": headItemName,
    "subcontractDailyWorkCements": List<dynamic>.from(subcontractDailyWorkCements!.map((x) => x.toJson())),
    "subcontractDailyWorkLabours": List<dynamic>.from(subcontractDailyWorkLabours!.map((x) => x.toJson())),
    "subcontractDailyWorkMeasurements": List<dynamic>.from(subcontractDailyWorkMeasurements!.map((x) => x.toJson())),
  };
}

class SubcontractDailyWorkCement {
  int? id;
  int? subContractDailyWorkMasId;
  int? materialId;
  int? scaleId;
  double? qty;
  String? scaleName;
  String? materialName;

  SubcontractDailyWorkCement({
    this.id,
    this.subContractDailyWorkMasId,
    this.materialId,
    this.scaleId,
    this.qty,
    this.scaleName,
    this.materialName,
  });

  factory SubcontractDailyWorkCement.fromJson(Map<String, dynamic> json) => SubcontractDailyWorkCement(
    id: json["id"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    materialId: json["materialId"],
    scaleId: json["scaleId"],
    qty: json["qty"],
    scaleName: json["scaleName"],
    materialName: json["materialName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "materialId": materialId,
    "scaleId": scaleId,
    "qty": qty,
    "scaleName": scaleName,
    "materialName": materialName,
  };
}

class SubcontractDailyWorkLabour {
  int? id;
  int? subContractDailyWorkMasId;
  int? subContractorId;
  int? categoryId;
  double? nos;
  double? wages;
  double? otHrs;
  double? otAmount;
  double? amount;
  String? categoryName;

  SubcontractDailyWorkLabour({
    this.id,
    this.subContractDailyWorkMasId,
    this.subContractorId,
    this.categoryId,
    this.nos,
    this.wages,
    this.otHrs,
    this.otAmount,
    this.amount,
    this.categoryName
  });

  factory SubcontractDailyWorkLabour.fromJson(Map<String, dynamic> json) => SubcontractDailyWorkLabour(
    id: json["id"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    subContractorId: json["subContractorId"],
    categoryId: json["categoryId"],
    nos: json["nos"],
    wages: json["wages"],
    otHrs: json["otHrs"],
    otAmount: json["otAmount"],
    amount: json["amount"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "subContractorId": subContractorId,
    "categoryId": categoryId,
    "nos": nos,
    "wages": wages,
    "otHrs": otHrs,
    "otAmount": otAmount,
    "amount": amount,
    "categoryName": categoryName,
  };
}

class SubcontractDailyWorkMeasurement {
  int? id;
  int? subContractDailyWorkMasId;
  String? descriptionWork;
  double? no;
  double? length;
  double? breadth;
  double? depth;
  double? qty;

  SubcontractDailyWorkMeasurement({
    this.id,
    this.subContractDailyWorkMasId,
    this.descriptionWork,
    this.no,
    this.length,
    this.breadth,
    this.depth,
    this.qty,
  });

  factory SubcontractDailyWorkMeasurement.fromJson(Map<String, dynamic> json) => SubcontractDailyWorkMeasurement(
    id: json["id"],
    subContractDailyWorkMasId: json["subContractDailyWorkMasId"],
    descriptionWork: json["descriptionWork"],
    no: json["no"],
    length: json["length"],
    breadth: json["breadth"],
    depth: json["depth"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subContractDailyWorkMasId": subContractDailyWorkMasId,
    "descriptionWork": descriptionWork,
    "no": no,
    "length": length,
    "breadth": breadth,
    "depth": depth,
    "qty": qty,
  };
}
