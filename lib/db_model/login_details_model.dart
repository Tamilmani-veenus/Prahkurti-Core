class LoginDetailsModel {
  int? userId;
  String? userName;
  String? userType;
  String? userActive;
  int? userAppActive;
  int? empId;
  String? empName;

  loginDetailsModelMap(){
    var mapping = Map<String, dynamic>();
    mapping['userId'] = userId != null ? userId : null;
    mapping['userName'] = userName != null ? userName : null;
    mapping['userType'] = userType != null ? userType : null;
    mapping['userActive'] = userActive != null ? userActive : null;
    mapping['userAppActive'] = userAppActive != null ? userAppActive : null;
    mapping['empId'] = empId != null ? empId : null;
    mapping['empName'] = empName != null ? empName : null;
    return mapping;
  }
}