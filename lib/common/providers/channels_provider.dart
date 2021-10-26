

import 'package:flutter/material.dart';
import 'package:news_app/common/entity/channel_list_response_entity.dart';

class channelsProvider with ChangeNotifier{

  List<ChannelResponseEntity>? _channelResponseList = [];

  bool loading = true ;

  List<ChannelResponseEntity>? get channelList => _channelResponseList;

  void setChannelList(List<ChannelResponseEntity> channelList) {
    _channelResponseList = [];
    _channelResponseList = channelList;

    loading = false;
    // loading = false;
    notifyListeners();
  }

  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }
}