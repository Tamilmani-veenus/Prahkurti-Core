class PunchInDbModel {
  String? empId;
  String? dateIn;
  String? entryMode;
  String? locId;
  String? userId;
  String? deviceName;
  String? punchTimeIn;
  String? imagePath;

  punchInDbModelMap(){
    var mapping = Map<String, dynamic>();
    mapping['empId'] = empId != null ? empId : null;
    mapping['dateIn'] = dateIn != null ? dateIn : null;
    mapping['entryMode'] = entryMode != null ? entryMode : null;
    mapping['locId'] = locId != null ? locId : null;
    mapping['userId'] = userId != null ? userId : null;
    mapping['deviceName'] = deviceName != null ? deviceName : null;
    mapping['punchTimeIn'] = punchTimeIn != null ? punchTimeIn : null;
    mapping['imagePath'] = imagePath != null ? imagePath : null;
    return mapping;
  }
}