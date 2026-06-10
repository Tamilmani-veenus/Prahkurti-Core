// To parse this JSON data, do
//
//     final workOrderNoResponse = workOrderNoResponseFromJson(jsonString);

import 'dart:convert';

WorkOrderNoResponse workOrderNoResponseFromJson(String str) => WorkOrderNoResponse.fromJson(json.decode(str));

String workOrderNoResponseToJson(WorkOrderNoResponse data) => json.encode(data.toJson());

class WorkOrderNoResponse {
  bool? success;
  List<Result>? result;
  String? message;

  WorkOrderNoResponse({
    this.success,
    this.result,
    this.message,
  });

  factory WorkOrderNoResponse.fromJson(Map<String, dynamic> json) => WorkOrderNoResponse(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message
  };
}

class Result {
  int? workOrderId;
  String? workOrderNo;
  String? workOrderNoBoq;

  Result({
    this.workOrderId,
    this.workOrderNo,
    this.workOrderNoBoq,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    workOrderId: json["id"],
    workOrderNo: json["orderNo"],
    workOrderNoBoq: json["workOrderNoDd"]
  );

  Map<String, dynamic> toJson() => {
    "id": workOrderId,
    "orderNo": workOrderNo,
    "workOrderNoDd": workOrderNoBoq
  };
}
