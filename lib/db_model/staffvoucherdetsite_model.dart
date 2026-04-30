class StaffvouchersiteDetlist{
  int? siteid;
  int? projectid;
  String? paytype;
  String? sitename;
  String? projectname;
  double? amt;
  double? TdsPer;
  double? TdsAmt;
  double? NetAmt;

  StaffvouchersiteDetlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['siteid'] = siteid != null ? siteid : null;
    mapping['projectid'] = projectid != null ? projectid : null;
    mapping['paytype'] = paytype != null ? paytype : null;
    mapping['sitename'] = sitename != null ? sitename : null;
    mapping['projectname'] = projectname != null ? projectname : null;
    mapping['amt'] = amt != null ? amt : null;
    mapping['TdsPer'] = TdsPer != null ? TdsPer : null;
    mapping['TdsAmt'] = TdsAmt != null ? TdsAmt : null;
    mapping['NetAmt'] = NetAmt != null ? NetAmt : null;
    return mapping;
  }
}