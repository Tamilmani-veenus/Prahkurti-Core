class SubContDetModel {
  int? id;
  int? reqDetId;
  int? catId;
  String? catName;
  double? wages;
  String? nos;
  double? netAmt;
  String? remarks;
  int? siteId;
  String? siteName;
  double? MrgOtHrs;
  double? MrgOtAmt;
  double? EvgOtHrs;
  double? EvgOtAmt;
  double? EvgExtrsAmt;
  double? Extra;
  double? hrs;


  SubContDetMap() {
    var mapping = <String, dynamic>{};
    if (id != null) {
      mapping['id'] = id;
    }

    mapping['reqDetId'] = reqDetId ?? 0;
    mapping['catId'] = catId;
    mapping['catName'] = catName;
    mapping['wages'] = wages;
    mapping['nos'] = nos;
    mapping['netAmt'] = netAmt ?? 0;
    mapping['remarks'] = remarks ?? "-";
    mapping['siteId'] = siteId;
    mapping['siteName'] = siteName;
    mapping['MrgOtHrs'] = MrgOtHrs ?? 0;
    mapping['MrgOtAmt'] = MrgOtAmt ?? 0;
    mapping['EvgOtHrs'] = EvgOtHrs ?? 0;
    mapping['EvgOtAmt'] = EvgOtAmt ?? 0;
    mapping['EvgExtrsAmt'] = EvgExtrsAmt ?? 0;
    mapping['Extra'] = Extra ?? 0;
    mapping['hrs'] = hrs ?? 0;
    return mapping;
  }

}







// // To parse this JSON data, do
// //
// //     final subContDetModel = subContDetModelFromJson(jsonString);
//
// import 'dart:convert';
//
// SubContDetModel subContDetModelFromJson(String str) => SubContDetModel.fromJson(json.decode(str));
//
// String subContDetModelToJson(SubContDetModel data) => json.encode(data.toJson());
//
// class SubContDetModel {
//   SubContDetModel({
//     this.id,
//     this.catName,
//     this.wages,
//     this.nos,
//     this.otHrs,
//     this.otAmt,
//     this.netAmt,
//     this.remarks,
//     this.siteId,
//   });
//
//   int? id;
//   String? catName;
//   double? wages;
//   String? nos;
//   String? otHrs;
//   double? otAmt;
//   double? netAmt;
//   String? remarks;
//   int? siteId;
//
//   factory SubContDetModel.fromJson(Map<String, dynamic> json) => SubContDetModel(
//     id: json["id"],
//     catName: json["catName"],
//     wages: json["wages"],
//     nos: json["nos"],
//     otHrs: json["otHrs"],
//     otAmt: json["otAmt"],
//     netAmt: json["netAmt"],
//     remarks: json["remarks"],
//     siteId: json["siteId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "catName": catName,
//     "wages": wages,
//     "nos": nos,
//     "otHrs": otHrs,
//     "otAmt": otAmt,
//     "netAmt": netAmt,
//     "remarks": remarks,
//     "siteId": siteId,
//   };
// }

