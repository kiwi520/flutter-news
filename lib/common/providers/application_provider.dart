import 'package:flutter/material.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';

class ApplicationProvider extends ChangeNotifier {
  int _currentIndexPage = 0;

  final List<String> _tabTitles = [
    'Welcome',
    'Cagegory',
    'Bookmarks',
    'ACount'
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarList = [
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.home,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.home,
        color: AppColors.secondaryElementText,
      ),
      label: "main",
      backgroundColor: AppColors.primaryBackground,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.grid,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.grid,
        color: AppColors.secondaryElementText,
      ),
      label: 'category',
      backgroundColor: AppColors.primaryBackground,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.tag,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.tag,
        color: AppColors.secondaryElementText,
      ),
      label: 'tag',
      backgroundColor: AppColors.primaryBackground,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Iconfont.me,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.me,
        color: AppColors.secondaryElementText,
      ),
      label: 'my',
      backgroundColor: AppColors.primaryBackground,
    )
  ];

  late PageController _pageController =
      PageController(initialPage: this._currentIndexPage);

  PageController get pageController => this._pageController;

  int get  currentIndex => this._currentIndexPage;

  // BottomNavigationBarItem get bottomNavigationBar => this._bottomNavigationBarList.elementAt(this._currentIndexPage);
  List<BottomNavigationBarItem> get bottomNavigationBarList => this._bottomNavigationBarList;

  List<String> get tabTitles => this._tabTitles;

  String get tabTitle => this._tabTitles.elementAt(this._currentIndexPage);

  void set currentIndexPage(int index) {
    _currentIndexPage = index;
    notifyListeners();
  }

  void set handleNavBarTap(int index){
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);

    notifyListeners();
  }
}
