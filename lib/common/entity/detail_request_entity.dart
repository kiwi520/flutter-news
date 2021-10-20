/// cid : "1"

class DetailRequestEntity {
  DetailRequestEntity({
      String? cid,}){
    _cid = cid;
}

  DetailRequestEntity.fromJson(dynamic json) {
    _cid = json['cid'];
  }
  String? _cid;

  String? get cid => _cid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cid'] = _cid;
    return map;
  }

}