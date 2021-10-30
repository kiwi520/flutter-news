import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/providers/app_provider.dart';
import 'package:news_app/common/providers/application_provider.dart';
import 'package:news_app/common/utils/authentication.dart';
import 'package:news_app/global.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppProvider,ApplicationProvider>(
        builder: (context,app,tab,child){
          return Column(
            children: <Widget>[
              Text('用户: ${Global.profile.displayName}'),
              Divider(),
              MaterialButton(
                onPressed: () {
                   // tab.currentIndexPage = 0;
                   tab.handleNavBarTap = 0;
                  goLoginPage(context);
                },
                child: Text('退出'),
              ),
              Divider(),
              MaterialButton(
                onPressed: () {
                  app.switchGrayFilter();
                },
                child: Text('灰色切换 ${app.isGrayFilter}'),
              ),
            ],
          );
        });
  }
}
