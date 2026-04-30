import 'dart:convert';

import 'dart:convert';

ChangedPasswordResponse changedPasswordResponseFromJson(String str) =>
    ChangedPasswordResponse.fromJson(json.decode(str));

String changedPasswordResponseToJson(ChangedPasswordResponse data) =>
    json.encode(data.toJson());

class ChangedPasswordResponse {
  bool? success;
  String? result;

  ChangedPasswordResponse({
     this.success,
     this.result,
  });

  factory ChangedPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangedPasswordResponse(
      success: json["success"] ,
      result: json["result"] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "result": result,
    };
  }
}

