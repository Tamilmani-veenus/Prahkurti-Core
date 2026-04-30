import 'dart:convert';

SiteVocImageDelete siteVocImageDeleteFromJson(String str) => SiteVocImageDelete.fromJson(json.decode(str));
String siteVocImageDeleteToJson(SiteVocImageDelete data) => json.encode(data.toJson());
class SiteVocImageDelete {
  SiteVocImageDelete({
      String? message,}){
    _message = message;
}

  SiteVocImageDelete.fromJson(dynamic json) {
    _message = json['Message'];
  }
  String? _message;
SiteVocImageDelete copyWith({  String? message,
}) => SiteVocImageDelete(  message: message ?? _message,
);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = _message;
    return map;
  }

}