// To parse this JSON data, do
//
//     final boqRevisedItemResponse = boqRevisedItemResponseFromJson(jsonString);

import 'dart:convert';

BoqRevisedItemResponse boqRevisedItemResponseFromJson(String str) => BoqRevisedItemResponse.fromJson(json.decode(str));

String boqRevisedItemResponseToJson(BoqRevisedItemResponse data) => json.encode(data.toJson());

class BoqRevisedItemResponse {
  bool? success;
  String? message;
  List<Result>? result;

  BoqRevisedItemResponse({
    this.success,
    this.message,
    this.result,
  });

  factory BoqRevisedItemResponse.fromJson(Map<String, dynamic> json) => BoqRevisedItemResponse(
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
  int? measureHeadItemId;
  String? headItemName;
  List<SubItem>? subItems;

  Result({
    this.measureHeadItemId,
    this.headItemName,
    this.subItems,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    measureHeadItemId: json["measureHeadItemId"],
    headItemName: json["headItemName"],
    subItems: List<SubItem>.from(json["subItems"].map((x) => SubItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "measureHeadItemId": measureHeadItemId,
    "headItemName": headItemName,
    "subItems": List<dynamic>.from(subItems!.map((x) => x.toJson())),
  };
}

class SubItem {
  int? measureSubItemId;
  String? subItem;
  String? seqno;
  List<Level3Item>? level3Items;

  SubItem({
    this.measureSubItemId,
    this.subItem,
    this.seqno,
    this.level3Items,
  });

  factory SubItem.fromJson(Map<String, dynamic> json) => SubItem(
    measureSubItemId: json["measureSubItemId"],
    subItem: json["subItem"],
    seqno: json["seqno"],
    level3Items: List<Level3Item>.from(json["level3Items"].map((x) => Level3Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "measureSubItemId": measureSubItemId,
    "subItem": subItem,
    "seqno": seqno,
    "level3Items": List<dynamic>.from(level3Items!.map((x) => x.toJson())),
  };
}

class Level3Item {
  int? level3ItemId;
  String? name;
  String? seqno;
  double? qty;
  int? unit;
  String? scaleName;
  double? rate;
  bool? isCheck=false;

  Level3Item({
    this.level3ItemId,
    this.name,
    this.seqno,
    this.qty,
    this.unit,
    this.scaleName,
    this.rate,
  });

  factory Level3Item.fromJson(Map<String, dynamic> json) => Level3Item(
    level3ItemId: json["level3ItemId"],
    name: json["name"],
    seqno: json["seqno"],
    qty: json["qty"],
    unit: json["unit"],
    scaleName: json["scaleName"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "level3ItemId": level3ItemId,
    "name": name,
    "seqno": seqno,
    "qty": qty,
    "unit": unit,
    "scaleName": scaleName,
    "rate": rate,
  };
}
