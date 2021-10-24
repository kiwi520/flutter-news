
import 'package:news_app/common/api/news.dart';
import 'package:news_app/common/providers/news_recommend_provider.dart';

class newsRecommendService {

  static  getNewsRecommend(newsRecommendProvider recommendProvider) async {
    var  _newsRecommend =   await  NewsAPI.newsRecommend();

    recommendProvider.setNewRecommend(_newsRecommend);
  }
}