// To parse this JSON data, do
//
//     final projectnameCompanywise = projectnameCompanywiseFromJson(jsonString);

import 'dart:convert';

List<ProjectnameCompanywise> projectnameCompanywiseFromJson(String str) => List<ProjectnameCompanywise>.from(json.decode(str).map((x) => ProjectnameCompanywise.fromJson(x)));

String projectnameCompanywiseToJson(List<ProjectnameCompanywise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectnameCompanywise {
  int projectId;
  String project;

  ProjectnameCompanywise({
    required this.projectId,
    required this.project,
  });

  factory ProjectnameCompanywise.fromJson(Map<String, dynamic> json) => ProjectnameCompanywise(
    projectId: json["ProjectId"],
    project: json["Project"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "Project": project,
  };
}
