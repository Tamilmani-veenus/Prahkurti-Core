import 'dart:convert';
/// GetStockReport : [{"projectName":"M/S KPR DEVELOPERS LIMITED","StockRepDetails":[{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":5.000,"Footer":"ORD 12' PROPS"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":7.000,"Footer":"DOUBLE STAGE 16' PROPS"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":5.000,"Footer":"STEEL PLYWOOD FRAME SIDE 8X1.5"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":1.000,"Footer":"STEEL LADER 10"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":153.000,"Footer":"CROSS BAR"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":122.000,"Footer":"H-FRAME"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":16.000,"Footer":"20 PIPE"}]},{"projectName":"MRS.SARAYU CHANDRASEKAR","StockRepDetails":[{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":90.000,"Footer":"ORD 12' PROPS"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":30.000,"Footer":"DOUBLE STAGE 16' PROPS"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":15.000,"Footer":"SPAN"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":60.000,"Footer":"GPS 2.00MM"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":105.000,"Footer":"BEAM SIDE 300MM"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":320.000,"Footer":"BEAM BOTTOM 230MM"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":75.000,"Footer":"BEAM BOTTOM 300MM"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":5.000,"Footer":"STEEL PLYWOOD FRAME SIDE 8X1.5"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":225.000,"Footer":"CROSS BAR"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":170.000,"Footer":"H-FRAME"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":10.000,"Footer":"HOIST CROSS BAR"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":16.000,"Footer":"HOIST H-FRAME"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":155.000,"Footer":"20 PIPE"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":20.000,"Footer":"SEWEL COUPLER"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":50.000,"Footer":"C.SHEET"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":140.000,"Footer":"ADJ.C.SHEET 330MM"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":220.000,"Footer":"ADJ.C.SHEET 450MM"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":15.000,"Footer":"STEEL PLATFORM"},{"Material_Head":"CIVIL MATERIALS","Unit":"BAG","Stock_Qty":83.000,"Footer":"CEMENT OPC"}]}]

GetstockprojwiseModel getstockprojwiseModelFromJson(String str) => GetstockprojwiseModel.fromJson(json.decode(str));
String getstockprojwiseModelToJson(GetstockprojwiseModel data) => json.encode(data.toJson());
class GetstockprojwiseModel {
  GetstockprojwiseModel({
      List<GetStockReport>? getStockReport,}){
    _getStockReport = getStockReport;
}

  GetstockprojwiseModel.fromJson(dynamic json) {
    if (json['GetStockReport'] != null) {
      _getStockReport = [];
      json['GetStockReport'].forEach((v) {
        _getStockReport?.add(GetStockReport.fromJson(v));
      });
    }
  }
  List<GetStockReport>? _getStockReport;
GetstockprojwiseModel copyWith({  List<GetStockReport>? getStockReport,
}) => GetstockprojwiseModel(  getStockReport: getStockReport ?? _getStockReport,
);
  List<GetStockReport>? get getStockReport => _getStockReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_getStockReport != null) {
      map['GetStockReport'] = _getStockReport?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// projectName : "M/S KPR DEVELOPERS LIMITED"
/// StockRepDetails : [{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":5.000,"Footer":"ORD 12' PROPS"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":7.000,"Footer":"DOUBLE STAGE 16' PROPS"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":5.000,"Footer":"STEEL PLYWOOD FRAME SIDE 8X1.5"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":1.000,"Footer":"STEEL LADER 10"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":153.000,"Footer":"CROSS BAR"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":122.000,"Footer":"H-FRAME"},{"Material_Head":"VCPL CENTERING MATERIALS","Unit":"NOS","Stock_Qty":16.000,"Footer":"20 PIPE"}]

GetStockReport getStockReportFromJson(String str) => GetStockReport.fromJson(json.decode(str));
String getStockReportToJson(GetStockReport data) => json.encode(data.toJson());
class GetStockReport {
  GetStockReport({
      String? projectName, 
      List<StockRepDetails>? stockRepDetails,}){
    _projectName = projectName;
    _stockRepDetails = stockRepDetails;
}

  GetStockReport.fromJson(dynamic json) {
    _projectName = json['projectName'];
    if (json['StockRepDetails'] != null) {
      _stockRepDetails = [];
      json['StockRepDetails'].forEach((v) {
        _stockRepDetails?.add(StockRepDetails.fromJson(v));
      });
    }
  }
  String? _projectName;
  List<StockRepDetails>? _stockRepDetails;
GetStockReport copyWith({  String? projectName,
  List<StockRepDetails>? stockRepDetails,
}) => GetStockReport(  projectName: projectName ?? _projectName,
  stockRepDetails: stockRepDetails ?? _stockRepDetails,
);
  String? get projectName => _projectName;
  List<StockRepDetails>? get stockRepDetails => _stockRepDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['projectName'] = _projectName;
    if (_stockRepDetails != null) {
      map['StockRepDetails'] = _stockRepDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Material_Head : "VCPL CENTERING MATERIALS"
/// Unit : "NOS"
/// Stock_Qty : 5.000
/// Footer : "ORD 12' PROPS"

StockRepDetails stockRepDetailsFromJson(String str) => StockRepDetails.fromJson(json.decode(str));
String stockRepDetailsToJson(StockRepDetails data) => json.encode(data.toJson());
class StockRepDetails {
  StockRepDetails({
      String? materialHead, 
      String? unit, 
      num? stockQty, 
      String? footer,}){
    _materialHead = materialHead;
    _unit = unit;
    _stockQty = stockQty;
    _footer = footer;
}

  StockRepDetails.fromJson(dynamic json) {
    _materialHead = json['Material_Head'];
    _unit = json['Unit'];
    _stockQty = json['Stock_Qty'];
    _footer = json['Footer'];
  }
  String? _materialHead;
  String? _unit;
  num? _stockQty;
  String? _footer;
StockRepDetails copyWith({  String? materialHead,
  String? unit,
  num? stockQty,
  String? footer,
}) => StockRepDetails(  materialHead: materialHead ?? _materialHead,
  unit: unit ?? _unit,
  stockQty: stockQty ?? _stockQty,
  footer: footer ?? _footer,
);
  String? get materialHead => _materialHead;
  String? get unit => _unit;
  num? get stockQty => _stockQty;
  String? get footer => _footer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Material_Head'] = _materialHead;
    map['Unit'] = _unit;
    map['Stock_Qty'] = _stockQty;
    map['Footer'] = _footer;
    return map;
  }

}