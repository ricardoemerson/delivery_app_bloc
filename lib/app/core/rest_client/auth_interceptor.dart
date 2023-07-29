import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contexts/global_context.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = await SharedPreferences.getInstance();

    final accessToken = storage.getString('accessToken');

    options.headers['Authorization'] = 'Bearer $accessToken';

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      GlobalContext.instance.expireLogin();
    } else {
      handler.next(err);
    }
  }
}
