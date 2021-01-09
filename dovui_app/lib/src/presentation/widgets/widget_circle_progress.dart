import 'package:flutter/material.dart';

class WidgetCircleProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 36,
        height: 36,
        padding: EdgeInsets.all(5),
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
          backgroundColor: Theme.of(context).primaryColorLight,
        ));
  }
}
