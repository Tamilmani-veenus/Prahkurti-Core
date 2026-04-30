class DprNew_LabourTable{
  // int? id;
  int? catId;
  String? catName;
  double? wages;
  String? nos;
  String? otHrs;
  double? otAmt;
  double? netAmt;
  String? remarks;

  DprNew_LabourMap() {
    var mapping = Map<String, dynamic>();
    // mapping['id'] =  id ?? null;
    mapping['catId'] = catId!=null?catId:null;
    mapping['catName'] = catName!=null?catName:null;
    mapping['wages'] = wages!=null?wages:0.0;
    mapping['nos'] = nos!=null?nos:null;
    mapping['otHrs'] = otHrs!=null?otHrs:"0";
    mapping['otAmt'] = otAmt!=null?otAmt:0.0;
    mapping['netAmt'] = netAmt!=null?netAmt:0.0;
    mapping['remarks'] = remarks!=null?remarks:"-";
    return mapping;
  }
}