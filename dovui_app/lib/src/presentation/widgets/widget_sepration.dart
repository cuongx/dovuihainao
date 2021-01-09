import 'package:flutter/material.dart';

class WidgetSeparation extends StatelessWidget {
  final double thickness;
  final double height;
  final double dashWidth;
  final Color color;

  const WidgetSeparation({
    this.thickness = 1,
    this.color = Colors.black,
    this.height = 1,
    this.dashWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashHeight = thickness;
          final width = dashWidth;
              final dashCount = (boxWidth / (2 * width)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: width,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          );
        },
      ),
    );
  }
}