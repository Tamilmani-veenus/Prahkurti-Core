class DprNew_MaterialTable{
  int? reqDetId;
   int? MatId;
  String? Name;
  String? Scale;
  double? qty;
  int? scaleId;

  DprNew_MaterialTableMap() {
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : 0;
    mapping['MatId'] = MatId != null ? MatId : 0;
    mapping['Name'] = Name != null ? Name : "";
    mapping['Scale'] = Scale != null ? Scale : "";
    mapping['Qty'] = qty != null ? qty : 0.0;
    mapping['scaleId'] = scaleId != null ? scaleId : 0;
    return mapping;
  }
}