import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension SizeExt on BuildContext {
  double smallSpacing() {
    return ResponsiveWrapper.of(this).isLargerThan(TABLET) ? 14 : 8;
  }

  double defaultSpacing() {
    return ResponsiveWrapper.of(this).isLargerThan(TABLET) ? 25 : 16;
  }

  double largeSpacing() {
    return ResponsiveWrapper.of(this).isLargerThan(TABLET) ? 32 : 24;
  }
}
