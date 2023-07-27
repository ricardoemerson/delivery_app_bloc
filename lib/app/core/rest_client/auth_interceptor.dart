import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final storage = await SharedPreferences.getInstance();
      storage.clear();

      // GlobalContext.instance.expireLogin();
      handler.next(err);
    } else {
      handler.next(err);
    }
  }
}
