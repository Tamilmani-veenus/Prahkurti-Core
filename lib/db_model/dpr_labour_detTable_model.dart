class DprLabour_DetTable{
  int? headItemId;
  int? subItemId;
  int? level3ItemId;
  int? woDetId;
  String? itemDesc;
  String? unit;
  double? rate;
  double? qty;
  double? amt;
  double? balQty;
  String? boqCode;

  DprLabour_DetTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['headItemId'] = headItemId != null ? headItemId : null;
    mapping['subItemId'] = subItemId != null ? subItemId : null;
    mapping['level3ItemId'] = level3ItemId != null ? level3ItemId : null;
    mapping['woDetId'] = woDetId != null ? woDetId : null;
    mapping['itemDesc'] = itemDesc != null ? itemDesc : null;
    mapping['units'] = unit != null ? unit : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['amt'] = amt != null ? amt : null;
    mapping['balQty'] = balQty != null ? balQty : null;
    mapping['boqCode'] = boqCode != null ? boqCode : null;
    return mapping;
  }
}