class DprNew_MaterialTable{
  // int? Id;
   int? MatId;
  String? Name;
  String? Scale;
  double? qty;

  DprNew_MaterialTableMap() {
    var mapping = Map<String, dynamic>();
    // mapping['Id'] = Id != null ? Id : null;
    mapping['MatId'] = MatId != null ? MatId : null;
    mapping['Name'] = Name != null ? Name : null;
    mapping['Scale'] = Scale != null ? Scale : null;
    mapping['Qty'] = qty != null ? qty : null;
    return mapping;
  }
}