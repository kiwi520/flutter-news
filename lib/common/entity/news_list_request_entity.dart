/// categoryCode : ""
/// channelCode : ""
/// tag : ""
/// keyword : ""

class NewsPageListRequestEntity {
  NewsPageListRequestEntity({
      String? categoryCode, 
      String? channelCode, 
      String? tag, 
      String? keyword,}){
    _categoryCode = categoryCode;
    _channelCode = channelCode;
    _tag = tag;
    _keyword = keyword;
}

  NewsPageListRequestEntity.fromJson(dynamic json) {
    _categoryCode = json['categoryCode'];
    _channelCode = json['channelCode'];
    _tag = json['tag'];
    _keyword = json['keyword'];
  }
  String? _categoryCode;
  String? _channelCode;
  String? _tag;
  String? _keyword;

  String? get categoryCode => _categoryCode;
  String? get channelCode => _channelCode;
  String? get tag => _tag;
  String? get keyword => _keyword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryCode'] = _categoryCode;
    map['channelCode'] = _channelCode;
    map['tag'] = _tag;
    map['keyword'] = _keyword;
    return map;
  }

}