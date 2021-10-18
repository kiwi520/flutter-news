import 'package:news_app/common/entity/user_login_request_entity.dart';
import 'package:news_app/common/entity/user_login_response_entity.dart';
import 'package:news_app/common/utils/http.dart';


class UserAPI{
  /// 登录
  static Future<UserLoginResponseEntity> login({UserLoginRequestEntity? params}) async {
    var response = await HttpUtil().post('/user/login', params: params);
    return UserLoginResponseEntity.fromJson(response);
  }
}