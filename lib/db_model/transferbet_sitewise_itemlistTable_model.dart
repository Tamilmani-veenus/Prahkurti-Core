class TransferBet_Site_ItemListTableModel{
  int? id;
  int? materialId;
  int? StSDetId;
  String? materialName;
  String? scale;
  double? stockQty;
  double? Qty;
  double? balQty;
  int? reqDetId;
  double? rate;
  double? amount;

  TransferBet_Site_ItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id != null ? id : null;
    mapping['materialId'] = materialId != null ? materialId : null;
    mapping['StSDetId'] = StSDetId != null ? StSDetId : null;
    mapping['materialName'] = materialName != null ? materialName : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['stockQty'] = stockQty != null ? stockQty : null;
    mapping['Qty'] = Qty != null ? Qty : null;
    mapping['balQty'] = balQty != null ? balQty : null;
    mapping['reqDetId'] = reqDetId != null ? reqDetId : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['amount'] = amount != null ? amount : null;
    return mapping;
  }
}