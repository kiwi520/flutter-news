

import 'package:news_app/common/api/apis.dart';
import 'package:news_app/common/providers/channels_provider.dart';

class channelsService {
  static  getChannelList(channelsProvider channels) async {
    var  _channels =   await  NewsAPI.channels();
    channels.setChannelList(_channels);
  }
}