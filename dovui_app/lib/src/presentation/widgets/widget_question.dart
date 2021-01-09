import 'package:dovui_app/src/configs/constanst/app_size_config.dart';
import 'package:dovui_app/src/presentation/homepage/homepage_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WidgetQuestion extends StatefulWidget{

  int level;
  final String title;

  WidgetQuestion({Key key, this.level, this.title}) : super(key: key);

  @override
  _WidgetQuestionState createState() => _WidgetQuestionState();
}

class _WidgetQuestionState extends State<WidgetQuestion>  {


  @override Widget build(BuildContext context) {
    AppSizeConfig().init(context);
    // TODO: implement build
    return  Container(
        margin: EdgeInsets.only(top: 25,left: 10,right: 10),
        padding: EdgeInsets.only(top: 15,right: 15,left: 15),
        height: AppSizeConfig.screenHeight/1/3,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/board1.png"),
              fit: BoxFit.fill,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Cấp độ ${widget.level}",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellow,
                    fontFamily: "Itim"),
              ),

                Expanded(
                  child: Padding(
                  padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Text(widget.title??"",style: TextStyle(
                      color: Colors.yellow[900],
                      fontSize: 17,
                      fontFamily: "Itim"),),
              ),
                )
            ],
          ),
        ),
    );

  }
}
