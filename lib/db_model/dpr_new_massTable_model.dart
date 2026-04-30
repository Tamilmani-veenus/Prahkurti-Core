class DprNew_MassModel {
  // int? Id;
  String? autoNo;
  String? Date;
  int? projectId;
  String? projectName;
  int? siteId;
  String? siteName;
  String? entryType;
  int? subContId;
  String? subContName;
  String? refNo;
  String? preparedby;
  String? remarks;

  DprNew_MassMap() {
    var mapping = Map<String, dynamic>();
    // mapping['Id'] = Id ?? null;
    mapping['autoNo'] = autoNo != null ? autoNo : null;
    mapping['date'] = Date != null ? Date : null;
    mapping['projectId'] = projectId != null ? projectId : 0.0;
    mapping['projectName'] = projectName != null ? projectName : null;
    mapping['sitetId'] = siteId != null ? siteId : 0.0;
    mapping['sitetName'] = siteName != null ? siteName : null;
    mapping['entryType'] = entryType != null ? entryType : null;
    mapping['subcontId'] = subContId != null ? subContId : 0;
    mapping['subcontName'] = subContName != null ? subContName : null;
    mapping['refNo'] = refNo != null ? refNo : null;
    mapping['prepBy'] = preparedby != null ? preparedby : null;
    mapping['remarks'] = remarks != null ? remarks : null;
    return mapping;
  }
}