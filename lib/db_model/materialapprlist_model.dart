class Materialapprlist{
  int? materialid;
  int? reqDetId;
  String? tranfromprjid;
  String? materialname;
  String? tranfromprjname;
  String? scale;
  double? balqty;
  double? appqty;
  double? reqqty;
  String? apptype;
  String? remarks;
  String? desc;
  int? scaleId;


  Materialapprlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['materialid'] = materialid != null ? materialid : null;
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['tranfromprjid'] = tranfromprjid != null ? tranfromprjid : null;
    mapping['materialname'] = materialname != null ? materialname : null;
    mapping['tranfromprjname'] = tranfromprjname != null ? tranfromprjname : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['scaleId'] = scaleId != null ? scaleId : null;
    mapping['balqty'] = balqty != null ? balqty : null;
    mapping['appqty'] = appqty != null ? appqty : null;
    mapping['reqqty'] = reqqty != null ? reqqty : null;
    mapping['apptype'] = apptype != null ? apptype : null;
    mapping['remarks'] = remarks != null ? remarks : null;
    mapping['desc'] = desc != null ? desc : null;
    return mapping;
  }
}