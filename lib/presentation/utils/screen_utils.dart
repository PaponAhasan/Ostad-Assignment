enum ScreenType {
  mobile,
  tablet,
  desktop,
}

class ScreenUtils {
  static const double mobileMaxWidth = 640;
  static const double tabletMaxWidth = 1007;

  static ScreenType getScreenType(double width) {
    if (width <= mobileMaxWidth) {
      return ScreenType.mobile;
    } else if (width > mobileMaxWidth && width <= tabletMaxWidth) {
      return ScreenType.tablet;
    }
    return ScreenType.desktop;
  }
}