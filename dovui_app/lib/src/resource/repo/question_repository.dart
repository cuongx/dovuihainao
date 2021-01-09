// import 'package:dovui_app/src/configs/configs.dart';
// import 'package:dovui_app/src/resource/model/question.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
//
// import '../resource.dart';
// import 'api.dart';
//
// class QuestRepository {
//   static const base = "relax365.net";
//
//   ///http://relax365.net/hsdovuihainao?id=
//   Future<NetworkState<Question>> getQuest(int id) async {
//     Response response;
//     Map<String, String> param = {"id": id.toString()};
//     response = await Api()(AppEndpoint.BASE_URL, param);
//     return NetworkState(
//         status: AppEndpoint.SUCCESS,
//         data: QuestApplication.fromJson(response.body));
//   }