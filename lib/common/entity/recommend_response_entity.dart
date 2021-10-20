/// thumbnail : "http://news.swust.edu.cn/_upload/article/images/b2/ca/83969d28487ba81c06fbf4b0ec4e/30950301-3831-4353-a54b-019ef7774b0c.jpg"
/// title : "邓子新院士应邀来校作学术报告"
/// category : "科大人物"
/// addtime : "2021-04-06"
/// author : "肖寒"
/// url : "http://news.swust.edu.cn/2021/0729/c294a138045/page.htm"
/// id : "430000201511090126"

class NewsRecommendResponseEntity {
  NewsRecommendResponseEntity({
      String? thumbnail, 
      String? title, 
      String? category, 
      String? addtime, 
      String? author, 
      String? url, 
      String? id,}){
    _thumbnail = thumbnail;
    _title = title;
    _category = category;
    _addtime = addtime;
    _author = author;
    _url = url;
    _id = id;
}

  NewsRecommendResponseEntity.fromJson(dynamic json) {
    _thumbnail = json['thumbnail'];
    _title = json['title'];
    _category = json['category'];
    _addtime = json['addtime'];
    _author = json['author'];
    _url = json['url'];
    _id = json['id'];
  }
  String? _thumbnail;
  String? _title;
  String? _category;
  String? _addtime;
  String? _author;
  String? _url;
  String? _id;

  String? get thumbnail => _thumbnail;
  String? get title => _title;
  String? get category => _category;
  String? get addtime => _addtime;
  String? get author => _author;
  String? get url => _url;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['thumbnail'] = _thumbnail;
    map['title'] = _title;
    map['category'] = _category;
    map['addtime'] = _addtime;
    map['author'] = _author;
    map['url'] = _url;
    map['id'] = _id;
    return map;
  }

}