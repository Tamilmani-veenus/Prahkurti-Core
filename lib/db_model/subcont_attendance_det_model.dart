class SubContDetModel {
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


  SubContDetMap() {
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] =  reqDetId!=null?reqDetId:0;
    mapping['catId'] = catId!=null?catId:null;
    mapping['catName'] = catName!=null?catName:null;
    mapping['wages'] = wages!=null?wages:null;
    mapping['nos'] = nos!=null?nos:null;
    mapping['netAmt'] = netAmt!=null?netAmt:0.0;
    mapping['remarks'] = remarks!=null?remarks:"-";
    mapping['siteId'] = siteId!=null?siteId:null;
    mapping['siteName'] = siteName!=null?siteName:null;
    mapping['MrgOtHrs'] = MrgOtHrs!=null?MrgOtHrs:0.0;
    mapping['MrgOtAmt'] = MrgOtAmt!=null?MrgOtAmt:0.0;
    mapping['EvgOtHrs'] = EvgOtHrs!=null?EvgOtHrs:0.0;
    mapping['EvgOtAmt'] = EvgOtAmt!=null?EvgOtAmt:0.0;
    mapping['EvgExtrsAmt'] = EvgExtrsAmt!=null?EvgExtrsAmt:0.0;
    mapping['Extra'] = Extra!=null?Extra:0.0;
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

