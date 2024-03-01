import 'dart:io';

class HttpProxy extends HttpOverrides {
  final String _host;
  final String _port;

  HttpProxy(this._host, this._port);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final http = super.createHttpClient(context);
    http.findProxy = (uri) {
      return 'PROXY $_host:$_port';
    };
    http.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return http;
  }
}
