import 'dart:convert';

LabrAttenResponse labrAttenResponseFromJson(String str) => LabrAttenResponse.fromJson(json.decode(str));
String labrAttenResponseToJson(LabrAttenResponse data) => json.encode(data.toJson());
class LabrAttenResponse {
  LabrAttenResponse({
      String? retString,}){
    _retString = retString;
}

  LabrAttenResponse.fromJson(dynamic json) {
    _retString = json['RetString'];
  }
  String? _retString;
LabrAttenResponse copyWith({  String? retString,
}) => LabrAttenResponse(  retString: retString ?? _retString,
);
  String? get retString => _retString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RetString'] = _retString;
    return map;
  }

}