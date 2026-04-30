class InwardPendingItemListTableModel{
  int? id;
  int? poDetId;
  int? materialId;
  int? scaleId;
  String? materialName;
  String? unit;
  double? poQty;
  double? balQty;
  double? rate;
  double? inwQty;
  double? addQty;
  double? lessQty;
  int? amdCheck;

  InwardPendingItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id != null ? id : null;
    mapping['poDetId'] = poDetId != null ? poDetId : null;
    mapping['materialId'] = materialId != null ? materialId : null;
    mapping['materialName'] = materialName != null ? materialName : null;
    mapping['scaleId'] = scaleId != null ? scaleId : null;
    mapping['unit'] = unit != null ? unit : null;
    mapping['poQty'] = poQty != null ? poQty : null;
    mapping['balQty'] = balQty != null ? balQty : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['inwQty'] = inwQty != null ? inwQty : null;
    mapping['addQty'] = addQty != null ? addQty : null;
    mapping['lessQty'] = lessQty != null ? lessQty : null;
    mapping['amdCheck'] = amdCheck != null ? amdCheck : null;
    return mapping;
  }
}