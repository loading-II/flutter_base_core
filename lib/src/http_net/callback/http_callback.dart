import 'package:flutter/cupertino.dart';

class HttpCallback<T> {
  final ValueChanged<T> onSuccess;
  final Function(int code, String message) onFailure;

  HttpCallback(this.onSuccess, this.onFailure);
}
