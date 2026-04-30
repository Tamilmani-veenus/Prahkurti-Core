import 'dart:convert';

PoApprovalCheckBoxSave poApprovalCheckBoxSaveFromJson(String str) => PoApprovalCheckBoxSave.fromJson(json.decode(str));

String poApprovalCheckBoxSaveToJson(PoApprovalCheckBoxSave data) => json.encode(data.toJson());

class PoApprovalCheckBoxSave {
  bool? success;
  String? message;

  PoApprovalCheckBoxSave({
    this.success,
    this.message,
  });

  factory PoApprovalCheckBoxSave.fromJson(Map<String, dynamic> json) => PoApprovalCheckBoxSave(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}