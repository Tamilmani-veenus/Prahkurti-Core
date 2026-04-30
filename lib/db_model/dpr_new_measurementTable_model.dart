class DprNew_MeasurementTable{
  int? id;
  String? Name;
  String? nos;
  double? length;
  double? breath;
  double? depth;
  double? qty;

  DprNew_MeasurementMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id != null ? id : null;
    mapping['Name'] = Name != null ? Name : null;
    mapping['nos'] = nos != null ? nos : null;
    mapping['length'] = length != null ? length : null;
    mapping['breath'] = breath != null ? breath : null;
    mapping['depth'] = depth != null ? depth : null;
    mapping['qty'] = qty != null ? qty : null;
    return mapping;
  }
}