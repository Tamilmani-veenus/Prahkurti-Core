class BoqItemlist{
  int? HdNme_Id;
  int? SbNme_Id;
  int? Level3item_id;
  String? itemdesc;
  String? Unit;
  double? Rate;
  double? Qty;
  double? Amt;

  BoqItemlistmodelmap(){
    var mapping = Map<String, dynamic>();
    mapping['HdNme_Id'] = HdNme_Id != null ? HdNme_Id : null;
    mapping['SbNme_Id'] = SbNme_Id != null ? SbNme_Id : null;
    mapping['Level3item_id'] = Level3item_id != null ? Level3item_id : null;
    mapping['itemdesc'] = itemdesc != null ? itemdesc : null;
    mapping['Unit'] = Unit != null ? Unit : null;
    mapping['Rate'] = Rate != null ? Rate : null;
    mapping['Qty'] = Qty != null ? Qty : null;
    mapping['Amt'] = Amt != null ? Amt : null;
    return mapping;
  }
}