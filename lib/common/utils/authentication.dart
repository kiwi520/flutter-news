import 'dart:async';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/entity/user_login_response_entity.dart';
import 'package:news_app/common/router/router.gr.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/global.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = StorageUtil.getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

/// 删除缓存 token
Future deleteAuthentication() async {
  await StorageUtil.remove(STORAGE_USER_PROFILE_KEY);
  Global.profile = UserLoginResponseEntity();
}

/// 重新登录
Future goLoginPage(BuildContext context) async {
  await deleteAuthentication();

  context.router.replaceAll([
    SingIn()
  ]);
  // context.router.pushNamed('/sign-in-page');

  // Navigator.pushNamedAndRemoveUntil(
  //     context, "/sign-in", (Route<dynamic> route) => false);
}