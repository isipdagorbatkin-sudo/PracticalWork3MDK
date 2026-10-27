import 'package:dio/dio.dart';

class ApiKeyInterceptor extends Interceptor {
  static const apiKey = 'ze8RUfaNtUHuJhmnOKDyVWWxZUZMr6B0nL5k9AdN';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = apiKey;
    handler.next(options);
  }
}
