import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/common/entity/news_list_response_entity.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/appBar.dart';
import 'package:news_app/common/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DetailsPage extends StatefulWidget {

  final Items item;
  const DetailsPage( {required this.item,Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  bool _isPageFinished = false;

  double _webViewHeight = 200;

  // 顶部导航
  PreferredSizeWidget _buildAppBar() {
    return transparentAppBar(
        context: context,
        // title: Consumer<ApplicationProvider>(
        //     builder: (_,app,child){
        //       return Text(
        //         // _tabTitles[_page],
        //         app.tabTitle,
        //         style: TextStyle(
        //           color: AppColors.primaryText,
        //           fontFamily: 'Montserrat',
        //           fontSize: duSetFontSize(18.0),
        //           fontWeight: FontWeight.w600,
        //         ),
        //       );
        //     }),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: AppColors.primaryText,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: AppColors.primaryText,
            ),
            onPressed: () {
              // Share.share('${widget.item.title} ${widget.item.url}');
            },
          )
        ]);
  }

// 页标题
  Widget _buildPageTitle() {
    return Container();
  }

// 页头部
  Widget _buildPageHeader() {
    return Container();
  }

// web内容
  Widget _buildWebView() {
    return Container(
      height: _webViewHeight,
      child: WebView(
        initialUrl: '$SERVER_API_URL/news/content/${widget.item.id.toString()}',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller.complete(webViewController);
        },
        javascriptChannels: <JavascriptChannel>[
          // _invokeJavascriptChannel(context),
        ].toSet(),
        navigationDelegate: (NavigationRequest request) {
          if (request.url != '$SERVER_API_URL/news/content/${widget.item.id}') {
            toastInfo(msg: request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
        },
        onPageFinished: (String url) async {
          // 获取滚动高度
          final scrollHeight = await (await _controller.future).evaluateJavascript(
            '(() => document.body.scrollHeight)();',
          );
          if (scrollHeight != null) {
            setState(() {
              _webViewHeight = double.parse(scrollHeight);
              _isPageFinished = true;
            });
          }
        },
        gestureNavigationEnabled: true,
      ),
    );
  }


  // 获取页面高度
  _getWebViewHeight() async {
    await (await _controller.future).evaluateJavascript('''
          let scrollHeight = document.documentElement.scrollHeight;
          if (scrollHeight) {
            Invoke.postMessage(scrollHeight);
          }''');
  }


  // 注册js回调
  JavascriptChannel _invokeJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Invoke',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
          var webHeight = double.parse(message.message);
          if (webHeight != null) {
            setState(() {
              _webViewHeight = webHeight;
            });
          }
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildPageTitle(),
            Divider(height: 1),
            _buildPageHeader(),
            _buildWebView(),
          ],
        ),
      ),
    );
  }
}
