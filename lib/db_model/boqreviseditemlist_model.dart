class BoqItemlist{
  int? reqDetId;
  int? measureHeadItemId;
  int? measureSubItemId;
  int? measureLevel3ItemId;
  int? scaleId;
  String? level3ItemName;
  double? rate;
  double? qty;
  double? reviseQty;
  String? scaleName;
  double? amt;

  BoqItemlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['measureHeadItemId'] = measureHeadItemId != null ? measureHeadItemId : null;
    mapping['measureSubItemId'] = measureSubItemId != null ? measureSubItemId : null;
    mapping['measureLevel3ItemId'] = measureLevel3ItemId != null ? measureLevel3ItemId : null;
    mapping['scaleId'] = scaleId != null ? scaleId : null;
    mapping['level3ItemName'] = level3ItemName != null ? level3ItemName : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['reviseQty'] = reviseQty != null ? reviseQty : null;
    mapping['scaleName'] = scaleName != null ? scaleName : null;
    mapping['amt'] = amt != null ? amt : null;
    return mapping;
  }
}