import 'package:dio/dio.dart';
import '../handler_response/i_handler_response.dart';

class HttpEntity {
  final bool isDebug;
  final String baseUrl;
  final List<Interceptor> interceptors;
  final IHandlerResponse iHandlerResponse;

  HttpEntity(this.isDebug, this.baseUrl, this.interceptors, this.iHandlerResponse);
}
