/// name : "江洋"

class TestEntity {
  TestEntity({
      String? name,}){
    _name = name;
}

  TestEntity.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}