

import 'package:flutter/material.dart';
import 'package:news_app/common/entity/entities.dart';

class newsRecommendProvider with ChangeNotifier{

  NewsRecommendResponseEntity _newsRecommendResponseEntity = NewsRecommendResponseEntity();

  NewsRecommendResponseEntity get newsRecommend => this._newsRecommendResponseEntity;

  bool loading = true;

  void setNewRecommend(NewsRecommendResponseEntity newsRecommendResponseEntity) {
    _newsRecommendResponseEntity = NewsRecommendResponseEntity();

    _newsRecommendResponseEntity = newsRecommendResponseEntity;

    loading = false;
    // loading = false;
    notifyListeners();
  }
}