class SitevoucherDetlist{
  int? siteid;
  int? reqDetId;
  String? paytype;
  String? sitename;
  double? amt;
  double? TdsPer;
  double? TdsAmt;
  double? NetAmt;

  SitevoucherDetlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['siteid'] = siteid != null ? siteid : null;
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['paytype'] = paytype != null ? paytype : null;
    mapping['sitename'] = sitename != null ? sitename : null;
    mapping['amt'] = amt != null ? amt : null;
    mapping['TdsPer'] = TdsPer != null ? TdsPer : null;
    mapping['TdsAmt'] = TdsAmt != null ? TdsAmt : null;
    mapping['NetAmt'] = NetAmt != null ? NetAmt : null;
    return mapping;
  }
}