
import 'package:flutter/material.dart';
import 'package:news_app/common/api/news.dart';
import 'package:news_app/common/providers/category_provider.dart';

class CategoryService {

  static  getCategory(CategoryProvider categoryProvider,BuildContext context, {bool? cacheDisk}) async {
     var  _categoryList =   await  NewsAPI.categories(context,cacheDisk);

     categoryProvider.setCategoryList(_categoryList);
  }
}