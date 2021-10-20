/// categoryCode : "abc"
/// tag : "abc"
/// channelCode : "abc"
/// keyword : "abc"

class NewsRecommendRequestEntity {
  NewsRecommendRequestEntity({
      String? categoryCode, 
      String? tag, 
      String? channelCode, 
      String? keyword,}){
    _categoryCode = categoryCode;
    _tag = tag;
    _channelCode = channelCode;
    _keyword = keyword;
}

  NewsRecommendRequestEntity.fromJson(dynamic json) {
    _categoryCode = json['categoryCode'];
    _tag = json['tag'];
    _channelCode = json['channelCode'];
    _keyword = json['keyword'];
  }
  String? _categoryCode;
  String? _tag;
  String? _channelCode;
  String? _keyword;

  String? get categoryCode => _categoryCode;
  String? get tag => _tag;
  String? get channelCode => _channelCode;
  String? get keyword => _keyword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryCode'] = _categoryCode;
    map['tag'] = _tag;
    map['channelCode'] = _channelCode;
    map['keyword'] = _keyword;
    return map;
  }

}