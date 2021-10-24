import 'package:flutter/material.dart';
import 'package:news_app/common/providers/application_provider.dart';
import 'package:news_app/common/providers/category_provider.dart';
import 'package:news_app/common/providers/channels_provider.dart';
import 'package:news_app/common/providers/news_list_provider.dart';
import 'package:news_app/common/providers/news_recommend_provider.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/appBar.dart';
import 'package:news_app/pages/account/account.dart';
import 'package:news_app/pages/bookmarks/bookmarks.dart';
import 'package:news_app/pages/category/category.dart';
import 'package:news_app/pages/main/main.dart';
import 'package:provider/provider.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

/// SingleTickerProviderStateMixin 动画效果
class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  // /// 当前Tabe页面
  // int _page = 0;
  //
  // final List<String> _tabTitles = [
  //   'Welcome',
  //   'Cagegory',
  //   'Bookmarks',
  //   'ACount'
  // ];

  // 页控制器
  // late PageController _pageController;

  // 底部导航项目

  // final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Iconfont.home,
  //       color: AppColors.tabBarElement,
  //     ),
  //     activeIcon: Icon(
  //       Iconfont.home,
  //       color: AppColors.secondaryElementText,
  //     ),
  //     label: "main",
  //     backgroundColor: AppColors.primaryBackground,
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Iconfont.grid,
  //       color: AppColors.tabBarElement,
  //     ),
  //     activeIcon: Icon(
  //       Iconfont.grid,
  //       color: AppColors.secondaryElementText,
  //     ),
  //     label: 'category',
  //     backgroundColor: AppColors.primaryBackground,
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Iconfont.tag,
  //       color: AppColors.tabBarElement,
  //     ),
  //     activeIcon: Icon(
  //       Iconfont.tag,
  //       color: AppColors.secondaryElementText,
  //     ),
  //     label: 'tag',
  //     backgroundColor: AppColors.primaryBackground,
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Iconfont.me,
  //       color: AppColors.tabBarElement,
  //     ),
  //     activeIcon: Icon(
  //       Iconfont.me,
  //       color: AppColors.secondaryElementText,
  //     ),
  //     label: 'my',
  //     backgroundColor: AppColors.primaryBackground,
  //   ),
  // ];

  /// tab栏动画
  // void _handleNavBarTap(int index) {
  //   _pageController.animateToPage(index,
  //       duration: const Duration(milliseconds: 200), curve: Curves.ease);
  // }

  // // tab栏页码切换
  // void _handlePageChanged(int page) {
  //   setState(() {
  //     this._page = page;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = new PageController(initialPage: this._page);
  // }
  //
  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  // 顶部导航
  PreferredSizeWidget _buildAppBar() {
    return transparentAppBar(
        context: context,
        title: Consumer<ApplicationProvider>(
            builder: (_,app,child){
              return Text(
                // _tabTitles[_page],
                app.tabTitle,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: 'Montserrat',
                  fontSize: duSetFontSize(18.0),
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: AppColors.primaryText,
            ),
            onPressed: () {},
          )
        ]);
  }

  // 内容页
  Widget _buildPageView() {
    return Consumer<ApplicationProvider>(
        builder: (context,app,child){
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              MultiProvider(
                  providers: [
                    ChangeNotifierProvider<CategoryProvider>(
                        create: (_) => CategoryProvider()),
                    ChangeNotifierProvider<newsRecommendProvider>(
                        create: (_) => newsRecommendProvider()),
                    ChangeNotifierProvider<channelsProvider>(
                        create: (_) => channelsProvider()),
                    ChangeNotifierProvider<newsPageListProvider>(
                        create: (_) => newsPageListProvider())
                  ],
                  builder: (context, _) {
                    return MainPage();
                  }),
              CategoryPage(),
              BookmarksPage(),
              AccountPage(),
            ],
            controller:app.pageController,
            onPageChanged: (int index){
              app.currentIndexPage = index;
            },
          );
        });
  }

  // 底部导航
  Widget _buildBottomNavigationBar() {
    return Consumer<ApplicationProvider>(
          builder: (context,app,child){
            return BottomNavigationBar(
              items: app.bottomNavigationBarList,
              currentIndex: app.currentIndex,
              // fixedColor: AppColors.primaryElement,
              type: BottomNavigationBarType.fixed,
              onTap: (int index){
                app.handleNavBarTap = index;
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationProvider>(
      create: (_) => ApplicationProvider(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }
}
