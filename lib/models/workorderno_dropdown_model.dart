// To parse this JSON data, do
//
//     final workOrderNoResponse = workOrderNoResponseFromJson(jsonString);

import 'dart:convert';

List<WorkOrderNoResponse> workOrderNoResponseFromJson(String str) => List<WorkOrderNoResponse>.from(json.decode(str).map((x) => WorkOrderNoResponse.fromJson(x)));

String workOrderNoResponseToJson(List<WorkOrderNoResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkOrderNoResponse {
  int? workOrderId;
  String? workOrderNo;

  WorkOrderNoResponse({
    this.workOrderId,
    this.workOrderNo,
  });

  factory WorkOrderNoResponse.fromJson(Map<String, dynamic> json) => WorkOrderNoResponse(
    workOrderId: json["WorkOrderId"],
    workOrderNo: json["WorkOrderNo"],
  );

  Map<String, dynamic> toJson() => {
    "WorkOrderId": workOrderId,
    "WorkOrderNo": workOrderNo,
  };
}
