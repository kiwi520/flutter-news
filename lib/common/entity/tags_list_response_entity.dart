/// tag : "LED"

class TagResponseEntity {
  TagResponseEntity({
      String? tag,}){
    _tag = tag;
}

  TagResponseEntity.fromJson(dynamic json) {
    _tag = json['tag'];
  }
  String? _tag;

  String? get tag => _tag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tag'] = _tag;
    return map;
  }

}