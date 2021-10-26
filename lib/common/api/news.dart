import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/entity/entities.dart';
import 'package:news_app/common/utils/utils.dart';

/// 新闻
class NewsAPI {
  /// 翻页
  static Future<NewsPageListResponseEntity> newsPageList(
      {NewsPageListRequestEntity? params, required BuildContext context,bool? cacheDisk }) async {
    var response = await HttpUtil().get('/news', context:context, params: params,  options: Options(method:'get'), cacheDisk: cacheDisk);
    return NewsPageListResponseEntity.fromJson(response);
  }

  /// 推荐
  static Future<NewsRecommendResponseEntity> newsRecommend(
      {required BuildContext context,NewsRecommendRequestEntity? params,bool? cacheDisk = false}) async {
    var response = await HttpUtil().get('/news/recommend', context:context, params: params, options: Options(method:'get'), cacheDisk: cacheDisk);
    return NewsRecommendResponseEntity.fromJson(response);
  }

  /// 分类
  ///
  ///
  static Future<TestEntity> testData(BuildContext context, {bool cacheDisk = false}) async {
    var response = await HttpUtil().get('/test', context:context);
    return response
        .map<TestEntity>(
            (item) => TestEntity.fromJson(item))
        .toList();
  }

  /// 分类
  static Future<List<CategoryResponseEntity>> categories(BuildContext context, bool? cacheDisk) async {
    var response = await HttpUtil().get('/categories', context:context, cacheDisk: cacheDisk);

    return response.map<CategoryResponseEntity>(
            (item) => CategoryResponseEntity.fromJson(item))
        .toList();
  }

  /// 频道
  static Future<List<ChannelResponseEntity>> channels(BuildContext context, bool? cacheDisk) async {
    var response = await HttpUtil().get('/channels', context:context, options: Options(method:'get'), cacheDisk: cacheDisk);
    return response
        .map<ChannelResponseEntity>(
            (item) => ChannelResponseEntity.fromJson(item))
        .toList();
  }

  /// 标签列表
  static Future<List<TagResponseEntity>> tags({TagRequestEntity? params, required BuildContext context,bool? cacheDisk}) async {
    var response = await HttpUtil().get('/tags', context:context, params: params, options: Options(method:'get'), cacheDisk: cacheDisk);
    return response
        .map<TagResponseEntity>((item) => TagResponseEntity.fromJson(item))
        .toList();
  }
}