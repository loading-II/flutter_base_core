import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'i_http_processor.dart';

///Dart IO库中提供了用于发起Http请求的一些类，我们可以直接使用HttpClient来发起请求
///本类只实现简单的Get、POST功能，更多细节可查看：
///https://book.flutterchina.club/chapter11/dio.html#_11-3-1-%E5%BC%95%E5%85%A5dio
///https://juejin.cn/post/7169794507171430413
class HttpClientProcessor extends IHttpProcessor {
  static late HttpClient _httpClient;

  HttpClientProcessor(bool isDebug) {
    _httpClient = HttpClient();
  }

  @override
  post<T>(String url, Map<String, dynamic> data, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure) {
    var uri = Uri(scheme: 'https', host: 'www.wanandroid.com', path: '/user/login', queryParameters: data);
    _httpClient.postUrl(uri).then((HttpClientRequest reponse) {
      return reponse.close();
    }).then((HttpClientResponse response) async {
      // handlerHttpClientResponse(response, onSuccess, onFailure);
    });
  }

  @override
  get<T>(String url, Map<String, dynamic>? params, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure) {
    final uri = Uri.parse(url);

    ///链式请求方式一：
    _httpClient.getUrl(uri).then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) async {
      // handlerHttpClientResponse(response, onSuccess, onFailure);
    });

    ///普通的Get请求方式二
    /*try {
      final request = await _httpClient.getUrl(uri);
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        String responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> map = strToMap(responseBody);
        BaseResponse<T> responseEntity = BaseResponse.fromJson(map);
        if (responseEntity.isSuccess()) {
          T data = responseEntity.data as T;
          onSuccess?.call(data);
        } else {
          onFailure?.call(responseEntity.errorCode, responseEntity.errorMsg);
        }
      } else {
        onFailure?.call(response.statusCode, "服务器异常,请重试!");
      }
    } catch (error) {
      onFailure?.call(-1, "$error");
    } finally {
      _httpClient.close();
    }*/
  }
}
