import 'dart:convert';

GetInwardListResponse getInwardListResponseFromJson(String str) =>
    GetInwardListResponse.fromJson(json.decode(str));

String getInwardListResponseToJson(GetInwardListResponse data) =>
    json.encode(data.toJson());

class GetInwardListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  GetInwardListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory GetInwardListResponse.fromJson(Map<String, dynamic> json) =>
      GetInwardListResponse(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.inwardNo,
    this.inwType,
    this.entryDate,
    this.entryTime,
    this.projectId,
    this.siteId,
    this.supplierId,
    this.purType,
    this.dcNo,
    this.dcDate,
    this.invoiceNo,
    this.invoiceDate,
    this.purOrdMasId,
    this.workOrdMasId,
    this.reqOrdMasId,
    this.selectedNo,
    this.gateEntryId,
    this.freightCharges,
    this.labourCharges,
    this.roundOff,
    this.netAmount,
    this.rptattached,
    this.vechileName,
    this.driverName,
    this.manualInwNo,
    this.remarks,
    this.createdBy,
    this.createdDt,
    this.projectName,
    this.siteName,
    this.supplierName,
    this.purOrdMasNo,
    this.workOrdMasNo,
    this.reqOrdMasNo,
    this.createdName,
    this.financialyear,
    this.materialInwardMasLink,
  });

  int? id;
  String? inwardNo;
  String? inwType;
  String? entryDate;
  String? entryTime;
  int? projectId;
  int? siteId;
  int? supplierId;
  String? purType;
  String? dcNo;
  String? dcDate;
  String? invoiceNo;
  String? invoiceDate;
  int? purOrdMasId;
  int? workOrdMasId;
  int? reqOrdMasId;
  String? selectedNo;
  int? gateEntryId;
  double? freightCharges;
  double? labourCharges;
  double? roundOff;
  double? netAmount;
  String? rptattached;
  String? vechileName;
  String? driverName;
  String? manualInwNo;
  String? remarks;
  int? createdBy;
  String? createdDt;
  String? projectName;
  String? siteName;
  String? supplierName;
  dynamic purOrdMasNo;
  dynamic workOrdMasNo;
  dynamic reqOrdMasNo;
  String? createdName;
  String? financialyear;
  List<MaterialInwardMasLink>? materialInwardMasLink;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    inwardNo: json["inwardNo"],
    inwType: json["inwType"],
    entryDate: json["entryDate"],
    entryTime: json["entryTime"],
    projectId: json["projectId"],
    siteId: json["siteId"],
    supplierId: json["supplierId"],
    purType: json["purType"],
    dcNo: json["dcNo"],
    dcDate: json["dcDate"],
    invoiceNo: json["invoiceNo"],
    invoiceDate: json["invoiceDate"],
    purOrdMasId: json["purOrdMasId"],
    workOrdMasId: json["workOrdMasId"],
    reqOrdMasId: json["reqOrdMasId"],
    selectedNo: json["selectedNo"],
    gateEntryId: json["gateEntryId"],
    freightCharges: json["freightCharges"],
    labourCharges: json["labourCharges"],
    roundOff: json["roundOff"],
    netAmount: json["netAmount"],
    rptattached: json["rptattached"],
    vechileName: json["vechileName"],
    driverName: json["driverName"],
    manualInwNo: json["manualInwNo"],
    remarks: json["remarks"],
    createdBy: json["createdBy"],
    createdDt: json["createdDt"],
    projectName: json["projectName"],
    siteName: json["siteName"],
    supplierName: json["supplierName"],
    purOrdMasNo: json["purOrdMasNo"],
    workOrdMasNo: json["workOrdMasNo"],
    reqOrdMasNo: json["reqOrdMasNo"],
    createdName: json["createdName"],
    financialyear: json["financialyear"],
    materialInwardMasLink: json["materialInwardMasLink"] == null
        ? []
        : List<MaterialInwardMasLink>.from(json["materialInwardMasLink"]
        .map((x) => MaterialInwardMasLink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inwardNo": inwardNo,
    "inwType": inwType,
    "entryDate": entryDate,
    "entryTime": entryTime,
    "projectId": projectId,
    "siteId": siteId,
    "supplierId": supplierId,
    "purType": purType,
    "dcNo": dcNo,
    "dcDate": dcDate,
    "invoiceNo": invoiceNo,
    "invoiceDate": invoiceDate,
    "purOrdMasId": purOrdMasId,
    "workOrdMasId": workOrdMasId,
    "reqOrdMasId": reqOrdMasId,
    "selectedNo": selectedNo,
    "gateEntryId": gateEntryId,
    "freightCharges": freightCharges,
    "labourCharges": labourCharges,
    "roundOff": roundOff,
    "netAmount": netAmount,
    "rptattached": rptattached,
    "vechileName": vechileName,
    "driverName": driverName,
    "manualInwNo": manualInwNo,
    "remarks": remarks,
    "createdBy": createdBy,
    "createdDt": createdDt,
    "projectName": projectName,
    "siteName": siteName,
    "supplierName": supplierName,
    "purOrdMasNo": purOrdMasNo,
    "workOrdMasNo": workOrdMasNo,
    "reqOrdMasNo": reqOrdMasNo,
    "createdName": createdName,
    "financialyear": financialyear,
    "materialInwardMasLink": materialInwardMasLink == null
        ? []
        : List<dynamic>.from(
        materialInwardMasLink!.map((x) => x.toJson())),
  };
}

class MaterialInwardMasLink {
  MaterialInwardMasLink({
    this.id,
    this.materialInwardMasId,
    this.purOrdDetId,
    this.workOrdDetId,
    this.reqOrdDetId,
    this.materialId,
    this.scaleId,
    this.qty,
    this.rate,
    this.amount,
    this.balQty,
    this.discntAmount,
    this.discntPercentage,
    this.vatPercentage,
    this.vatAmout,
    this.addQty,
    this.lessQty,
    this.amdCheck,
    this.netAmount,
    this.materialName,
    this.scaleName,
    this.poQty,
  });

  int? id;
  int? materialInwardMasId;
  int? purOrdDetId;
  int? workOrdDetId;
  int? reqOrdDetId;
  int? materialId;
  int? scaleId;
  double? qty;
  double? rate;
  double? amount;
  double? balQty;
  double? discntAmount;
  double? discntPercentage;
  double? vatPercentage;
  double? vatAmout;
  double? addQty;
  double? lessQty;
  String? amdCheck;
  double? netAmount;
  String? materialName;
  String? scaleName;
  int? poQty;

  factory MaterialInwardMasLink.fromJson(Map<String, dynamic> json) =>
      MaterialInwardMasLink(
        id: json["id"],
        materialInwardMasId: json["materialInwardMasId"],
        purOrdDetId: json["purOrdDetId"],
        workOrdDetId: json["workOrdDetId"],
        reqOrdDetId: json["reqOrdDetId"],
        materialId: json["materialId"],
        scaleId: json["scaleId"],
        qty: json["qty"],
        rate: json["rate"],
        amount: json["amount"],
        balQty: json["balQty"],
        discntAmount: json["discntAmount"],
        discntPercentage: json["discntPercentage"],
        vatPercentage: json["vatPercentage"],
        vatAmout: json["vatAmout"],
        addQty: json["addQty"],
        lessQty: json["lessQty"],
        amdCheck: json["amdCheck"],
        netAmount: json["netAmount"],
        materialName: json["materialName"],
        scaleName: json["scaleName"],
        poQty: json["poQty"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialInwardMasId": materialInwardMasId,
    "purOrdDetId": purOrdDetId,
    "workOrdDetId": workOrdDetId,
    "reqOrdDetId": reqOrdDetId,
    "materialId": materialId,
    "scaleId": scaleId,
    "qty": qty,
    "rate": rate,
    "amount": amount,
    "balQty": balQty,
    "discntAmount": discntAmount,
    "discntPercentage": discntPercentage,
    "vatPercentage": vatPercentage,
    "vatAmout": vatAmout,
    "addQty": addQty,
    "lessQty": lessQty,
    "amdCheck": amdCheck,
    "netAmount": netAmount,
    "materialName": materialName,
    "scaleName": scaleName,
    "poQty": poQty,
  };
}
