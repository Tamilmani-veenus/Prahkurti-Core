import 'dart:convert';

MrnSaveResponse mrnSaveResponseFromJson(String str) => MrnSaveResponse.fromJson(json.decode(str));
String mrnSaveResponseToJson(MrnSaveResponse data) => json.encode(data.toJson());
class MrnSaveResponse {
  MrnSaveResponse({
      String? retString,}){
    _retString = retString;
}

  MrnSaveResponse.fromJson(dynamic json) {
    _retString = json['RetString'];
  }
  String? _retString;
MrnSaveResponse copyWith({  String? retString,
}) => MrnSaveResponse(  retString: retString ?? _retString,
);
  String? get retString => _retString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RetString'] = _retString;
    return map;
  }

}