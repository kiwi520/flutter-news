
import 'package:flutter/material.dart';
import 'package:news_app/common/api/news.dart';
import 'package:news_app/common/entity/recommend_request_entity.dart';
import 'package:news_app/common/providers/news_list_provider.dart';
import 'package:news_app/common/providers/news_recommend_provider.dart';

class newsRecommendService {

  static  getNewsRecommend(newsPageListProvider news,BuildContext context,{bool? cacheDisk,NewsRecommendRequestEntity? params}) async {
    var  _newsRecommend =   await  NewsAPI.newsRecommend(context: context,cacheDisk:cacheDisk!,params: params?.toJson());

    news.setNew(_newsRecommend);
  }
}