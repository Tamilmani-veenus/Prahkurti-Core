class ConsumptionItemlist{
  int? materialid;
  int? reqDetId;
  String? material;
  String? scale;
  int? scaleId;
  double? Stockqty;
  double? Usageqty;

  ConsumItemlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['materialid'] = materialid != null ? materialid : null;
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
      mapping['material'] = material != null ? material : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['scaleId'] = scaleId != null ? scaleId : null;
    mapping['stockqty'] = Stockqty != null ? Stockqty : null;
    mapping['usageqty'] = Usageqty != null ? Usageqty : null;
    return mapping;
  }
}