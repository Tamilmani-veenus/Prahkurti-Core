import 'dart:convert';

List<SupplierOsExpensesResponse> supplierOsExpensesResponseFromJson(String str) => List<SupplierOsExpensesResponse>.from(json.decode(str).map((x) => SupplierOsExpensesResponse.fromJson(x)));

String supplierOsExpensesResponseToJson(List<SupplierOsExpensesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupplierOsExpensesResponse {
  SupplierOsExpensesResponse({
    this.sNo,
    this.supplier,
    this.op,
    this.billamt,
    this.advamt,
    this.retAmt,
    this.balamt,
    this.excessamt,
  });

  int? sNo;
  String? supplier;
  double? op;
  double? billamt;
  double? advamt;
  double? retAmt;
  double? balamt;
  double? excessamt;

  factory SupplierOsExpensesResponse.fromJson(Map<String, dynamic> json) => SupplierOsExpensesResponse(
    sNo: json["SNo"],
    supplier: json["supplier"],
    op: json["op"],
    billamt: json["billamt"],
    advamt: json["advamt"],
    retAmt: json["RetAmt"],
    balamt: json["balamt"],
    excessamt: json["excessamt"],
  );

  Map<String, dynamic> toJson() => {
    "SNo": sNo,
    "supplier": supplier,
    "op": op,
    "billamt": billamt,
    "advamt": advamt,
    "RetAmt": retAmt,
    "balamt": balamt,
    "excessamt": excessamt,
  };
}
