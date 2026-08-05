// To parse this JSON data, do
//
//     final manPowerLevel3Model = manPowerLevel3ModelFromJson(jsonString);

import 'dart:convert';

ManPowerLevel3Model manPowerLevel3ModelFromJson(String str) => ManPowerLevel3Model.fromJson(json.decode(str));

String manPowerLevel3ModelToJson(ManPowerLevel3Model data) => json.encode(data.toJson());

class ManPowerLevel3Model {
  bool? success;
  String? message;
  List<Level3Result>? result;

  ManPowerLevel3Model({
     this.success,
     this.message,
     this.result,
  });

  factory ManPowerLevel3Model.fromJson(Map<String, dynamic> json) => ManPowerLevel3Model(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Level3Result>.from(json["result"].map((x) => Level3Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Level3Result {
  int? id;
  int? subItemid;
  int? headItemid;
  String? level3Item;
  double? qty;
  int? scaleId;
  String? seqNo;
  String? scaleName;
  String? headandSubName;
  bool? isCheck = false;

  Level3Result({
    required this.id,
    required this.subItemid,
    required this.headItemid,
    required this.level3Item,
    required this.qty,
    required this.scaleId,
    required this.seqNo,
    required this.scaleName,
    required this.headandSubName,
  });

  factory Level3Result.fromJson(Map<String, dynamic> json) => Level3Result(
    id: json["id"],
    subItemid: json["subItemid"],
    headItemid: json["headItemid"],
    level3Item: json["level3Item"],
    qty: json["qty"],
    scaleId: json["scaleId"],
    seqNo: json["seqNo"],
    scaleName: json["scaleName"],
    headandSubName: json["headandSubName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subItemid": subItemid,
    "headItemid": headItemid,
    "level3Item": level3Item,
    "qty": qty,
    "scaleId": scaleId,
    "seqNo": seqNo,
    "scaleName": scaleName,
    "headandSubName": headandSubName,
  };
}
