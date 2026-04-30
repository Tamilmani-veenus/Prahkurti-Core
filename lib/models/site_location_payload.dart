class SiteLocationPayload {
  // String? siteName;
  int? ProjectId;
  String? projectName;
  String? empId;
  String? punchDate;
  String? status;
  String? userId;
  String? userType;
  String? check;

  SiteLocationPayload({
    // this.siteName,
    this.ProjectId,
    this.projectName,
    this.empId,
    this.punchDate,
    this.status,
    this.userId,
    this.userType,
    this.check,
  });


  Map<String, dynamic> toJson() => {
    // "SiteName": siteName.toString(),
    "Projectid": ProjectId.toString()==null?0:ProjectId.toString(),
    "ProjectName": projectName.toString(),
    "EmpId": empId.toString(),
    "Punch_date": punchDate.toString(),
    "Status": status.toString(),
    "UserId": userId.toString(),
    "UserType": userType.toString(),
    "Check": check.toString(),
  };
}
