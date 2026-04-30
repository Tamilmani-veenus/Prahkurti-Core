class AdvReqVoucherItemListTableModel{
  int? id;
  int? siteId;
  String? siteName;
  String? paymentType;
  double? amount;
  double? tds_percent;
  double? tds_amount;
  double? netAmount;

   AdvReqVoucherItemListTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id != null ? id : null;
    mapping['siteId'] = siteId != null ? siteId : null;
    mapping['siteName'] = siteName != null ? siteName : null;
    mapping['paymentType'] = paymentType != null ? paymentType : null;
    mapping['amount'] = amount != null ? amount : null;
    mapping['tds_percent'] = tds_percent != null ? tds_percent : null;
    mapping['tds_amount'] = tds_amount != null ? tds_amount : null;
    mapping['netAmount'] = netAmount != null ? netAmount : null;
    return mapping;
  }
}