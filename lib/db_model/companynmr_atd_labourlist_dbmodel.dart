class CompanyNMRDetTableModel{
  // int? id;
  int? labourId;
  String? labourName;
  String? Labour_No;
  String? categaryName;
  double? wages;
  String? shift;
  String? status;
  double? busfare;
  double? othrs;
  double? advance;
  String? detRemarks;

  CompanyNMRDetTableMap(){
    var mapping = Map<String, dynamic>();
    // mapping['id'] = id != null ? id : null;
    mapping['labourId'] = labourId != null ? labourId : null;
    mapping['labourName'] = labourName != null ? labourName : null;
    mapping['Labour_No'] = Labour_No != null ? Labour_No : null;
    mapping['categaryName'] = categaryName != null ? categaryName : null;
    mapping['wages'] = wages != null ? wages : null;
    mapping['shift'] = shift != null ? shift : null;
    mapping['status'] = status != null ? status : null;
    mapping['busfare'] = busfare != null ? busfare : null;
    mapping['othrs'] = othrs != null ? othrs : null;
    mapping['advance'] = advance != null ? advance : null;
    mapping['detRemarks'] = detRemarks != null ? detRemarks : null;
   return mapping;
  }

}