/// email : "sdsdfs"
/// password : "est amet"

class UserLoginRequestEntity {
  UserLoginRequestEntity({
      String? email, 
      String? password,}){
    _email = email;
    _password = password;
}

  UserLoginRequestEntity.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
  }
  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }

}