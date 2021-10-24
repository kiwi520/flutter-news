

import 'package:flutter/material.dart';
import 'package:news_app/common/entity/news_list_response_entity.dart';

class newsPageListProvider with ChangeNotifier{
  NewsPageListResponseEntity? _newsPageList = NewsPageListResponseEntity();


  bool loading = true;

  NewsPageListResponseEntity? get newsPageList => this._newsPageList;

  void setNewsPageList(NewsPageListResponseEntity newsPageList) {
    _newsPageList = NewsPageListResponseEntity();
    _newsPageList = newsPageList;

    loading = false;
    notifyListeners();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }
}