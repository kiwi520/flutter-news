

import 'package:flutter/material.dart';
import 'package:news_app/common/entity/entities.dart';

class newsRecommendProvider with ChangeNotifier{

  Items _newsRecommendResponseEntity = Items();

  Items get newsRecommend => this._newsRecommendResponseEntity;

  bool loading = true;

  void setNewRecommend(Items newsRecommendResponseEntity) {
    _newsRecommendResponseEntity = Items();

    _newsRecommendResponseEntity = newsRecommendResponseEntity;

    loading = false;
    // loading = false;
    notifyListeners();
  }
}