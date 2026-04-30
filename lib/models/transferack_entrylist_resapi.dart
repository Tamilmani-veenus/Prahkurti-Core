import 'dart:convert';

List<TransferAckEntryListApi> transferAckEntryListApiFromJson(String str) => List<TransferAckEntryListApi>.from(json.decode(str).map((x) => TransferAckEntryListApi.fromJson(x)));

String transferAckEntryListApiToJson(List<TransferAckEntryListApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferAckEntryListApi {
  TransferAckEntryListApi({
    this.transferId,
    this.ackMasId,
    this.ackNo,
    this.transferNo,
    this.eDate,
    this.exdate,
    this.fromProject,
    this.toProject,
  });

  int? transferId;
  int? ackMasId;
  String? ackNo;
  String? transferNo;
  String? eDate;
  String? exdate;
  String? fromProject;
  String? toProject;

  factory TransferAckEntryListApi.fromJson(Map<String, dynamic> json) => TransferAckEntryListApi(
    transferId: json["Transfer_id"],
    ackMasId: json["Ack_Mas_Id"],
    ackNo: json["Ack_No"],
    transferNo: json["Transfer_No"],
    eDate: json["EDate"],
    exdate: json["Exdate"],
    fromProject: json["From Project"],
    toProject: json["To Project"],
  );

  Map<String, dynamic> toJson() => {
    "Transfer_id": transferId,
    "Ack_Mas_Id": ackMasId,
    "Ack_No": ackNo,
    "Transfer_No": transferNo,
    "EDate": eDate,
    "Exdate": exdate,
    "From Project": fromProject,
    "To Project": toProject,
  };
}
