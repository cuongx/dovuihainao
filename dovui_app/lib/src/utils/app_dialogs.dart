// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../presentation/presentation.dart';
//
// class AppDialogs {
//   AppDialogs._();
//
//   static createNotify(
//       {Widget widget,
//       String message,
//       String positiveLabel,
//       Function onPositiveTap,
//       String negativeLabel,
//       Function onNegativeTap}) async {
//     assert(widget != null ||
//         (message != null && positiveLabel != null && negativeLabel != null));
//     await Get.dialog(widget ??
//         WidgetNotify(
//           message: message,
//           positiveLabel: positiveLabel,
//           onPositiveTap: onPositiveTap,
//           negativeLabel: negativeLabel,
//           onTouchOutsizeEnable: false,
//           onNegativeTap: onNegativeTap ??
//               () {
//                 Get.back();
//               },
//         ));
//   }
// }
