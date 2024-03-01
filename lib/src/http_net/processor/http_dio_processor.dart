import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../handler_response/i_handler_response.dart';
import 'i_http_processor.dart';
import 'package:cookie_jar/cookie_jar.dart';

///dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时、自定义适配器等…
class HttpDioProcessor extends IHttpProcessor {
  late Dio _mDio;
  late bool _isDebug;
  late String _baseUrl;
  late IHandlerResponse _iHandlerResponse;

  HttpDioProcessor(
      {required bool isDebug, required String baseUrl, List<Interceptor>? mHttpInterceptors, required IHandlerResponse iHandlerResponse}) {
    _isDebug = isDebug;
    _baseUrl = baseUrl;
    _iHandlerResponse = iHandlerResponse;
    _mDio = Dio(_configureDio());
    if (mHttpInterceptors != null && mHttpInterceptors!.isNotEmpty) {
      for (var element in mHttpInterceptors) {
        _mDio.interceptors.add(element);
      }
    }
    _mDio.interceptors.add(CookieManager(CookieJar()));
    _mDio.interceptors.add(RetryInterceptor(
      dio: _mDio,
      logPrint: print, // specify log function (optional)
      retries: 3, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
    if (_isDebug) {
      _mDio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90));
    }
  }

  _configureDio() => BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        sendTimeout: const Duration(seconds: 3),
        responseType: ResponseType.json,
        contentType: Headers.formUrlEncodedContentType,
      );

  _getBaseUrl() {
    return;
  }

  @override
  post<T>(String url, Map<String, dynamic> data, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure) {
    _mDio.post(url, data: data).then((Response response) {
      _iHandlerResponse.handlerResponse<T>(response, onSuccess, onFailure);
      /*handlerResponse<T>(response, onSuccess, onFailure);*/
    });
  }

  @override
  get<T>(String url, Map<String, dynamic>? params, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure) {
    _mDio.get(url, queryParameters: params).then((Response response) {
      _iHandlerResponse.handlerResponse<T>(response, onSuccess, onFailure);
      /*handlerResponse<T>(response, onSuccess, onFailure);*/
    });
  }
}
