class MatTransDetItemListTableModel{
  int? reqDetId;
  int? materialId;
  String? materialName;
  String? scale;
  double? stockQty;
  double? Qty;
  String? detRemarks;


  MatTransDetItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['materialId'] = materialId != null ? materialId : null;
    mapping['materialName'] = materialName != null ? materialName : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['stockQty'] = stockQty != null ? stockQty : null;
    mapping['Qty'] = Qty != null ? Qty : null;
    mapping['detRemarks'] = detRemarks != null ? detRemarks : null;
    return mapping;
  }
}