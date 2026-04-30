class DirectBillGenItemListTableModel{
  int? Id;
  String? Name;
  String? unit;
  double? qty;
  double? rate;
  double? amount;

  DirectBillGenItemListTableMap() {
    var mapping = Map<String, dynamic>();
     mapping['id'] = Id != null ? Id : null;
    mapping['Name'] = Name != null ? Name : null;
    mapping['unit'] = unit != null ? unit : null;
    mapping['qty'] = qty != null ? qty : null;
    mapping['rate'] = rate != null ? rate : null;
    mapping['amount'] = amount != null ? amount : null;
    return mapping;
  }
}