//
//
// import 'dart:convert';
//
// List<OnclickPendingDet> onclickPendingDetFromJson(String str) => List<OnclickPendingDet>.from(json.decode(str).map((x) => OnclickPendingDet.fromJson(x)));
//
// String onclickPendingDetToJson(List<OnclickPendingDet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class OnclickPendingDet {
//   OnclickPendingDet({
//     this.materialName,
//     this.materialID,
//     this.scale,
//     this.qty,
//     this.requestqty,
//     this.poQty,
//     this.balQty,
//     this.PORate,
//     this.DataRate,
//     this.PoAmt,
//     this.GSTPer,
//     this.GSTAmt,
//     this.NetAmt,
//     this.grnQty,
//     this.remarks,
//     this.transQty,
//     this.ackQty,
//     this.frProjectName,
//     this.preAppType,
//
//
//     //----WorkOrder Verify & Approve
//     this.workdetid,
//     this.itemDes,
//     this.fulldescription,
//     this.unit,
//     this.rate,
//     this.amount,
//   });
//
//   String? materialName;
//   int? materialID;
//   String? scale;
//   double? qty;
//   double? requestqty;
//   double? poQty;
//   double? balQty;
//   double? PORate;
//   double? DataRate;
//   double? PoAmt;
//   double? GSTPer;
//   double? GSTAmt;
//   double? NetAmt;
//   double? grnQty;
//   String? remarks;
//   double? transQty;
//   double? ackQty;
//   String? frProjectName;
//   String? preAppType;
//
//   //----WorkOrder Verify & Approve
//   int? workdetid;
//   String? itemDes;
//   String? fulldescription;
//   String? unit;
//   double? rate;
//   double? amount;
//
//
//   factory OnclickPendingDet.fromJson(Map<String, dynamic> json) => OnclickPendingDet(
//     materialName: json["MaterialName"],
//     materialID: json["Materialid"],
//     scale: json["Scale"],
//     qty: json["Qty"],
//     requestqty: json["ReqQty"],
//     poQty: json["POQty"],
//     balQty: json["BalQty"],
//     PORate: json["PORate"],
//     DataRate: json["DataRate"],
//     PoAmt: json["POAmt"],
//     GSTPer: json["GSTPer"],
//     GSTAmt: json["GSTAmt"],
//     NetAmt: json["NetAmt"],
//     grnQty: json["GRNQty"],
//     remarks: json["Remarks"],
//     transQty: json["TransQty"],
//     ackQty: json["AckQty"],
//     frProjectName: json["FrProjectName"],
//     preAppType: json["PreAppType"],
//
//     //----WorkOrder Verify & Approve
//     workdetid: json["workdetid"],
//     itemDes: json["itemDes"],
//     fulldescription: json["Fulldescription"],
//     unit: json["Unit"],
//     rate: json["Rate"],
//     amount: json["Amt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "MaterialName": materialName,
//     "Materialid": materialID,
//     "Scale": scale,
//     "Qty": qty,
//     "ReqQty": requestqty,
//     "POQty": poQty,
//     "BalQty": balQty,
//     "PORate": PORate,
//     "DataRate": DataRate,
//     "POAmt": PoAmt,
//     "GSTPer": GSTPer,
//     "GSTAmt": GSTAmt,
//     "NetAmt": NetAmt,
//     "GRNQty": grnQty,
//     "Remarks": remarks,
//     "TransQty": transQty,
//     "AckQty": ackQty,
//     "FrProjectName": frProjectName,
//     "PreAppType": preAppType,
//
//     //----WorkOrder Verify & Approve
//     "workdetid" : workdetid,
//     "itemDes": itemDes,
//     "Fulldescription": fulldescription,
//     "Unit": unit,
//     "Rate": rate,
//     "Amt": amount,
//
//   };
// }



// To parse this JSON data, do
//
//     final onclickPendingDet = onclickPendingDetFromJson(jsonString);

import 'dart:convert';

import 'onclickpendingdet_model.dart';

OnclickPendingDet onclickPendingDetFromJson(String str) => OnclickPendingDet.fromJson(json.decode(str));

String onclickPendingDetToJson(OnclickPendingDet data) => json.encode(data.toJson());

class OnclickPendingDet {
  bool? success;
  String? message;
  dynamic? result;

  OnclickPendingDet({
    this.success,
    this.message,
    this.result,
  });

  // factory OnclickPendingDet.fromJson(Map<String, dynamic> json) => OnclickPendingDet(
  //   success: json["success"],
  //   result: OnclickPendingDetResult.fromJson(json["result"]),
  // );

  factory OnclickPendingDet.fromJson(Map<String, dynamic> json)  {
    var res = json["result"];

    if (res is List) {
      return OnclickPendingDet(
        success: json["success"],
        message: json["message"],
        result: res
            .map((e) => MMatReqMasLink.fromJson(e))
            .toList(),
      );
    } else if (res is Map<String, dynamic>) {
      return OnclickPendingDet(
        success: json["success"],
        message: json["message"],
        result: OnclickPendingDetResult.fromJson(res),
      );
    } else {
      return OnclickPendingDet(
        success: json["success"],
        result: null,
      );
    }
  }


  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result!.toJson(),
  };
}

class OnclickPendingDetResult {
  List<MMatReqMasLink>? mMatReqMasLink;
  List<MMatPurOrdLink>? mMatPurOrdLink;
  List<MaterialTransferRequestDets>? materialTransferRequestDets;

  OnclickPendingDetResult({
    this.mMatReqMasLink,
    this.mMatPurOrdLink,
    this.materialTransferRequestDets,
  });


  factory OnclickPendingDetResult.fromJson(Map<String, dynamic> json) {
    return OnclickPendingDetResult(
      mMatReqMasLink: json["mMatReqMasLink"] == null
          ? []
          : List<MMatReqMasLink>.from(
          json["mMatReqMasLink"]
              .map((x) => MMatReqMasLink.fromJson(x))),

      mMatPurOrdLink: json["mMatPurOrdLink"] == null
          ? []
          : List<MMatPurOrdLink>.from(
          json["mMatPurOrdLink"]
              .map((x) => MMatPurOrdLink.fromJson(x))),

      materialTransferRequestDets: json["materialTransferRequestDets"] == null
          ? []
          : List<MaterialTransferRequestDets>.from(
          json["materialTransferRequestDets"]
              .map((x) => MaterialTransferRequestDets.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "mMatReqMasLink": List<dynamic>.from(mMatReqMasLink!.map((x) => x.toJson())),
    "mMatPurOrdLink": List<dynamic>.from(mMatPurOrdLink!.map((x) => x.toJson())),
    "materialTransferRequestDets": List<dynamic>.from(materialTransferRequestDets!.map((x) => x.toJson())),
  };
}

class MMatReqMasLink {
  int? id;
  int? reqMasId;
  int? materialReqOrdMasid;
  int? materialId;
  int? MaterialId;
  int? scaleId;
  int? siteId;
  int? refProjectId;
  double? reqQty;
  double? ReqQty;
  double? qty;
  double? Qty;
  double? tqty;
  String? remarks;
  String? reqDescription;
  String? materialName;
  String? MaterialName;
  String? scaleName;
  String? ScaleName;
  double? stockQty;
  double? stockqty;
  double? balQty;
  double? BalQty;
  double? balqty;
  int? materialID;
  String? scale;
  double? requestqty;
  double? poQty;
  double? POQty;
  double? poqty;
  double? PORate;
  double? DataRate;
  double? PoAmt;
  double? GSTPer;
  double? GSTAmt;
  double? NetAmt;
  double? grnQty;
  double? transQty;
  double? TransQty;
  double? ackQty;
  String? frProjectName;
  String? preAppType;
  String? unitName;
  String? inwType;
  int? purOrdDetId;
  bool? isCheck = false;

  //----WorkOrder Verify & Approve
  int? workdetid;
  String? itemDes;
  String? fulldescription;
  String? unit;
  double? rate;
  double? amount;

  MMatReqMasLink({
    this.id,
    this.reqMasId,
    this.materialReqOrdMasid,
    this.materialId,
    this.MaterialId,
    this.scaleId,
    this.siteId,
    this.refProjectId,
    this.reqQty,
    this.ReqQty,
    this.remarks,
    this.reqDescription,
    this.materialName,
    this.MaterialName,
    this.scaleName,
    this.ScaleName,
    this.stockQty,
    this.stockqty,
    this.balQty,
    this.BalQty,
    this.balqty,
    this.materialID,
    this.scale,
    this.qty,
    this.Qty,
    this.tqty,
    this.requestqty,
    this.poQty,
    this.POQty,
    this.poqty,
    this.PORate,
    this.DataRate,
    this.PoAmt,
    this.GSTPer,
    this.GSTAmt,
    this.NetAmt,
    this.grnQty,
    this.transQty,
    this.TransQty,
    this.ackQty,
    this.frProjectName,
    this.preAppType,
    this.unitName,
    this.inwType,
    this.purOrdDetId,



    //----WorkOrder Verify & Approve
    this.workdetid,
    this.itemDes,
    this.fulldescription,
    this.unit,
    this.rate,
    this.amount,
  });

  factory MMatReqMasLink.fromJson(Map<String, dynamic> json) => MMatReqMasLink(
    id: json["id"],
    reqMasId: json["ReqMasId"],
    materialReqOrdMasid: json["materialReqOrdMasid"],
    materialId: json["materialID"],
    MaterialId: json["MaterialId"],
    scaleId: json["scaleID"],
    siteId: json["siteID"],
    refProjectId: json["refProjectId"],
    reqQty: json["reqQty"],
    ReqQty: json["req_qty"],
    qty: (json['qty'] as num?)?.toDouble(),
    Qty: json["Qty"],
    stockqty: json["stkqty"],
    tqty: json["tqty"],
    remarks: json["remarks"],
    reqDescription: json["reqDescription"],
    materialName: json["materialName"],
    MaterialName: json["MaterialName"],
    scaleName: json["scaleName"],
    ScaleName: json["ScaleName"],
    stockQty: (json['stockQty'] as num?)?.toDouble(),
    balQty: json["balQty"],
    balqty: json["balqty"],
    BalQty: json["BalQty"],
    materialID: json["Materialid"],
    scale: json["Scale"],
    requestqty: json["ReqQty"],
    poQty: json["POQty"],
    POQty: json["PoQty"],
    poqty: json["poqty"],
    PORate: json["PORate"],
    DataRate: json["DataRate"],
    PoAmt: json["POAmt"],
    GSTPer: json["GSTPer"],
    GSTAmt: json["GSTAmt"],
    NetAmt: json["NetAmt"],
    grnQty: json["GRNQty"],
    transQty: json["TransQty"],
    TransQty: json["transQty"],
    ackQty: json["AckQty"],
    frProjectName: json["FrProjectName"],
    preAppType: json["PreAppType"],
    unitName: json["UnitName"],
    inwType: json["InwardType"],
    purOrdDetId: json["PurOrdDetId"],


    //----WorkOrder Verify & Approve
    workdetid: json["workdetid"],
    itemDes: json["itemDes"],
    fulldescription: json["Fulldescription"],
    unit: json["Unit"],
    rate: json["Rate"],
    amount: json["Amt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ReqMasId": reqMasId,
    "materialReqOrdMasid": materialReqOrdMasid,
    "materialID": materialId,
    "scaleID": scaleId,
    "siteID": siteId,
    "refProjectId": refProjectId,
    "reqQty": reqQty,
    "req_qty": ReqQty,
    "qty": qty,
    "Qty": Qty,
    "remarks": remarks,
    "reqDescription": reqDescription,
    "materialName": materialName,
    "MaterialName": MaterialName,
    "scaleName": scaleName,
    "ScaleName": ScaleName,
    "stockQty": stockQty,
    "stkqty": stockqty,
    "balQty": balQty,
    "MaterialName": materialName,
    "Materialid": materialID,
    "MaterialId": MaterialId,
    "Scale": scale,
    "Qty": qty,
    "tqty": tqty,
    "ReqQty": requestqty,
    "POQty": poQty,
    "PoQty": POQty,
    "poqty": poqty,
    "BalQty": balQty,
    "balqty": balqty,
    "BalQty": BalQty,
    "PORate": PORate,
    "DataRate": DataRate,
    "POAmt": PoAmt,
    "GSTPer": GSTPer,
    "GSTAmt": GSTAmt,
    "NetAmt": NetAmt,
    "GRNQty": grnQty,
    "Remarks": remarks,
    "TransQty": transQty,
    "transQty": TransQty,
    "AckQty": ackQty,
    "FrProjectName": frProjectName,
    "PreAppType": preAppType,
    "UnitName": unitName,
    "InwardType": inwType,
    "PurOrdDetId": purOrdDetId,


    //----WorkOrder Verify & Approve
    "workdetid" : workdetid,
    "itemDes": itemDes,
    "Fulldescription": fulldescription,
    "Unit": unit,
    "Rate": rate,
    "Amt": amount,
  };
}


class MMatPurOrdLink {
  int? id;
  int? materialPurOrdMasid;
  int? materialId;
  String? type;
  double? Poqty;
  int? scaleId;
  double? rate;
  double? amount;
  double? discntPercentage;
  double? discntAmount;
  double? vatPer;
  double? vatAmount;
  double? sgstPercentage;
  double? sgstAmount;
  double? cgstPercentage;
  double? cgstAmount;
  double? igstPercentage;
  String? GSTPer;
  String? GSTAmt;
  double? igstAmount;
  double? netAmount;
  String? remarks;
  String? poDescription;
  int? materialReqOrdDetLinkid;
  double? reqQty;
  dynamic reqRate;
  String? materialName;
  double? balQty;
  double? balqty;
  String? unitName;
  String? scaleName;
  int? status;

  MMatPurOrdLink({
    this.id,
    this.materialPurOrdMasid,
    this.materialId,
    this.type,
    this.Poqty,
    this.scaleId,
    this.rate,
    this.amount,
    this.discntPercentage,
    this.discntAmount,
    this.vatPer,
    this.vatAmount,
    this.sgstPercentage,
    this.sgstAmount,
    this.cgstPercentage,
    this.cgstAmount,
    this.igstPercentage,
    this.GSTPer,
    this.GSTAmt,
    this.igstAmount,
    this.netAmount,
    this.remarks,
    this.poDescription,
    this.materialReqOrdDetLinkid,
    this.reqQty,
    this.reqRate,
    this.materialName,
    this.balQty,
    this.balqty,
    this.unitName,
    this.scaleName,
    this.status,
  });

  factory MMatPurOrdLink.fromJson(Map<String, dynamic> json) => MMatPurOrdLink(
    id: json["id"],
    materialPurOrdMasid: json["materialPurOrdMasid"],
    materialId: json["materialID"],
    type: json["type"],
    Poqty: json["qty"],
    scaleId: json["scaleID"],
    rate: json["rate"],
    amount: json["amount"],
    discntPercentage: json["discntPercentage"],
    discntAmount: json["discntAmount"],
    vatPer: json["vatPer"],
    vatAmount: json["vatAmount"],
    sgstPercentage: json["sgstPercentage"],
    sgstAmount: json["sgstAmount"].toDouble(),
    cgstPercentage: json["cgstPercentage"],
    cgstAmount: json["cgstAmount"].toDouble(),
    igstPercentage: json["igstPercentage"],
    GSTPer: json["GSTPer"],
    GSTAmt: json["GSTAmt"],
    igstAmount: json["igstAmount"],
    netAmount: json["netAmount"].toDouble(),
    remarks: json["remarks"],
    poDescription: json["poDescription"],
    materialReqOrdDetLinkid: json["materialReqOrdDetLinkid"],
    reqQty: json["reqQty"],
    reqRate: json["reqRate"],
    materialName: json["materialName"],
    balQty: json["BalQty"],
    balqty: json["balqty"],
    unitName: json["UnitName"],
    scaleName: json["ScaleName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialPurOrdMasid": materialPurOrdMasid,
    "materialID": materialId,
    "type": type,
    "qty": Poqty,
    "scaleID": scaleId,
    "rate": rate,
    "amount": amount,
    "discntPercentage": discntPercentage,
    "discntAmount": discntAmount,
    "vatPer": vatPer,
    "vatAmount": vatAmount,
    "sgstPercentage": sgstPercentage,
    "sgstAmount": sgstAmount,
    "cgstPercentage": cgstPercentage,
    "cgstAmount": cgstAmount,
    "igstPercentage": igstPercentage,
    "GSTPer": GSTPer,
    "GSTAmt": GSTAmt,
    "igstAmount": igstAmount,
    "netAmount": netAmount,
    "remarks": remarks,
    "poDescription": poDescription,
    "materialReqOrdDetLinkid": materialReqOrdDetLinkid,
    "reqQty": reqQty,
    "reqRate": reqRate,
    "materialName": materialName,
    "BalQty": balQty,
    "balqty": balqty,
    "UnitName": unitName,
    "ScaleName": scaleName,
    "status": status,

  };
}


class MaterialTransferRequestDets {
  int? id;
  int? materialTransferRequestMasId;
  int? materialId;
  double? qty;
  double? trQty;
  String? remarks;
  String? materialName;
  String? scaleName;
  double? stockQty;
  dynamic? material;

  MaterialTransferRequestDets({
    this.id,
    this.materialTransferRequestMasId,
    this.materialId,
    this.qty,
    this.trQty,
    this.remarks,
    this.materialName,
    this.scaleName,
    this.stockQty,
    this.material,
  });

  factory MaterialTransferRequestDets.fromJson(Map<String, dynamic> json) => MaterialTransferRequestDets(
    id: json["id"],
    materialTransferRequestMasId: json["materialTransferRequestMasId"],
    materialId: json["materialId"],
    qty: json["qty"],
    trQty: json["trQty"],
    remarks: json["remarks"],
    materialName: json["materialName"],
    scaleName: json["scaleName"],
    stockQty: json["stockQty"],
    material: json["material"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialTransferRequestMasId": materialTransferRequestMasId,
    "materialId": materialId,
    "qty": qty,
    "trQty": trQty,
    "remarks": remarks,
    "materialName": materialName,
    "scaleName": scaleName,
    "stockQty": stockQty,
    "material": material,
  };
}

