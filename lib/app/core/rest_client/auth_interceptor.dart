import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  // final IStorage _storage;

  // AuthInterceptor({
  //   required IStorage storage,
  // }) : _storage = storage;

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   final accessToken = _storage.getData(SessionStorageKeysEnum.accessToken.key);

  //   options.headers['Authorization'] = 'Bearer $accessToken';

  //   handler.next(options);
  // }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   if (err.response?.statusCode == 401) {
  //     GlobalContext.instance.expireLogin();
  //   } else {
  //     handler.next(err);
  //   }
  // }
}
