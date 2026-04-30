class TransferAckDetTableModel{
  // int? id;
  int? transferDetId;
  int? materialId;
  String? materialName;
  String? scale;
  double? transQty;
  double? ackQty;
  String? detRemarks;

  TransferAckDetTableMap() {
    var mapping = Map<String, dynamic>();
    // mapping['id'] = id != null ? id : null;
    mapping['transferDetId'] = transferDetId != null ? transferDetId : null;
    mapping['materialId'] = materialId != null ? materialId : null;
    mapping['materialName'] = materialName != null ? materialName : null;
    mapping['scale'] = scale != null ? scale : null;
    mapping['transQty'] = transQty != null ? transQty : null;
    mapping['ackQty'] = ackQty != null ? ackQty : null;
    mapping['detRemarks'] = detRemarks != null ? detRemarks : null;
    return mapping;
  }
}