import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtil;
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //页面标题
  Widget _buildPageHeadTitle() {
    return Container(
        margin: EdgeInsets.only(top: duSetHeight(65)),
        child: Opacity(
          opacity: 1,
          child: Container(
            child: Text(
              "Features",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: duSetFontSize(24),
              ),
            ),
          ),
        ));
  }

  //页面说明
  Widget _buildPageHeadDetail() {
    return Opacity(
      opacity: 1,
      child: Container(
        width: duSetWidth(242),
        height: duSetHeight(70),
        margin: EdgeInsets.only(top: duSetHeight(14)),
        child: Text(
          "The best of news channels all in one place. Trusted sources and personalized news for you.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.normal,
              fontSize: duSetFontSize(16),
              height: 1.3),
        ),
      ),
    );
  }

  /// 特性说明
  Widget _buildPageHeadItem(String imageName, String intro, double top) {
    return Opacity(
      opacity: 1,
      child: Container(
          width: duSetWidth(295),
          height: duSetHeight(80),
          margin: EdgeInsets.only(top: duSetHeight(top)),
          child: Row(
            children: [
              Container(
                width: duSetWidth(80),
                height: duSetHeight(80),
                child: Image.asset(
                  "assets/images/$imageName.png",
                  fit: BoxFit.cover,
                ),
              ),
              Spacer(),
              Container(
                width: duSetWidth(195),
                child: Text(
                  intro,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.normal,
                      fontSize: duSetFontSize(16),
                      height: 1.375),
                ),
              )
            ],
          )),
    );
  }

  /// 按钮
  Widget _buildPageHeadButton() {
    return Container(
      width: duSetWidth(295),
      height: duSetHeight(44),
      margin: EdgeInsets.only(bottom: duSetHeight(55)),
      child: ElevatedButton(
        child: Text("Get started"),
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all(AppColors.primaryElementText),
            backgroundColor:
                MaterialStateProperty.all(AppColors.primaryElement),
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: AppColors.primaryElement)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                ),
            ),
        ),
        onPressed: () {
          print('dddddd');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 812),
        orientation: Orientation.portrait);
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          _buildPageHeadTitle(),
          _buildPageHeadDetail(),
          _buildPageHeadItem(
            "feature-1",
            "Compelling photography and typography provide a beautiful reading",
            86,
          ),
          _buildPageHeadItem(
            "feature-2",
            "Sector news never shares your personal data with advertisers or publishers",
            40,
          ),
          _buildPageHeadItem(
            "feature-3",
            "You can get Premium to unlock hundreds of publications",
            40,
          ),
          Spacer(),
          _buildPageHeadButton(),
        ],
      )),
    );
  }
}
