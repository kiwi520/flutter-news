
import 'package:news_app/common/api/news.dart';
import 'package:news_app/common/providers/category_provider.dart';

class CategoryService {

  static  getCategory(CategoryProvider categoryProvider) async {
     var  _categoryList =   await  NewsAPI.categories();

     categoryProvider.setCategoryList(_categoryList);
  }
}