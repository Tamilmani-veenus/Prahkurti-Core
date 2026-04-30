class TransferBetItemListTableModel{
  int? id;
  int? materialId;
  String? materialName;
  String? scale;
  double? stockQty;
  double? Qty;
  double? balQty;
  int? reqDetId;
  int? transReqDetId;
  int? reqMasDetId;
  int? scaleId;
  double? rate;
  double? amount;

  TransferBetItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id != null ? id : null;
    mapping['materialId'] = materialId != null ? materialId : null;
    mapping['materialName'] = materialName != null ? materialName : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['stockQty'] = stockQty != null ? stockQty : null;
    mapping['Qty'] = Qty != null ? Qty : null;
    mapping['balQty'] = balQty != null ? balQty : null;
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['transReqDetId'] = transReqDetId != null ? transReqDetId : null;
    mapping['reqMasDetId'] = reqMasDetId != null ? reqMasDetId : null;
    mapping['scaleId'] = scaleId != null ? scaleId : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['amount'] = amount != null ? amount : null;
    return mapping;
  }
}