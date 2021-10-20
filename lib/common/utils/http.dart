import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:news_app/common/utils/net_cache.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/proxy.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/global.dart';

/*
  * http 操作类
  *
  * 手册
  * https://github.com/flutterchina/dio/blob/master/README-ZH.md#formdata
  *
*/
class HttpUtil {

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;

  static Options options = Options(
    responseType: ResponseType.json,
  );

  HttpUtil._internal() {
    dio = Dio(BaseOptions(
      baseUrl: SERVER_API_URL,
      // baseUrl: storage.read(key: STORAGE_KEY_API_URL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      // Http请求头.
      headers: {
        'Accept-Language': 'zh',
      },

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    ));

    // Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(NetCacheInterceptor()); //缓存

    /// 拦截器
    // interceptors(dio);
    // 添加拦截器
    // dio.interceptors
    //     .add(InterceptorsWrapper(onRequest: (RequestOptions options,ResponseInterceptorHandler responseInterceptorHandler) {
    //   // print("请求之前");
    //   // Loading.before(options.uri, '正在通讯...');
    //   // return options; //continue
    //   responseInterceptorHandler.next(options)
    // // }, onResponse: (Response response) {
    // //   // print("响应之前");
    // //   // Loading.complete(response.request.uri);
    // //   return response; // continue
    // // }, onError: (DioError e) {
    // //   // print("错误之前");
    // //   // Loading.complete(e.request.uri);
    // //   return e; //continue
    // // }));

    /// 请求日志
    // dio.interceptors.add(HttpFormatter());

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    // if (!Global.isRelease && PROXY_ENABLE) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY $PROXY_IP:$PROXY_PORT";
    //     };
    //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }

    // dio.interceptors.add(
    //   InterceptorsWrapper(onRequest: (e, handler) {
    //     handler.next(e);
    //   }, onResponse: (e, handler) {
    //     var code = e.data["code"];
    //     if (code == 200) {
    //       handler.next(e);
    //     } else {
    //       switch (code) {
    //         case 1003:
    //         // token失效,重新登录
    //           print("token失效");
    //           // reLogin();
    //           break;
    //         default:
    //       }
    //       handler.next(e);
    //     }
    //   }, onError: (DioError e, handler) {
    //     // 当请求失败时做一些预处理
    //     return handler.next(e);
    //   }),
    // );
  }



  /*
   * error统一处理
   */
  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
      case DioErrorType.response:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// 读取本地配置
  Options getLocalOptions() {
    late Options options;
    String? token = StorageUtil.getString(STORAGE_USER_TOKEN_KEY);
    options = Options(headers: {'Authorization': 'Bearer $token',});

    return options;
  }


  /// 读取本地配置
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    String? accessToken = Global.profile.accessToken;
    if (accessToken != null) {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }

  /// restful get 操作
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  Future get(
      String path, {
        dynamic params,
        Options? options,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        bool list = false,
        String? cacheKey,
        CancelToken? cancelToken
      }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions = requestOptions.copyWith(extra: {
        "refresh": refresh,
        "noCache": noCache,
        "list": list,
        "cacheKey": cacheKey,
      });
      Map<String, dynamic> _authorization = getAuthorizationHeader();
      if (_authorization != null) {
        requestOptions = requestOptions.copyWith(headers: _authorization);
      }

      Response response = await dio.get(path, queryParameters: params, options: requestOptions, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post 操作
  Future post(String path,
      {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {

      var tokenOptions = options;
      var response = await dio.post(path,
          data: params, options: tokenOptions, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleHttpError(response.statusCode!);
        return Future.error('HTTP错误');
      }
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful put 操作
  Future put(String path,
      {dynamic params, required Options options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options;
      var response = await dio.put(path,
          data: params, options: tokenOptions, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleHttpError(response.statusCode!);
        return Future.error('HTTP错误');
      }
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful delete 操作
  Future delete(String path,
      {dynamic params, required Options options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options;
      var response = await dio.delete(path,
          data: params, options: tokenOptions, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleHttpError(response.statusCode!);
        return Future.error('HTTP错误');
      }
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  /// restful post form 表单提交操作
  Future postForm(String path,
      {dynamic params, required Options options, CancelToken? cancelToken}) async {
    try {
      var tokenOptions = options;
      var response = await dio.post(path,
          data: FormData.fromMap(params),
          options: tokenOptions,
          cancelToken: cancelToken);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleHttpError(response.statusCode!);
        return Future.error('HTTP错误');
      }
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code;
  String message;

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}

// 处理 Http 错误码
ErrorEntity _handleHttpError(int errorCode) {
  String message;
  switch (errorCode) {
    case 400:
      message = '请求语法错误';
      break;
    case 401:
      message = '未授权，请登录';
      break;
    case 403:
      message = '拒绝访问';
      break;
    case 404:
      message = '请求出错';
      break;
    case 408:
      message = '请求超时';
      break;
    case 500:
      message = '服务器异常';
      break;
    case 501:
      message = '服务未实现';
      break;
    case 502:
      message = '网关错误';
      break;
    case 503:
      message = '服务不可用';
      break;
    case 504:
      message = '网关超时';
      break;
    case 505:
      message = 'HTTP版本不受支持';
      break;
    default:
      message = '请求失败，错误码：$errorCode';
  }
  return ErrorEntity(code: errorCode, message: message);
}
