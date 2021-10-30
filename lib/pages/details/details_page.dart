import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:news_app/common/entity/news_list_response_entity.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/appBar.dart';
import 'package:news_app/common/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
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
              Share.share('${widget.item.title} ${widget.item.url}');
            },
          )
        ]);
  }

// 页标题
  Widget _buildPageTitle() {
    return Container(
      margin: EdgeInsets.all(duSetWidth(10)),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // 标题
              Text(
                widget.item.category!,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.normal,
                  fontSize: duSetFontSize(30),
                  color: AppColors.thirdElement,
                ),
              ),
              // 作者
              Text(
                widget.item.author!,
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.normal,
                  fontSize: duSetFontSize(14),
                  color: AppColors.thirdElementText,
                ),
              ),
            ],
          ),
          Spacer(),
          // 标志
          CircleAvatar(
            //头像半径
            radius: duSetWidth(22),
            backgroundImage: AssetImage("assets/images/channel-fox.png"),
          ),
        ],
      ),
    );
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
        // initialUrl: 'https://cn.engadget.com/cn-2020-01-21-google-pixelbook-go-not-pink-available.html',
        // initialUrl: 'https://whatmyuseragent.com',
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
        onWebViewCreated: (WebViewController webViewController) async {
          _controller.complete(webViewController);
        },
        // javascriptChannels: <JavascriptChannel>[
        //   // _invokeJavascriptChannel(context),
        // ].toSet(),
        navigationDelegate: (NavigationRequest request) {
          if (request.url != '$SERVER_API_URL/news/content/${widget.item.id}') {
            toastInfo(msg: request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) async {
          // await (await _controller.future).evaluateJavascript(
          //   'document.getElementsByTagName("header)[0].style.display=none'
          //   'document.getElementsByTagName("nav)[0].style.display=none'
          // );
          Timer(Duration(seconds: 2), () {
            _removeWebViewAd();
          });
        },
        onPageFinished: (String url) {
          // await (await _controller.future).evaluateJavascript("document.getElementsByTagName('header')[0].style.display='none';");
          // await (await _controller.future).evaluateJavascript("document.getElementsByTagName('nav')[0].style.display='none';");


          _resizeHeight();
          _isPageFinished = true;
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

  // 删除广告
  _removeWebViewAd() async {
    await (await _controller.future).evaluateJavascript('''
        try {
          function removeElement(elementName){
            let _element = document.getElementById(elementName);
            if(!_element) {
              _element = document.querySelector(elementName);
            }
            if(!_element) {
              return;
            }
            let _parentElement = _element.parentNode;
            if(_parentElement){
                _parentElement.removeChild(_element);
            }
          }

          removeElement('module-engadget-deeplink-top-ad');
          removeElement('module-engadget-deeplink-streams');
          removeElement('nav');
          removeElement('footer');
        } catch{}
        ''');
  }

  _resizeHeight() async {
    // // 获取滚动高度
    final scrollHeight = await (await _controller.future).evaluateJavascript(
      // '(() => document.body.scrollHeight)();',
      '(() => document.documentElement.scrollHeight)();',
    );
    if (scrollHeight != null) {
      setState(() {
        _webViewHeight = double.parse(scrollHeight);
        _isPageFinished = true;
      });
    }
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
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildPageTitle(),
                Divider(height: 1),
                _buildPageHeader(),
                _buildWebView(),
              ],
            ),
          ),
          _isPageFinished == true ?  Container() :
              Align(
                alignment: Alignment.center,
                child: LoadingBouncingGrid.square(),
              )
        ],
      )
    );
  }
}