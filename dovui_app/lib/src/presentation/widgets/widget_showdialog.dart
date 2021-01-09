// import 'package:dovui_app/src/presentation/homepage/homepage_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rxdart/rxdart.dart';
//
// class WidgetShowdialog extends StatefulWidget  {
//   final String text;
//   final String image;
//   final String icon;
//   final bool check;
//   final String answer;
//   final BehaviorSubject<bool> victorySubject;
//
//   WidgetShowdialog({Key key, this.text, this.image, this.icon, this.check,this.answer,this.victorySubject});
//
//   @override
//   WidgetShowdialogState createState() => WidgetShowdialogState();
// }
//
// class WidgetShowdialogState extends State<WidgetShowdialog> with SingleTickerProviderStateMixin {
//
//
//
//
//   AnimationController _controller;
//   Animation<Offset> _offsetAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);
//     _offsetAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end:  Offset(1, 1),
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.bounceOut,
//     ));
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//    Widget build (BuildContext context) {
//
//     // TODO: implement build
//        showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return Scaffold(
//             backgroundColor: const Color(0xFF0E3311).withOpacity(0.1),
//             body: Container(
//                 margin: EdgeInsets.only(top: 80),
//                 height: 500,
//                 color: const Color(0xFF0E3311).withOpacity(0.1),
//                 child: Stack(
//                   alignment: Alignment.topCenter,
//                   children: [
//                     Image.asset(
//                       "assets/images/stars.png",
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.asset(
//                         widget.image,
//                         fit: BoxFit.contain,
//                         width: 200,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 200,
//                     ),
//                     Positioned(
//                         top:   widget.check ? 175 : 190,
//                         height: 150,
//                         width: 300,
//                         child: Container(
//                             height: 75,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                               image: AssetImage("assets/images/board2.png"),
//                               fit: BoxFit.fill,
//                             )),
//                             child: Container(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     widget.text,
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               ),
//                             ))),
//                     Positioned(
//                         top: widget.check ? 21 : 23,
//                         left: widget.check ? 20 : 38,
//                         child: SlideTransition(
//                           position: _offsetAnimation,
//                           child: Image.asset(
//                             widget.icon,
//                             fit: BoxFit.contain,
//                             height: widget.check ? 125 : 90,
//                           ),
//                         )),
//                     Positioned(
//                         top: widget.check ? 290 : 305,
//                         height: 50,
//                         child: InkWell(
//                             onTap: () {
//                               if (widget.check == true) {
//
//                               } else {}
//                               Navigator.of(context).pop();
//                             },
//                             // child:check?Widget_Getsture(
//                             //    images: "assets/images/continue1.png",
//                             //     subImages: "assets/images/continue2.png",
//                             //   result: true,
//                             // ):Widget_Getsture(
//                             //   images: "assets/images/playagain1.png",
//                             //   subImages: "assets/images/playagain2.png",
//                             //   result:  true,
//                             // )
//                             child: Image.asset(widget.check
//                                 ? "assets/images/continue1.png"
//                                 : "assets/images/playagain1.png")))
//                   ],
//                 )),
//           );
//         },
//       );
//     }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return  SlideTransition(
//     position: _offsetAnimation,
//     child: Image.asset(
//       widget.icon,
//     fit: BoxFit.contain,
//     height: widget.check ? 125 : 90,
//     ));
//   }
// }
//
