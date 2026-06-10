class DprNew_LabourTable{
  int? reqDetId;
  int? catId;
  String? catName;
  double? wages;
  double? nos;
  double? otHrs;
  double? otAmt;
  double? netAmt;
  String? remarks;
  int? labourId;

  DprNew_LabourMap() {
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] =  reqDetId!=null?reqDetId:0;
    mapping['catId'] = catId!=null?catId:0;
    mapping['catName'] = catName!=null?catName:"";
    mapping['wages'] = wages!=null?wages:0.0;
    mapping['nos'] = nos!=null?nos:0.0;
    mapping['otHrs'] = otHrs!=null?otHrs:0.0;
    mapping['otAmt'] = otAmt!=null?otAmt:0.0;
    mapping['netAmt'] = netAmt!=null?netAmt:0.0;
    mapping['remarks'] = remarks!=null?remarks:"-";
    mapping['labourId'] = labourId!=null?labourId:0;
    return mapping;
  }
}