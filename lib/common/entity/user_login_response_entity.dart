/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.d1kHnyCBy0kn13mr2HtXRDaX1aXv6fizP0GKcD7vlR0"
/// display_name : "est amet"
/// channels : ["voluptate laboris officia","voluptate ipsum eiusmod ullamco quis","elit ad do"]

class UserLoginResponseEntity {
  UserLoginResponseEntity({
      String? accessToken, 
      String? displayName, 
      List<String>? channels,}){
    _accessToken = accessToken;
    _displayName = displayName;
    _channels = channels;
}

  UserLoginResponseEntity.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _displayName = json['display_name'];
    _channels = json['channels'] != null ? json['channels'].cast<String>() : [];
  }
  String? _accessToken;
  String? _displayName;
  List<String>? _channels;

  String? get accessToken => _accessToken;
  String? get displayName => _displayName;
  List<String>? get channels => _channels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['display_name'] = _displayName;
    map['channels'] = _channels;
    return map;
  }

}