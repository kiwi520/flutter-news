import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/common/entity/user_login_response_entity.dart';
import 'package:news_app/common/utils/http.dart';
import 'package:news_app/common/utils/storage.dart';
import 'package:news_app/common/values/storage.dart';

/// 全局配置
class Global {
  /// 用户配置
  static UserLoginResponseEntity profile = UserLoginResponseEntity(
    accessToken: null,
  );

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始
    StorageUtil.getInstance();
    HttpUtil();

    // // // 读取离线用户信息
    // var _profileJSON = StorageUtil.getMap(STORAGE_USER_PROFILE_KEY);
    // if (_profileJSON != null) {
    //   profile = UserLoginResponseEntity.fromJson(_profileJSON);
    // }

    // http 缓存

    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(UserLoginResponseEntity userResponse) async {
    profile = userResponse;
    print('profile');
    print(profile);
    print(profile.displayName);
    print(profile.accessToken);
    print(profile.channels);
    print('profile');
    return await StorageUtil
        .setMap(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }
}