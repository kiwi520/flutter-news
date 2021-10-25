
import 'package:flutter/material.dart';
import 'package:news_app/common/api/news.dart';
import 'package:news_app/common/providers/news_recommend_provider.dart';

class newsRecommendService {

  static  getNewsRecommend(newsRecommendProvider recommendProvider, BuildContext context) async {
    var  _newsRecommend =   await  NewsAPI.newsRecommend(context: context);

    recommendProvider.setNewRecommend(_newsRecommend);
  }
}