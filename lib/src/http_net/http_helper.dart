import 'package:flutter/cupertino.dart';
import 'package:flutter_base_core/src/http_net/processor/http_dio_processor.dart';
import 'package:flutter_base_core/src/http_net/processor/i_http_processor.dart';
import 'entity/http_entity.dart';

class HttpHelper {
  static HttpHelper? _httpHelper;
  static late String _defaultBaseUrl;
  static late IHttpProcessor _defaultHttpProcessor;
  static final Map<String, IHttpProcessor> _mHttpProcessorMap = {};

  HttpHelper._internal();

  static HttpHelper getInstance() {
    _httpHelper ??= HttpHelper._internal();
    return _httpHelper!;
  }

  void preInit(List<HttpEntity> httpInstances) {
    for (var i = 0; i < httpInstances.length; i++) {
      _setHttpProcessor(httpInstances[i], i == 0);
    }
  }

  void _setHttpProcessor(HttpEntity entity, bool isDefault) {
    IHttpProcessor iHttpProcessor = HttpDioProcessor(
        isDebug: entity.isDebug,
        baseUrl: entity.baseUrl,
        mHttpInterceptors: entity.interceptors,
        iHandlerResponse: entity.iHandlerResponse);
    if (isDefault) {
      _defaultBaseUrl = entity.baseUrl;
      _defaultHttpProcessor = iHttpProcessor;
    }
    _mHttpProcessorMap[entity.baseUrl] = iHttpProcessor;
  }

  IHttpProcessor _getHttpProcessor({String? baseUrl}) {
    if (baseUrl == null) {
      return _defaultHttpProcessor;
    } else {
      return _mHttpProcessorMap[baseUrl]!;
    }
  }

  void get<T>(
      {String? baseUrl,
      required String url,
      Map<String, dynamic>? params,
      ValueChanged<T>? onSuccess,
      Function(int code, String message)? onFailure}) {
    _getHttpProcessor(baseUrl: baseUrl).get(url, params, onSuccess, onFailure);
  }

  void post<T>(
      {String? baseUrl,
      required String url,
      required Map<String, dynamic> data,
      ValueChanged<T>? onSuccess,
      Function(int code, String message)? onFailure}) {
    _getHttpProcessor(baseUrl: baseUrl).post(url, data, onSuccess, onFailure);
  }
}
