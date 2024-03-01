import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;

abstract class IHttpProcessor {
  void get<T>(String url, Map<String, dynamic>? params, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure);

  void post<T>(String url, Map<String, dynamic> data, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure);

  /*Map<String, dynamic> _strToMap(String strJson) {
    return convert.jsonDecode(strJson);
  }*/

/*Future<void> handlerHttpClientResponse<T>(
      HttpClientResponse response, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure) async {
    */ /*if (response.statusCode == HttpStatus.ok) {
      String responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> map = _strToMap(responseBody);
      BaseResponse<T> responseEntity = BaseResponse.fromJson(map);
      if (responseEntity.isSuccess()) {
        T data = responseEntity.data as T;
        onSuccess?.call(data);
      } else {
        onFailure?.call(responseEntity.errorCode, responseEntity.errorMsg);
      }
    } else {
      onFailure?.call(response.statusCode, "服务器异常,请重试!");
    }*/ /*
  }

  Future<void> handlerResponse<T>(Response response, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure) async {
    HttpHelper.getInstance().getHandlerResponse().handlerResponse<T>(response, onSuccess, onFailure);
    */ /*if (response.statusCode == HttpStatus.ok) {
      BaseResponse<T> responseEntity = BaseResponse.fromJson(response.data);
      if (responseEntity.isSuccess()) {
        T data = responseEntity.data as T;
        onSuccess?.call(data);
      } else {
        onFailure?.call(responseEntity.errorCode, responseEntity.errorMsg);
      }
    } else {
      onFailure?.call(response.statusCode != null ? response.statusCode! : -1, "服务器异常,请重试!");
    }*/ /*
  }*/
}
