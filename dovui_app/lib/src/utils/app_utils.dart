
class AppUtils {
  AppUtils._();


  static Map<String, dynamic> mapData(Map<String, dynamic> data) {
    return {"data": data ?? {}};
  }

  static Map<String, dynamic> parseData(Map<String, dynamic> data) {
    return data['data'] ?? {};
  }
}
