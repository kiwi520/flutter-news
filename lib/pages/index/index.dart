import 'package:flutter/material.dart';
import 'package:news_app/global.dart';
import 'package:news_app/pages/application/application.dart';
import 'package:news_app/pages/sign_in/sign_in.dart';
import 'package:news_app/pages/welcome/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {



    // ScreenUtil.init(
    //   context,
    //   width: 375,
    //   height: 812 - 44 - 34,
    //   allowFontScaling: true,
    // );

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812 - 44 - 34),
        orientation: Orientation.portrait);

    return Scaffold(
      body: Global.isFirstOpen == true
          ? WelcomePage()
          : Global.isOfflineLogin == true ? ApplicationPage() : SignInPage(),
    );
  }
}