import 'dart:convert';

BillDirectWorkOrdDet billDirectWorkOrdDetFromJson(String str) => BillDirectWorkOrdDet.fromJson(json.decode(str));

String billDirectWorkOrdDetToJson(BillDirectWorkOrdDet data) => json.encode(data.toJson());

class BillDirectWorkOrdDet {
  bool? success;
  List<Result>? result;
  String? message;

  BillDirectWorkOrdDet({
    this.success,
    this.result,
    this.message,
  });

  factory BillDirectWorkOrdDet.fromJson(Map<String, dynamic> json) => BillDirectWorkOrdDet(
      success: json["success"],
      result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  String? itemDesc;
  String? unit;
  double? qty;
  double? rate;
  double? amount;

  Result({
    this.itemDesc,
    this.unit,
    this.qty,
    this.rate,
    this.amount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    itemDesc: json["itemDescription"],
    unit: json["unit"],
    qty: json["qty"],
    rate: json["rate"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "itemDescription": itemDesc,
    "unit": unit,
    "qty": qty,
    "rate": rate,
    "amount": amount,
  };
}