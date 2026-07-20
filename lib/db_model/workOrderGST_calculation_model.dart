class WorkOrderGSTCalTable{
  int? reqDetId;
  int? addLessId;
  double? percentValue;
  double? amount;
  String? addLessName;
  String? addLessType;

  WorkOrderGSTCalTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] =  reqDetId!=null?reqDetId:0;
    mapping['addLessId'] = addLessId!=null?addLessId:0;
    mapping['percentValue'] = percentValue!=null?percentValue:0.0;
    mapping['amount'] = amount!=null?amount:0.0;
    mapping['addLessName'] = addLessName!=null?addLessName:"";
    mapping['addLessType'] = addLessType!=null?addLessType:"";
    return mapping;
  }
}