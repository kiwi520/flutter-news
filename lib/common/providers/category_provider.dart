import 'package:flutter/material.dart';
import 'package:news_app/common/entity/category_response_entity.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryResponseEntity>? _categoryList = [];

  late CategoryResponseEntity  _category;

  String? _selCategoryCode = '';

  bool loading = true ;

  List<CategoryResponseEntity>? get cateList => _categoryList;

  CategoryResponseEntity get category => _category;
  String? get categoryCode => _selCategoryCode;

  currentIndex(String index) {
    _selCategoryCode = index;
    notifyListeners();
  }

  setCategoryList(List<CategoryResponseEntity> categoryList) {
    _categoryList = [];
    _categoryList = categoryList;

    _selCategoryCode = categoryList.first.code!;
    // loading = false;
    notifyListeners();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

}