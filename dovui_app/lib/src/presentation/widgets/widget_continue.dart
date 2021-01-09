import 'package:flutter/material.dart';

class Widget_Continue extends StatefulWidget {
  String images;
  String subImages;
  String routers;
  Function callBack;
  VoidCallback onTap;

  Widget_Continue({this.images, this.subImages, this.routers, this.callBack,this.onTap});

  @override
  Widget_ContinueState createState() => Widget_ContinueState();
}

class Widget_ContinueState extends State<Widget_Continue>{
  String currentImage;

  @override
  void initState() {
    currentImage = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () async => await widget.onTap(),

      onTapCancel: (){
        setState(() {
          currentImage =  widget.images;
        });
      },

        onTapDown: (TapDownDetails details) {
          setState(() {
            currentImage =  widget.subImages;
          });
        },
      onTapUp: (TapUpDetails details) {
        setState(() {
          currentImage =  widget.images;
        });
      },


      child: Container(
          width: 190,
          child: Image.asset(
            currentImage,
            width: 190,
          ),
        )
    );

  }
}
