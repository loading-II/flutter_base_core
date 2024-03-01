import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class IHandlerResponse {
  void handlerResponse<T>(Response response, ValueChanged<T>? onSuccess, Function(int code, String message)? onFailure);
}
