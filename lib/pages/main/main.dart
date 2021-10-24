import 'package:flutter/material.dart';
import 'package:news_app/common/api/news.dart';
import 'package:news_app/common/entity/entities.dart';
import 'package:news_app/common/providers/category_provider.dart';
import 'package:news_app/common/service/category_service.dart';
import 'package:news_app/pages/main/categories_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late NewsPageListResponseEntity _newsPageList; // 新闻翻页
  late NewsRecommendResponseEntity _newsRecommend; // 新闻推荐
  // late List<CategoryResponseEntity> _categories; // 分类
  late List<ChannelResponseEntity> _channels; // 频道

  late String _selCategoryCode; // 选中的分类Code

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  // 读取所有数据
  _loadAllData() async {
    print('_loadAllData');
    CategoryService.getCategory(
        Provider.of<CategoryProvider>(context, listen: false));
    // Future.microtask(() async {
    //   _categories = await NewsAPI.categories();
    //   _channels = await NewsAPI.channels();
    //   _newsRecommend = await NewsAPI.newsRecommend();
    //   _newsPageList = await NewsAPI.newsPageList();
    // });
  }

  // 分类菜单
  Widget _buildCategories() {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) {
        return newsCategoriesWidget(
          categories: category.cateList!,
          selCategoryCode: category.categoryCode!,
          onTap: (CategoryResponseEntity item) {
            category.currentIndex(item.code!);
          },
        );
      },
    );
  }

  // 抽取前先实现业务

  // 推荐阅读
  Widget _buildRecommend() {
    return Container();
  }

  // 频道
  Widget _buildChannels() {
    return Container();
  }

  // 新闻列表
  Widget _buildNewsList() {
    return Container();
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategories(),
          // _buildRecommend(),
          // _buildChannels(),
          // _buildNewsList(),
          // _buildEmailSubscribe(),
        ],
      ),
    ));
  }
}
