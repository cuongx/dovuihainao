import 'package:flutter/material.dart';

class WidgetLogo extends StatelessWidget {
  final String image;
  final Function action;
  final double widthFactor;
  final double aspectRatio;

  const WidgetLogo(
      {this.action, this.aspectRatio, this.image, this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor ?? 0.65,
      child: InkWell(
        onTap: action,
        child: AspectRatio(
          aspectRatio: aspectRatio ?? 1,
          child: Center(
            child: Image.asset(image ?? ''),
          ),
        ),
      ),
    );
  }
}
