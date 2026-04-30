// // To parse this JSON data, do
// //
// //     final poAmendmentList = poAmendmentListFromJson(jsonString);
//
// import 'dart:convert';
//
// List<PoAmendmentList> poAmendmentListFromJson(String str) => List<PoAmendmentList>.from(json.decode(str).map((x) => PoAmendmentList.fromJson(x)));
//
// String poAmendmentListToJson(List<PoAmendmentList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class PoAmendmentList {
//   int? purOrdDetId;
//   int? purOrdMasId;
//   int? materialid;
//   String? material;
//   String? scale;
//   double? qty;
//   double? qty1;
//   double? grnQty;
//   double? adDqty;
//   double? lessqty;
//   double? balQty;
//   bool? isCheck = false;
//
//   PoAmendmentList({
//     this.purOrdDetId,
//     this.purOrdMasId,
//     this.materialid,
//     this.material,
//     this.scale,
//     this.qty,
//     this.qty1,
//     this.grnQty,
//     this.adDqty,
//     this.lessqty,
//     this.balQty,
//   });
//
//   factory PoAmendmentList.fromJson(Map<String, dynamic> json) => PoAmendmentList(
//     purOrdDetId: json["pur_ord_det_id"],
//     purOrdMasId: json["Pur_ord_mas_id"],
//     materialid: json["Materialid"],
//     material: json["Material"],
//     scale: json["Scale"],
//     qty: json["qty"],
//     qty1: json["qty1"],
//     grnQty: json["GRNQty"],
//     adDqty: json["ADDqty"],
//     lessqty: json["LESSqty"],
//     balQty: json["Bal_Qty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pur_ord_det_id": purOrdDetId,
//     "Pur_ord_mas_id": purOrdMasId,
//     "Materialid": materialid,
//     "Material": material,
//     "Scale": scale,
//     "qty": qty,
//     "qty1": qty1,
//     "GRNQty": grnQty,
//     "ADDqty": adDqty,
//     "LESSqty": lessqty,
//     "Bal_Qty": balQty,
//   };
// }
//
//




// To parse this JSON data, do
//
//     final poAmendmentList = poAmendmentListFromJson(jsonString);



