/// categoryCode : ""
/// channelCode : ""
/// tag : ""
/// keyword : ""
/// newsID : ""

class TagRequestEntity {
  TagRequestEntity({
      String? categoryCode, 
      String? channelCode, 
      String? tag, 
      String? keyword, 
      String? newsID,}){
    _categoryCode = categoryCode;
    _channelCode = channelCode;
    _tag = tag;
    _keyword = keyword;
    _newsID = newsID;
}

  TagRequestEntity.fromJson(dynamic json) {
    _categoryCode = json['categoryCode'];
    _channelCode = json['channelCode'];
    _tag = json['tag'];
    _keyword = json['keyword'];
    _newsID = json['newsID'];
  }
  String? _categoryCode;
  String? _channelCode;
  String? _tag;
  String? _keyword;
  String? _newsID;

  String? get categoryCode => _categoryCode;
  String? get channelCode => _channelCode;
  String? get tag => _tag;
  String? get keyword => _keyword;
  String? get newsID => _newsID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryCode'] = _categoryCode;
    map['channelCode'] = _channelCode;
    map['tag'] = _tag;
    map['keyword'] = _keyword;
    map['newsID'] = _newsID;
    return map;
  }

}