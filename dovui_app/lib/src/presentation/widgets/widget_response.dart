import 'package:flutter/material.dart';

class WidgetResponse extends StatelessWidget {
  final Widget small;
  final Widget medium;
  final Widget large;

  const WidgetResponse({@required this.large, this.medium, this.small});

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return small ?? large;
        } else if (constraints.maxWidth < 1200 && constraints.maxWidth > 800) {
          return medium ?? large;
        } else {
          return large;
        }
      },
    );
  }
}
