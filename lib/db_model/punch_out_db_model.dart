class PunchOutDbModel {
  String? empId;
  String? date;
  String? timeOut;
  String? entryMode;
  String? userId;
  String? deviceName;
  String? locId;

  punchOutDbModelMap(){
    var mapping = Map<String, dynamic>();
    mapping['empId'] = empId != null ? empId : null;
    mapping['date'] = date != null ? date : null;
    mapping['timeOut'] = timeOut != null ? timeOut : null;
    mapping['entryMode'] = entryMode != null ? entryMode : null;
    mapping['userId'] = userId != null ? userId : null;
    mapping['deviceName'] = deviceName != null ? deviceName : null;
    mapping['locId'] = locId != null ? locId : null;
    return mapping;
  }
}