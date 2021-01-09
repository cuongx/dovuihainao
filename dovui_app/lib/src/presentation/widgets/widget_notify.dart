import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetNotify extends StatelessWidget {
  final String message;
  final String positiveLabel;
  final Function onPositiveTap;
  final String negativeLabel;
  final Function onNegativeTap;
  final bool onTouchOutsizeEnable;

  const WidgetNotify(
      {Key key,
      @required this.message,
      @required this.positiveLabel,
      this.onPositiveTap,
      @required this.negativeLabel,
      this.onNegativeTap,
      this.onTouchOutsizeEnable = true})
      : super(key: key);

  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
              onTap: onTouchOutsizeEnable ? onNegativeTap : null,
              child: Container(
                color: Colors.transparent,
              ),
            )),
            Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: new BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * .9,
                  maxHeight: MediaQuery.of(context).size.height * .5,
                  maxWidth: MediaQuery.of(context).size.width * .9,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(20.0)),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  message,
                                  style: AppStyles.DEFAULT_MEDIUM,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FractionallySizedBox(
                                  child: FlatButton(
                                    onPressed: onPositiveTap,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text(
                                      positiveLabel,
                                      style: AppStyles.DEFAULT_MEDIUM
                                          .copyWith(color: white),
                                    ),
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(500.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onNegativeTap,
                        child: Text(
                          negativeLabel,
                          style: AppStyles.DEFAULT_MEDIUM.copyWith(
                              color: AppColors.black,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
