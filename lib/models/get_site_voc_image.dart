import 'dart:convert';

GetSiteVocImage getSiteVocImageFromJson(String str) => GetSiteVocImage.fromJson(json.decode(str));
String getSiteVocImageToJson(GetSiteVocImage data) => json.encode(data.toJson());
class GetSiteVocImage {
  GetSiteVocImage({
      List<ImageView>? imageView,}){
    _imageView = imageView;
}

  GetSiteVocImage.fromJson(dynamic json) {
    if (json['ImageView'] != null) {
      _imageView = [];
      json['ImageView'].forEach((v) {
        _imageView?.add(ImageView.fromJson(v));
      });
    }
  }
  List<ImageView>? _imageView;
GetSiteVocImage copyWith({  List<ImageView>? imageView,
}) => GetSiteVocImage(  imageView: imageView ?? _imageView,
);
  List<ImageView>? get imageView => _imageView;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_imageView != null) {
      map['ImageView'] = _imageView?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

ImageView imageViewFromJson(String str) => ImageView.fromJson(json.decode(str));
String imageViewToJson(ImageView data) => json.encode(data.toJson());
class ImageView {
  ImageView({
      num? imageId, 
      String? imageUrl, 
      num? vocId,}){
    _imageId = imageId;
    _imageUrl = imageUrl;
    _vocId = vocId;
}

  ImageView.fromJson(dynamic json) {
    _imageId = json['ImageId'];
    _imageUrl = json['ImageUrl'];
    _vocId = json['voc_id'];
  }
  num? _imageId;
  String? _imageUrl;
  num? _vocId;
ImageView copyWith({  num? imageId,
  String? imageUrl,
  num? vocId,
}) => ImageView(  imageId: imageId ?? _imageId,
  imageUrl: imageUrl ?? _imageUrl,
  vocId: vocId ?? _vocId,
);
  num? get imageId => _imageId;
  String? get imageUrl => _imageUrl;
  num? get vocId => _vocId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ImageId'] = _imageId;
    map['ImageUrl'] = _imageUrl;
    map['voc_id'] = _vocId;
    return map;
  }

}