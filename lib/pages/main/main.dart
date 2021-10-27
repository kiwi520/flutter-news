import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:news_app/common/entity/entities.dart';
import 'package:news_app/common/providers/category_provider.dart';
import 'package:news_app/common/providers/channels_provider.dart';
import 'package:news_app/common/providers/news_list_provider.dart';
import 'package:news_app/common/providers/news_recommend_provider.dart';
import 'package:news_app/common/service/category_service.dart';
import 'package:news_app/common/service/channels_service.dart';
import 'package:news_app/common/service/news_list_service.dart';
import 'package:news_app/common/service/news_recommend_service.dart';
import 'package:news_app/common/utils/screen.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/pages/main/ad_widget.dart';
import 'package:news_app/pages/main/categories_widget.dart';
import 'package:news_app/pages/main/channels_widget.dart';
import 'package:news_app/pages/main/news_item_widget.dart';
import 'package:news_app/pages/main/newsletter_widget.dart';
import 'package:news_app/pages/main/recommend_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late EasyRefreshController _controller; // EasyRefresh控制器

  // late NewsPageListResponseEntity _newsPageList; // 新闻翻页
  // late NewsRecommendResponseEntity _newsRecommend; // 新闻推荐
  // // late List<CategoryResponseEntity> _categories; // 分类
  // late List<ChannelResponseEntity> _channels; // 频道
  //
  // late String _selCategoryCode; // 选中的分类Code

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadAllData();
    _loadLatestWithDiskCache();
  }

  // 如果有磁盘缓存，延迟3秒拉取更新档案
  _loadLatestWithDiskCache() {
    if (CACHE_ENABLE == true) {
      var cacheData = StorageUtil.getJSON(STORAGE_INDEX_NEWS_CACHE_KEY);
      if (cacheData != null) {
        Timer(Duration(seconds: 3), () {
          _controller.callRefresh();
        });
      }
    }
  }

  // 读取所有数据
  _loadAllData() async {
    print('_loadAllData');
    CategoryService.getCategory(
        Provider.of<CategoryProvider>(context, listen: false), context,
        cacheDisk: true);
    newsRecommendService.getNewsRecommend(
        Provider.of<newsRecommendProvider>(context, listen: false), context,
        cacheDisk: true);
    channelsService.getChannelList(
        Provider.of<channelsProvider>(context, listen: false), context,
        cacheDisk: true);
    newsPageListService.getNewsPageList(
        Provider.of<newsPageListProvider>(context, listen: false), context,
        cacheDisk: true);
  }

  // 拉取推荐、新闻
  _loadNewsData(
      categoryCode, {
        bool refresh = false,
      }) async {

    newsRecommendService.getNewsRecommend(
        Provider.of<newsRecommendProvider>(context, listen: false), context,
        cacheDisk: true, params: NewsRecommendRequestEntity(categoryCode: categoryCode));

    newsPageListService.getNewsPageList(
        Provider.of<newsPageListProvider>(context, listen: false), context,
        cacheDisk: true,params: NewsPageListRequestEntity(categoryCode: categoryCode));

    // _selCategoryCode = categoryCode;
    // _newsRecommend = await NewsAPI.newsRecommend(
    //   context: context,
    //   params: NewsRecommendRequestEntity(categoryCode: categoryCode),
    //   refresh: refresh,
    //   cacheDisk: true,
    // );
    // _newsPageList = await NewsAPI.newsPageList(
    //   context: context,
    //   params: NewsPageListRequestEntity(categoryCode: categoryCode),
    //   refresh: refresh,
    //   cacheDisk: true,
    // );

    // if (mounted) {
    //   setState(() {});
    // }
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
    return Consumer<newsRecommendProvider>(
      builder: (context, recommend, child) {
        return recommend.loading == true
            ? Container()
            : recommendWidget(context,recommend.newsRecommend);
      },
    );
  }

  // 频道
  Widget _buildChannels() {
    return Consumer<channelsProvider>(
      builder: (context, channels, child) {
        return channels.loading == true
            ? Container()
            : newsChannelsWidget(
                channels: channels.channelList,
                onTap: (ChannelResponseEntity item) {},
              );
      },
    );
  }

  // 新闻列表
  Widget _buildNewsList() {
    return Consumer<newsPageListProvider>(
      builder: (context, newsPageList, child) {
        return newsPageList.loading == true
            ? Container()
            : Column(
                children: newsPageList.newsPageList!.items!.map((item) {
                  // 新闻行
                  List<Widget> widgets = <Widget>[
                    newsItem(item),
                    Divider(height: 1),
                  ];

                  // 每 5 条 显示广告
                  int index = newsPageList.newsPageList!.items!.indexOf(item);
                  if (((index + 1) % 5) == 0) {
                    widgets.addAll(<Widget>[
                      adWidget(),
                      Divider(height: 1),
                    ]);
                  }

                  // 返回
                  return Column(
                    children: widgets,
                  );
                }).toList(),
              );
      },
    );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return newsletterWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<CategoryProvider, newsRecommendProvider, channelsProvider,
        newsPageListProvider>(
      builder: (context, cate, recommend, channel, pageList, child) {
        return  Skeleton(
          isLoading: pageList.loading,
          skeleton: SkeletonListView(),
          child: EasyRefresh(
            enableControlFinishRefresh: true,
            controller: _controller,
            header: ClassicalHeader(),
            onRefresh: () async {
              await _loadNewsData(
                cate.categoryCode,
                refresh: true,
              );
              _controller.finishRefresh();
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildCategories(),
                  Divider(height: 1),
                  _buildRecommend(),
                  Divider(height: 1),
                  _buildChannels(),
                  Divider(height: 1),
                  _buildNewsList(),
                  Divider(height: 1),
                  _buildEmailSubscribe(),
                ],
              ),
            ),
          ),
        );


        return  pageList.newsPageList == null ? Container(): EasyRefresh(
          enableControlFinishRefresh: true,
          controller: _controller,
          header: ClassicalHeader(),
          onRefresh: () async {
            await _loadNewsData(
              cate.categoryCode,
              refresh: true,
            );
            _controller.finishRefresh();
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildCategories(),
                Divider(height: 1),
                _buildRecommend(),
                Divider(height: 1),
                _buildChannels(),
                Divider(height: 1),
                _buildNewsList(),
                Divider(height: 1),
                _buildEmailSubscribe(),
              ],
            ),
          ),
        );
      },
    );

    SingleChildScrollView(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCategories(),
          _buildRecommend(),
          _buildChannels(),
          _buildNewsList(),
          _buildEmailSubscribe(),
        ],
      ),
    ));
  }

// @override
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//       child: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             _buildCategories(),
//             _buildRecommend(),
//             _buildChannels(),
//             _buildNewsList(),
//             _buildEmailSubscribe(),
//           ],
//         ),
//       ));
// }
}
