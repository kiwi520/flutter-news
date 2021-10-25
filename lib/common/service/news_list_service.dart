import 'package:flutter/material.dart';
import 'package:news_app/common/api/apis.dart';
import 'package:news_app/common/providers/news_list_provider.dart';

class newsPageListService {
  static  getNewsPageList(newsPageListProvider news,BuildContext context) async {
    var  _newsList =   await  NewsAPI.newsPageList(context: context);
    news.setNewsPageList(_newsList);
  }
}