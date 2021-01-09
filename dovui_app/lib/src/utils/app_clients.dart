import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import '../configs/configs.dart';
import 'app_shared.dart';
import 'utils.dart';

class AppClients extends DioForNative {
  AppClients({String baseUrl = AppEndpoint.BASE_URL, BaseOptions options})
      : super(options) {
    this.interceptors.add(InterceptorsWrapper(
          onRequest: _requestInterceptor,
          onResponse: _responseInterceptor,
          onError: _errorInterceptor,
        ));
    this.options.baseUrl = baseUrl;
  }

  _requestInterceptor(RequestOptions options) async {
    String accessToken = await AppShared.getAccessToken();
    if (options.headers == null) {
      options.headers = {};
    }
    if (options.headers.containsKey(AppEndpoint.keyAuthorization)) {
      options.headers.remove(AppEndpoint.keyAuthorization);
    }
    if (accessToken != null && accessToken.length > 0) {
      options.headers[AppEndpoint.keyAuthorization] = "Bearer $accessToken";
    }
    options.connectTimeout = AppEndpoint.connectionTimeout;
    options.receiveTimeout = AppEndpoint.receiveTimeout;
    return options;
  }

  _responseInterceptor(Response response) {}

  _errorInterceptor(DioError dioError) {}
}
