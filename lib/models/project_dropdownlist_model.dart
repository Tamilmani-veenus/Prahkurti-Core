
import 'dart:convert';

// To parse this JSON data, do
//
//     final projectDropdownListResponse = projectDropdownListResponseFromJson(jsonString);

ProjectDropdownListResponse projectDropdownListResponseFromJson(String str) => ProjectDropdownListResponse.fromJson(json.decode(str));

String projectDropdownListResponseToJson(ProjectDropdownListResponse data) => json.encode(data.toJson());

class ProjectDropdownListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  ProjectDropdownListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory ProjectDropdownListResponse.fromJson(Map<String, dynamic> json) => ProjectDropdownListResponse(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? projectId;
  String? project;

  Result({
    this.projectId,
    this.project,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    projectId: json["id"],
    project: json["projectName"],
  );

  Map<String, dynamic> toJson() => {
    "id": projectId,
    "projectName": project,
  };
}

List<HeadNameRes> headNameResFromJson(String str) => List<HeadNameRes>.from(json.decode(str).map((x) => HeadNameRes.fromJson(x)));

String headNameResToJson(List<HeadNameRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HeadNameRes {
  HeadNameRes({
    this.headitemId,
    this.headItem,
  });

  int? headitemId;
  String? headItem;

  factory HeadNameRes.fromJson(Map<String, dynamic> json) => HeadNameRes(
    headitemId: json["Headitem_id"],
    headItem: json["HeadItem"],
  );

  Map<String, dynamic> toJson() => {
    "Headitem_id": headitemId,
    "HeadItem": headItem,
  };
}
