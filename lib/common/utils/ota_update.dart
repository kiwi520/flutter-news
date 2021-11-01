import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/api/app.dart';
import 'package:news_app/common/entity/entities.dart';
import 'package:news_app/common/widgets/toast.dart';
import 'package:news_app/global.dart';
import 'package:ota_update/ota_update.dart';
import 'package:path_provider/path_provider.dart';

/// app 升级
class AppUpdateUtil {
  static final AppUpdateUtil _instance = AppUpdateUtil._internal();
  factory AppUpdateUtil() => _instance;

  static late BuildContext _context;
  static late AppUpdateResponseEntity _appUpdateInfo;

  AppUpdateUtil._internal();

  /// 获取更新信息
  Future run(BuildContext context) async {
    _context = context;

    print('sdsdsdd');
    print('sdsdsdd');
    print('sdsdsdd');

    // 提交 设备类型、发行渠道、架构、机型
    AppUpdateRequestEntity requestDeviceInfo = AppUpdateRequestEntity(
      device: Global.isIOS == true ? "ios" : "android",
      channel: Global.channel,
      architecture: Global.isIOS == true
          ? Global.iosDeviceInfo!.utsname.machine
          : Global.androidDeviceInfo!.device,
      model: Global.isIOS == true
          ? Global.iosDeviceInfo!.name
          : Global.androidDeviceInfo!.brand,
    );
    _appUpdateInfo =
    await AppApi.update(context: context, params: requestDeviceInfo);

    print('_appUpdateInfo');
    print(_appUpdateInfo);
    print('_appUpdateInfo');
    _runAppUpdate();
  }

  /// 检查是否有新版
  Future _runAppUpdate() async {
    print('Global.packageInfo!.version');
    print(Global.packageInfo!.version);
    print('Global.packageInfo!.version');

    print('Global.packageInfo!.version');
    print(Global.packageInfo!.version);
    print('Global.packageInfo!.version');

    // 比较版本
    // final isNewVersion = (_appUpdateInfo.latestVersion!.compareTo(Global.packageInfo!.version) == 1);
    bool isNewVersion = false;
    if (_appUpdateInfo.latestVersion == null ||  Global.packageInfo!.version == null) {
      isNewVersion = false;
    }else{
       if(double.parse(_appUpdateInfo.latestVersion!) > double.parse(Global.packageInfo!.version)) {
         isNewVersion = true;
       }
    };

    // 安装
    if (isNewVersion == true) {
      _appUpdateConformDialog(() {
        Navigator.of(_context).pop();
        if (Global.isIOS == true) {
          // 去苹果店
          print('苹果');
          print('苹果');
          print('苹果');
          // InstallPlugin.gotoAppStore(_appUpdateInfo.shopUrl);
        } else {
          // apk 下载安装
          toastInfo(msg: "开始下载升级包");
          _downloadAPKAndSetup(_appUpdateInfo.fileUrl!);
        }
      });
    }else{
        print('没有可升级的新版本');
    }
  }

  /// 下载文件 & 安装
  Future _downloadAPKAndSetup(String fileUrl) async {
    // 下载
    Directory? externalDir = await getExternalStorageDirectory();
    String fullPath = externalDir!.path + "/release.apk";

    Dio dio = Dio(BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        }));
    Response response = await dio.get(
      fileUrl,
    );

    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    // 安装
    // await InstallPlugin.installApk(fullPath, Global.packageInfo!.packageName);

    // RUN OTA UPDATE
    // START LISTENING FOR DOWNLOAD PROGRESS REPORTING EVENTS
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
     await OtaUpdate()
          .execute(
        'https://internal1.4q.sk/flutter_hello_world.apk',
        // OPTIONAL
        destinationFilename: 'flutter_hello_world.apk',
        //OPTIONAL, ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
        sha256checksum: "d6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478",
      ).listen(
            (OtaEvent event) {
          // setState(() => currentEvent = event);
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }

  /// 升级确认对话框
  void _appUpdateConformDialog(VoidCallback onPressed) {
    EasyDialog(
        title: Text(
          "发现新版本 ${_appUpdateInfo.latestVersion}",
          style: TextStyle(fontWeight: FontWeight.bold),
          textScaleFactor: 1.2,
        ),
        description: Text(
          _appUpdateInfo.latestDescription!,
          textScaleFactor: 1.1,
          textAlign: TextAlign.center,
        ),
        height: 220,
        contentList: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new FlatButton(
                padding: const EdgeInsets.only(top: 8.0),
                textColor: Colors.lightBlue,
                onPressed: onPressed,
                child: new Text(
                  "同意",
                  textScaleFactor: 1.2,
                ),
              ),
              new FlatButton(
                padding: const EdgeInsets.only(top: 8.0),
                textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(_context).pop();
                },
                child: new Text(
                  "取消",
                  textScaleFactor: 1.2,
                ),
              ),
            ],
          )
        ]).show(_context);
  }
}
