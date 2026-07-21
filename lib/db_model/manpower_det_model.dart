class ManPowerDetModel{
  int? reqDetId;
  int? catId;
  String? catName;
  String? nos;
  String? remarks;


  ManPowerDetMap() {
    var mapping = Map<String, dynamic>();
    mapping['reqDetId'] = reqDetId != null ? reqDetId : 0;
    mapping['catId'] = catId != null ? catId : null;
    mapping['catName'] = catName != null ? catName : null;
    mapping['nos'] = nos != null ? nos : null;
    mapping['remarks'] = remarks != null ? remarks : "-";
    return mapping;
  }
}