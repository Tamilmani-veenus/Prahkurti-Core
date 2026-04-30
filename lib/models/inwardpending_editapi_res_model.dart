// To parse this JSON data, do
//
//     final inwardPendingEditApiRes = inwardPendingEditApiResFromJson(jsonString);

import 'dart:convert';

InwardPendingEditApiRes inwardPendingEditApiResFromJson(String str) => InwardPendingEditApiRes.fromJson(json.decode(str));

String inwardPendingEditApiResToJson(InwardPendingEditApiRes data) => json.encode(data.toJson());

class InwardPendingEditApiRes {
  bool? success;
  List<Result>? result;
  String? message;

  InwardPendingEditApiRes({
    this.success,
    this.result,
    this.message
  });

  factory InwardPendingEditApiRes.fromJson(Map<String, dynamic> json) => InwardPendingEditApiRes(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class Result {
  int? inwardId;
  String? inwardNo;
  String? inwType;
  String? entryDate;
  int? siteId;
  int? supplierId;
  String? remarks;
  String? partyDcdate;
  String? dcDate;
  String? dcNo;
  int? projectId;
  String? vechileName;
  String? driverName;
  int? createdBy;
  String? createdName;
  String? manualInwNo;
  int? purOrdMasId;
  String? selectedNo;
  String? rptattached;
  String? purType;
  int? reqOrdMasId;
  int? workOrdMasId;
  double? freightCharges;
  double? roundOff;
  String? invoiceDate;
  String? invoiceNo;
  String? projectName;
  String? siteName;
  String? supplierName;
  int? gateEntryId;
  double? labourCharges;
  int? inwardDetId;
  int? id;
  int? materialId;
  String? materialName;
  String? unit;
  int? scaleId;
  double? poQty;
  double? qty;
  double? rate;
  double? totinwardQty;
  double? inwardQty;
  dynamic amd;
  double? balqty;
  double? amount;
  double? discntPercentage;
  double? discntAmount;
  double? vatPercentage;
  double? vatAmout;
  double? netAmount;
  double? inwardADDQty;
  double? inwardLessQty;

  Result({
    this.inwardId,
    this.inwardNo,
    this.inwType,
    this.entryDate,
    this.siteId,
    this.supplierId,
    this.remarks,
    this.partyDcdate,
    this.dcDate,
    this.dcNo,
    this.projectId,
    this.vechileName,
    this.driverName,
    this.createdBy,
    this.createdName,
    this.manualInwNo,
    this.purOrdMasId,
    this.selectedNo,
    this.rptattached,
    this.purType,
    this.reqOrdMasId,
    this.projectName,
    this.siteName,
    this.supplierName,
    this.workOrdMasId,
    this.freightCharges,
    this.roundOff,
    this.invoiceDate,
    this.invoiceNo,
    this.gateEntryId,
    this.labourCharges,
    this.inwardDetId,
    this.id,
    this.materialId,
    this.materialName,
    this.unit,
    this.scaleId,
    this.poQty,
    this.qty,
    this.rate,
    this.totinwardQty,
    this.inwardQty,
    this.amd,
    this.balqty,
    this.amount,
    this.discntPercentage,
    this.discntAmount,
    this.vatPercentage,
    this.vatAmout,
    this.netAmount,
    this.inwardADDQty,
    this.inwardLessQty,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    inwardId: json["InwardId"],
    inwardNo: json["inwardNo"],
    inwType: json["inwType"],
    entryDate: json["entryDate"],
    siteId: json["siteID"],
    supplierId: json["supplierID"],
    remarks: json["remarks"],
    partyDcdate: json["PartyDcdate"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    supplierName: json["SupplierName"],
    dcDate: (json["DcDate"]),
    dcNo: json["dcNo"],
    projectId: json["ProjectID"],
    vechileName: json["vechileName"],
    driverName: json["driverName"],
    createdBy: json["CreatedBy"],
    createdName: json["createdName"],
    manualInwNo: json["manualInwNo"],
    purOrdMasId: json["purOrdMasId"],
    selectedNo: json["SelectedNo"],
    rptattached: json["rptattached"],
    purType: json["PurType"],
    reqOrdMasId: json["ReqOrdMasId"],
    workOrdMasId: json["WorkOrdMasId"],
    freightCharges: json["freightCharges"],
    roundOff: json["roundOff"],
    invoiceDate: json["InvoiceDate"],
    invoiceNo: json["invoiceNo"],
    gateEntryId: json["gateEntryId"],
    labourCharges: json["LabourCharges"],
    inwardDetId: json["InwardDetId"],
    id: json["id"],
    materialId: json["itemid"],
    materialName: json["item"],
    unit: json["Unit"],
    scaleId: json["ScaleID"],
    poQty: json["poqty"],
    qty: json["qty"],
    rate: json["rate"],
    totinwardQty: json["TotinwardQty"],
    inwardQty: json["InwardQty"],
    amd: json["amd"],
    balqty: json["balqty"],
    amount: json["amount"],
    discntPercentage: json["DiscntPercentage"],
    discntAmount: json["DiscntAmount"],
    vatPercentage: json["VatPercentage"],
    vatAmout: json["VatAmout"],
    netAmount: json["NetAmount"],
    inwardADDQty: json["InwardADDQty"],
    inwardLessQty: json["InwardLessQty"],
  );

  Map<String, dynamic> toJson() => {
    "InwardId": inwardId,
    "inwardNo": inwardNo,
    "inwType": inwType,
    "entryDate": entryDate,
    "siteID": siteId,
    "supplierID": supplierId,
    "remarks": remarks,
    "PartyDcdate": partyDcdate,
    "DcDate": dcDate,
    "dcNo": dcNo,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SupplierName": supplierName,
    "ProjectID": projectId,
    "vechileName": vechileName,
    "driverName": driverName,
    "CreatedBy": createdBy,
    "createdName": createdName,
    "manualInwNo": manualInwNo,
    "purOrdMasId": purOrdMasId,
    "SelectedNo": selectedNo,
    "rptattached": rptattached,
    "PurType": purType,
    "ReqOrdMasId": reqOrdMasId,
    "WorkOrdMasId": workOrdMasId,
    "freightCharges": freightCharges,
    "roundOff": roundOff,
    "InvoiceDate": invoiceDate,
    "invoiceNo": invoiceNo,
    "gateEntryId": gateEntryId,
    "LabourCharges": labourCharges,
    "InwardDetId": inwardDetId,
    "id": id,
    "itemid": materialId,
    "item": materialName,
    "Unit": unit,
    "ScaleID": scaleId,
    "poqty": poQty,
    "qty": qty,
    "rate": rate,
    "TotinwardQty": totinwardQty,
    "InwardQty": inwardQty,
    "amd": amd,
    "balqty": balqty,
    "amount": amount,
    "DiscntPercentage": discntPercentage,
    "DiscntAmount": discntAmount,
    "VatPercentage": vatPercentage,
    "VatAmout": vatAmout,
    "NetAmount": netAmount,
    "InwardADDQty": inwardADDQty,
    "InwardLessQty": inwardLessQty,
  };
}
