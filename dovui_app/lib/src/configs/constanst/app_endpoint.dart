class AppEndpoint {
  AppEndpoint._();

  static const String BASE_URL = "http://relax365.net";

  static const int connectionTimeout = 1500;
  static const int receiveTimeout = 1500;
  static const String keyAuthorization = "Authorization";

  static const int SUCCESS = 200;
  static const int ERROR_TOKEN = 401;
  static const int ERROR_VALIDATE = 422;
  static const int ERROR_SERVER = 500;
  static const int ERROR_DISCONNECT = -1;

  static const String MORE_APPS = '/hsmoreapp';
  static const String GET_QUESTION = '/hsdovuihainao';
}
