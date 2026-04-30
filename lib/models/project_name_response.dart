// import 'dart:convert';
// /// ProjectName : [{"projectid":0,"Project":"--SELECT--"},{"projectid":6,"Project":"TEST PROJECT B"},{"projectid":7,"Project":"CNV TEXTILES PVT LTD "}]
//
// ProjectNameResponse projectNameResponseFromJson(String str) => ProjectNameResponse.fromJson(json.decode(str));
// String projectNameResponseToJson(ProjectNameResponse data) => json.encode(data.toJson());
// class ProjectNameResponse {
//   ProjectNameResponse({
//       List<ProjectName>? projectName,}){
//     _projectName = projectName;
// }
//
//   ProjectNameResponse.fromJson(dynamic json) {
//     if (json['ProjectName'] != null) {
//       _projectName = [];
//       json['ProjectName'].forEach((v) {
//         _projectName?.add(ProjectName.fromJson(v));
//       });
//     }
//   }
//   List<ProjectName>? _projectName;
// ProjectNameResponse copyWith({  List<ProjectName>? projectName,
// }) => ProjectNameResponse(  projectName: projectName ?? _projectName,
// );
//   List<ProjectName>? get projectName => _projectName;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_projectName != null) {
//       map['ProjectName'] = _projectName?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// projectid : 0
// /// Project : "--SELECT--"
//
// ProjectName projectNameFromJson(String str) => ProjectName.fromJson(json.decode(str));
// String projectNameToJson(ProjectName data) => json.encode(data.toJson());
// class ProjectName {
//   ProjectName({
//       num? projectid,
//       String? project,}){
//     _projectid = projectid;
//     _project = project;
// }
//
//   ProjectName.fromJson(dynamic json) {
//     _projectid = json['projectid'];
//     _project = json['Project'];
//   }
//   num? _projectid;
//   String? _project;
// ProjectName copyWith({  num? projectid,
//   String? project,
// }) => ProjectName(  projectid: projectid ?? _projectid,
//   project: project ?? _project,
// );
//   num? get projectid => _projectid;
//   String? get project => _project;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['projectid'] = _projectid;
//     map['Project'] = _project;
//     return map;
//   }
//
// }