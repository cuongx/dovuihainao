import 'package:dovui_app/src/configs/configs.dart';
import 'package:dovui_app/src/configs/constanst/app_size_config.dart';
import 'package:dovui_app/src/presentation/widgets/widget_image_button.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void ParamFunction(bool value);

class WidgetAnswers extends StatefulWidget {
   String value;
   bool status;
   ParamFunction action;
   String icon;
   String showCorrect;
   String showAnswer;
   String  blue = AppImages.imgBlue;
   String yellow = AppImages.imgYellow;
   String red = AppImages.imgRed;
   WidgetAnswers(
       {this.status = true,
         this.value,
         this.action,
         this.icon,
         this.showCorrect,
         this.showAnswer,
       });
  @override
  _WidgetAnswerState createState() => _WidgetAnswerState();

}
class _WidgetAnswerState extends State<WidgetAnswers> {

  @override
  Widget build(BuildContext context) {
    AppSizeConfig().init(context);

    bool check = false;
    bool result = widget.value == widget.showAnswer;
    if (widget.showCorrect != null && widget.showCorrect == widget.showAnswer) {
        check = true;
    }
    return Container(
      padding:  EdgeInsets.symmetric(vertical: AppSizeConfig.blockSizeVertical * 1.2,
          horizontal: AppSizeConfig.blockSizeHorizontal * 12.0),
      child: Stack(
        children: [
          WidgetImageButton(
            width: AppSizeConfig.screenWidth/1/1.12-40,
            height: AppSizeConfig.screenHeight/14,
            select: check,
            onTap: () {
              setState(() {
                widget.action(result);
              });
            },
            children: [
              Text(
                widget.value ?? "",
                style:
                AppStyles.DEFAULT_MEDIUM_BOLD.copyWith(color: Colors.white),
              )
            ],
            // pressedImage: Image.asset(widget.status?widget.yellow:widget.red),
            // unpressedImage:Image.asset(widget.status?widget.red:widget.blue)
              pressedImage: Image.asset(result
                  ? widget.blue
                  : widget.red),
              unpressedImage:Image.asset(widget.red)

          ),
          Positioned(
              left:-1,
              child: Container(
                child: Image.asset(
                  widget.icon,
                  height: MediaQuery.of(context).size.height/13,
                ),
              ))
        ],
      ),

    );
  }

}