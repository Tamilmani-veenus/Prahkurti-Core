class CompanyNMRDetTableModel{
  int? reqDetId;
  int? labourId;
  int? categaryId;
  String? labourName;
  String? labourNo;
  String? categaryName;
  double? wages;
  String? status;
  String? statusKeyText;
  double? othrs;
  String? detRemarks;

  CompanyNMRDetTableMap(){
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['labourId'] = labourId != null ? labourId : null;
    mapping['categaryId'] = categaryId != null ? categaryId : null;
    mapping['labourName'] = labourName != null ? labourName : null;
    mapping['labourNo'] = labourNo != null ? labourNo : null;
    mapping['categaryName'] = categaryName != null ? categaryName : null;
    mapping['wages'] = wages != null ? wages : null;
    mapping['status'] = status != null ? status : null;
    mapping['statusKeyText'] = statusKeyText != null ? statusKeyText : null;
    mapping['othrs'] = othrs != null ? othrs : null;
    mapping['detRemarks'] = detRemarks != null ? detRemarks : null;
   return mapping;
  }

}