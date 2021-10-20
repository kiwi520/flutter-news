/// code : "450000198012237321"
/// title : "多彩校园"

class CategoryResponseEntity {
  CategoryResponseEntity({
      String? code,
      String? title,}){
    _code = code;
    _title = title;
}

  CategoryResponseEntity.fromJson(dynamic json) {
    _code = json['code'];
    _title = json['title'];
  }
  String? _code;
  String? _title;

  String? get code => _code;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['title'] = _title;
    return map;
  }

}