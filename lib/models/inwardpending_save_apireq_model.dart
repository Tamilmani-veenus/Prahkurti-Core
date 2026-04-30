// To parse this JSON data, do
//
//     final inwardPendingSaveReq = inwardPendingSaveReqFromJson(jsonString);

import 'dart:convert';

InwardPendingSaveReq inwardPendingSaveReqFromJson(String str) => InwardPendingSaveReq.fromJson(json.decode(str));

String inwardPendingSaveReqToJson(InwardPendingSaveReq data) => json.encode(data.toJson());

class InwardPendingSaveReq {
  int? id;
  String? inwardNo;
  String? entryDate;
  String? entryTime;
  String? inwType;
  int? projectID;
  int? siteID;
  int? supplierID;
  String? purType;
  String? dcNo;
  String? dcDate;
  String? invoiceNo;
  String? invoiceDate;
  int? purOrdMasId;
  String? vechileName;
  String? driverName;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? selectedNo;
  List<InwardDet>? inwardDet;

  InwardPendingSaveReq({
    this.id,
    this.inwardNo,
    this.entryDate,
    this.entryTime,
    this.inwType,
    this.projectID,
    this.siteID,
    this.supplierID,
    this.purType,
    this.dcNo,
    this.dcDate,
    this.invoiceNo,
    this.invoiceDate,
    this.purOrdMasId,
    this.vechileName,
    this.driverName,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.selectedNo,
    this.inwardDet,
  });

  /// FROM JSON
  factory InwardPendingSaveReq.fromJson(Map<String, dynamic> json) {
    return InwardPendingSaveReq(
      id: json['id'],
      inwardNo: json['InwardNo'],
      entryDate: json['EntryDate'],
      entryTime: json['EntryTime'],
      inwType: json['InwType'],
      projectID: json['ProjectID'],
      siteID: json['SiteID'],
      supplierID: json['SupplierID'],
      purType: json['PurType'],
      dcNo: json['DCNo'],
      dcDate: json['DCDate'],
      invoiceNo: json['InvoiceNo'],
      invoiceDate: json['InvoiceDate'],
      purOrdMasId: json['PurOrdMasId'],
      vechileName: json['VechileName'],
      driverName: json['DriverName'],
      remarks: json['Remarks'],
      createdBy: json['CreatedBy'],
      createdDt: json['CreatedDt'],
      selectedNo: json['SelectedNo'],
      inwardDet: json['MaterialInwardMasLink'] != null
          ? (json['MaterialInwardMasLink'] as List)
          .map((e) => InwardDet.fromJson(e))
          .toList()
          : [],
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "InwardNo": inwardNo,
      "EntryDate": entryDate,
      "EntryTime": entryTime,
      "InwType": inwType,
      "ProjectID": projectID,
      "SiteID": siteID,
      "SupplierID": supplierID,
      "PurType": purType,
      "DCNo": dcNo,
      "DCDate": dcDate,
      "InvoiceNo": invoiceNo,
      "InvoiceDate": invoiceDate,
      "PurOrdMasId": purOrdMasId,
      "VechileName": vechileName,
      "DriverName": driverName,
      "Remarks": remarks,
      "CreatedBy": createdBy,
      "CreatedDt": createdDt,
      "SelectedNo": selectedNo,
      "MaterialInwardMasLink": inwardDet != null
          ? inwardDet!.map((e) => e.toJson()).toList()
          : [],
    };
  }
}
class InwardDet {
  int? id;
  int? materialInwardMasID;
  int? purOrdDetId;
  int? materialID;
  int? scaleID;
  double? qty;
  double? rate;
  double? amount;
  double? balQty;
  double? addQty;
  double? lessQty;
  String? AMDCheck;

  InwardDet({
    this.id,
    this.materialInwardMasID,
    this.purOrdDetId,
    this.materialID,
    this.scaleID,
    this.qty,
    this.rate,
    this.amount,
    this.balQty,
    this.addQty,
    this.lessQty,
    this.AMDCheck,
  });

  factory InwardDet.fromJson(Map<String, dynamic> json) {
    return InwardDet(
      id: json['id'],
      materialInwardMasID: json['materialInwardMasID'],
      purOrdDetId: json['purOrdDetId'],
      materialID: json['materialID'],
      scaleID: json['scaleID'],
      qty: (json['qty'] ?? 0).toDouble(),
      rate: (json['rate'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      balQty: (json['balQty'] ?? 0).toDouble(),
      addQty: (json['addQty'] ?? 0).toDouble(),
      lessQty: (json['lessQty'] ?? 0).toDouble(),
      AMDCheck: (json['AMDCheck']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "materialInwardMasID": materialInwardMasID,
      "purOrdDetId": purOrdDetId,
      "materialID": materialID,
      "scaleID": scaleID,
      "qty": qty,
      "rate": rate,
      "amount": amount,
      "balQty": balQty,
      "addQty": addQty,
      "lessQty": lessQty,
      "AMDCheck": AMDCheck,
    };
  }
}
