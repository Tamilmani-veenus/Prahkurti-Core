class WorkOrderBoqItemlist{
  int? reqDetId;
  int? headItemId;
  int? subItemId;
  int? measureLevel3ItemId;
  int? unit;
  String? itemDesc;
  double? rate;
  double? qty;
  double? oldRate;
  String? scaleName;
  double? amt;
  double? balqty;
  double? labrate;
  String? boqcode;
  String? remarks;
  bool? workOrderStatus;

  WorkOrderBoqItemlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['headItemId'] = headItemId != null ? headItemId : null;
    mapping['subItemId'] = subItemId != null ? subItemId : null;
    mapping['measureLevel3ItemId'] = measureLevel3ItemId != null ? measureLevel3ItemId : null;
    mapping['unit'] = unit != null ? unit : null;
    mapping['itemDesc'] = itemDesc != null ? itemDesc : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['oldRate'] = oldRate != null ? oldRate : null;
    mapping['scaleName'] = scaleName != null ? scaleName : null;
    mapping['amt'] = amt != null ? amt : null;
    mapping['balqty'] = balqty != null ? balqty : null;
    mapping['labrate'] = labrate != null ? labrate : null;
    mapping['boqcode'] = boqcode != null ? boqcode : null;
    mapping['remarks'] = remarks != null ? remarks : null;
    mapping['workOrderStatus'] = workOrderStatus != null ? workOrderStatus : null;
    return mapping;
  }
}
