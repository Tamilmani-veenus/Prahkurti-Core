// To parse this JSON data, do
//
//     final bankNamelistModel = bankNamelistModelFromJson(jsonString);

import 'dart:convert';

List<BankNamelistModel> bankNamelistModelFromJson(String str) => List<BankNamelistModel>.from(json.decode(str).map((x) => BankNamelistModel.fromJson(x)));

String bankNamelistModelToJson(List<BankNamelistModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankNamelistModel {
  int bankId;
  String bank;

  BankNamelistModel({
    required this.bankId,
    required this.bank,
  });

  factory BankNamelistModel.fromJson(Map<String, dynamic> json) => BankNamelistModel(
    bankId: json["Bank_id"],
    bank: json["Bank"],
  );

  Map<String, dynamic> toJson() => {
    "Bank_id": bankId,
    "Bank": bank,
  };
}
