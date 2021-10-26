import 'package:flutter/material.dart';
import 'package:news_app/common/api/apis.dart';
import 'package:news_app/common/entity/news_list_request_entity.dart';
import 'package:news_app/common/providers/news_list_provider.dart';

class newsPageListService {
  static  getNewsPageList(newsPageListProvider news,BuildContext context, {bool? cacheDisk,NewsPageListRequestEntity?  params}) async {
    var  _newsList =   await  NewsAPI.newsPageList(context: context,cacheDisk:cacheDisk,params:params?.toJson());
    news.setNewsPageList(_newsList);
  }
}