class DprNew_DetTable{
  int? reqDetId;
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
  int? unitId;
  String? cement;
  String? workremarks;
  int? workdetid;
  int? siteid;

  DprNew_DetTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : 0;
    mapping['headItemId'] = headItemId != null ? headItemId : 0;
    mapping['subItemId'] = subItemId != null ? subItemId : 0;
    mapping['level3ItemId'] = level3ItemId != null ? level3ItemId : 0;
    mapping['woDetId'] = woDetId != null ? woDetId : 0;
    mapping['itemDesc'] = itemDesc != null ? itemDesc : "";
    mapping['units'] = unit != null ? unit : "";
    mapping['rate'] = rate != null ? rate : 0.0;
    mapping['qty'] = qty != null ? qty : 0.0;
    mapping['amt'] = amt != null ? amt : 0.0;
    mapping['balQty'] = balQty != null ? balQty : 0.0;
    mapping['boqCode'] = boqCode != null ? boqCode : "";
    mapping['unitId'] = unitId != null ? unitId : 0;
    mapping['cement'] = cement != null ? cement : "";
    mapping['workremarks'] = workremarks != null ? workremarks : "";
    mapping['workdetid'] = workdetid != null ? workdetid : 0;
    mapping['siteid'] = siteid != null ? siteid : 0;
    return mapping;
  }
}