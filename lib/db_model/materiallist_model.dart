class Materiallist{
  int? reqDetId;
  int? materialid;
  String? material;
  String? scale;
  double? qty;
  double? balqty;
  double? stockqty;
  String? remarks;
  String? desc;
  int? scaleId;


  Materiallistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['materialid'] = materialid != null ? materialid : null;
    mapping['material'] = material != null ? material : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['balqty'] = balqty != null ? balqty : null;
    mapping['stockqty'] = stockqty != null ? stockqty : null;
    mapping['remarks'] = remarks != null ? remarks : null;
    mapping['desc'] = desc != null ? desc : null;
    mapping['scaleId'] = scaleId != null ? scaleId : null;
    return mapping;
  }
}