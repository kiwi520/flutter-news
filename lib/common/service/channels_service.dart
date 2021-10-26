

import 'package:flutter/material.dart';
import 'package:news_app/common/api/apis.dart';
import 'package:news_app/common/providers/channels_provider.dart';

class channelsService {
  static  getChannelList(channelsProvider channels, BuildContext context, {bool? cacheDisk}) async {
    var  _channels =   await  NewsAPI.channels(context,cacheDisk);
    channels.setChannelList(_channels);
  }
}