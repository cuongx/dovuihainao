import 'package:flutter/material.dart';

class Widget_Getsture extends StatefulWidget {
  String images;
  String subImages;
  double width;
  double height;
  VoidCallback onTap;

  Widget_Getsture(
      {this.images, this.subImages, this.onTap, this.width = 190, this.height});


  @override
  _Widget_GetstureState createState() => _Widget_GetstureState();
}

class _Widget_GetstureState extends State<Widget_Getsture> {
  String currentImage;

  @override
  void initState() {
    currentImage = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => widget.onTap(),

      onTapCancel: () {
        setState(() {
          currentImage = widget.images;
        });
      },
        onTapDown: (TapDownDetails details) {
          setState(() {
            currentImage = widget.subImages;
          });
        },
      onTapUp: (TapUpDetails details) {
        setState(() {
          currentImage =  widget.images;
        });
      },

      child:  Container(
          width: widget.width,
          height: widget.height,
          child: Image.asset(
            currentImage,
            width: widget.width,
          ),
        )
    );
  }
}
