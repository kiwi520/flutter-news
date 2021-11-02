import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/providers/app_provider.dart';
import 'package:news_app/common/providers/application_provider.dart';
import 'package:news_app/common/utils/authentication.dart';
import 'package:news_app/common/utils/screen.dart';
import 'package:news_app/common/values/Radii.dart';
import 'package:news_app/common/values/colors.dart';
import 'package:news_app/common/values/shadows.dart';
import 'package:news_app/global.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  /// 头像
  Widget _buildUserHeader() {
    return Container(
      height: duSetWidth(263),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 背景
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: duSetWidth(263),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: duSetWidth(2),
                    decoration: BoxDecoration(
                      color: AppColors.tabCellSeparator,
                    ),
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            right: 20,
            bottom: 21,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 头像
                Container(
                  height: duSetWidth(198),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: duSetWidth(108),
                          height: duSetWidth(108),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 0,
                                child: Container(
                                  width: duSetWidth(108),
                                  height: duSetWidth(108),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      Shadows.primaryShadow,
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(duSetWidth(108) / 2)),
                                  ),
                                  child: Container(),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                child: Image.asset(
                                  "assets/images/account_header.png",
                                  height: duSetWidth(88),
                                  width: duSetWidth(88),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 文字
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(bottom: 9),
                        child: Text(
                          Global.profile.displayName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Text(
                        "@boltrogers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 单元格
  Widget _buildCell(
      {String? title,
      String? subTitle,
      int? number,
      bool hasArrow = false,
      VoidCallback? onTap}) {
    return Container(
      width: duSetWidth(375),
      height: duSetHeight(60),
      decoration: BoxDecoration(color: AppColors.primaryBackground),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: duSetWidth(335),
          decoration: BoxDecoration(color: AppColors.primaryBackground),
          child: GestureDetector(
            /// 空白区域点击触发
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 标题
                title == null
                    ? Container()
                    : Container(
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.normal,
                            fontSize: duSetFontSize(18),
                          ),
                        ),
                      ),
                Spacer(),
                // 标题
                subTitle == null
                    ? Container()
                    : Container(
                        child: Text(
                          subTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.normal,
                            fontSize: duSetFontSize(18),
                          ),
                        ),
                      ),
                number == null
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(right: duSetWidth(11)),
                        child: Text(
                          number.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: duSetFontSize(18),
                          ),
                        ),
                      ),
                // 箭头
                hasArrow == false
                    ? Container()
                    : Container(
                        width: duSetWidth(24),
                        height: duSetWidth(24),
                        // margin: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryText,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 分割条
  Widget _buildDivider() {
    return Container(
      height: duSetHeight(10),
      decoration: BoxDecoration(color: AppColors.secondaryElement),
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppProvider, ApplicationProvider>(
        builder: (context, app, tab, child) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildUserHeader(),
            _buildDivider(),
            _buildCell(
              title: "Email",
            ),
            _buildDivider(),
            _buildCell(
              title: "Email",
              subTitle: "boltrogers@gmail.com",
            ),
            _buildDivider(),
            _buildCell(
              title: "Favorite channels",
              number: 12,
              hasArrow: true,
            ),
            _buildDivider(),
            _buildCell(
              title: "Bookmarks",
              number: 294,
              hasArrow: true,
            ),
            _buildDivider(),
            _buildCell(
              title: "Popular categories",
              number: 7,
              hasArrow: true,
            ),
            _buildDivider(),
            _buildCell(
              title: "Switch Gray Filter",
              hasArrow: true,
              onTap: () => app.switchGrayFilter(),
            ),
            _buildDivider(),
            _buildCell(
              title: "Log out",
              hasArrow: true,
              onTap: () {
                tab.handleNavBarTap = 0;
                goLoginPage(context);
              },
            ),
          ],
        ),
      );
    });
  }
}
