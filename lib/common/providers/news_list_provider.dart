

import 'package:flutter/material.dart';
import 'package:news_app/common/entity/news_list_response_entity.dart';

class newsPageListProvider with ChangeNotifier{
  NewsPageListResponseEntity? _newsPageList = NewsPageListResponseEntity();

  Items? _New = Items();


  bool loading = true;
  bool newLoading = true;

  NewsPageListResponseEntity? get newsPageList => this._newsPageList;
  Items? get news => this._New;

  void setNewsPageList(NewsPageListResponseEntity newsPageList) {
    _newsPageList = NewsPageListResponseEntity();

    _newsPageList = newsPageList;

    loading = false;
    notifyListeners();
  }

  void setNew(Items news) {
    _New = Items();

    _New = news;

    newLoading = false;
    notifyListeners();
  }

  // //
  // @override
  // void dispose() {
  //   _newsPageList = NewsPageListResponseEntity();
  //   loading = true;
  //   super.dispose();
  // }
}