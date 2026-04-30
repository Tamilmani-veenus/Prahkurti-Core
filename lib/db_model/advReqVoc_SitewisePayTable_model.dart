class AdvReqVoucher_SiteWisePayment_TableModel{
  int? purOrdMasId;
  String? orderNo;
  String? project;
  int? projectId;
  String? siteName;
  String? paymentType;
  int? siteId;
  double? dprAmt;
  double? advanceAmt;
  double? bAmount;
  double? amount;

  AdvReqVoucher_SiteWisePayment_TableMap() {
    var mapping = Map<String, dynamic>();
    mapping['PurOrdMasId'] = purOrdMasId != null ? purOrdMasId : null;
    mapping['OrderNo'] = orderNo != null ? orderNo : null;
    mapping['Project'] = project != null ? project : null;
    mapping['ProjectId'] = projectId != null ? projectId : null;
    mapping['SiteName'] = siteName != null ? siteName : null;
    mapping['paymentType'] = paymentType != null ? paymentType : null;
    mapping['SiteId'] = siteId != null ? siteId : null;
    mapping['DPRAmt'] = dprAmt != null ? dprAmt : null;
    mapping['AdvanceAmt'] = advanceAmt != null ? advanceAmt : null;
    mapping['BAmount'] = bAmount != null ? bAmount : null;
    mapping['Amount'] = amount != null ? amount : null;
    return mapping;
  }
}