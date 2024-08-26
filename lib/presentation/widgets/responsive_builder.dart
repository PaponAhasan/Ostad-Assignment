import 'package:flutter/material.dart';

import '../utils/screen_utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenType = ScreenUtils.getScreenType(size.width);

    if(screenType == ScreenType.mobile) {
      // size for mobile
      return mobile;
    } else if(screenType == ScreenType.tablet) {
      // size for tablet
      return tablet ?? mobile;
    }

    // size for desktop
    return desktop;
  }
}