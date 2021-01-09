import 'package:dovui_app/src/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WidgetImageButton extends StatefulWidget {
   List<Widget> children;
   MainAxisAlignment mainAxisAlignment;
   CrossAxisAlignment crossAxisAlignment;
   Image unpressedImage;
   Image pressedImage;
   double paddingTop;
   double width;
   double height;
   Function onTap;
   Widget label;
   bool select;
   WidgetImageButton(
      {Key key,
        this.select,
        this.children,
        this.unpressedImage,
        this.pressedImage,
        this.label,
        this.onTap,
        this.width,
        this.height,
        this.paddingTop = 5,
        this.mainAxisAlignment = MainAxisAlignment.center,
        this.crossAxisAlignment = CrossAxisAlignment.center,})
      : super(key: key);

  @override
  _WidgetImageButtonState createState() => _WidgetImageButtonState();
}

class _WidgetImageButtonState extends State<WidgetImageButton>  {
  double paddingTop;
  ImageProvider imagePressed;
  ImageProvider imageUnPressed;
  Image currentImage;
  Image imageRed =    Image(image:ExactAssetImage( AppImages.imgRed) );
  Image imageBlue  = Image(image:ExactAssetImage(AppImages.imgBlue) );
  Image imageYellow  = Image(image:ExactAssetImage(AppImages.imgYellow) );
  bool preloaded = false;
  //
  @override
  void initState() {
    super.initState();
    imagePressed = widget.pressedImage.image;
    imageUnPressed = widget.pressedImage.image;
    currentImage = widget.unpressedImage;
    paddingTop = 0.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(imagePressed, context);
    precacheImage(imageUnPressed, context);
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap:() => widget.onTap()?? _doNothing,
      onTapCancel: () {
        setState(() {
          currentImage = widget.unpressedImage;
          paddingTop = 0.0;
        });
      },
      onTapDown: (details) {
        setState(() {
          currentImage = widget.pressedImage;
          paddingTop = widget.paddingTop ?? 0.0;
        });
      },
      onTapUp: (details) {
        setState(() {
          currentImage =widget.unpressedImage;
          paddingTop = 0.0;
        });
      },
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImages(widget.select?widget.pressedImage:imageRed),
        ]
            + [widget.label ?? SizedBox()]
    ));

  }

  _doNothing() {}
  Widget showImages([Image images]){
   return Container(
      height: widget.height,
      width: widget.width,
      padding: EdgeInsets.only(top: paddingTop),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              alignment: Alignment(0, 0),
              image:images.image)),
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: widget.children,
      ),
    );
  }
}


  //