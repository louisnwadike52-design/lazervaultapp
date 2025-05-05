import 'package:flutter/material.dart';

class ResponsiveController {
  final BuildContext context;

  ResponsiveController(this.context);

  // Screen dimensions
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  // Text scaling
  double get textScaleFactor => 1.0;

  // Aspect Ratio
  double get aspectRatio => MediaQuery.of(context).size.aspectRatio;

  // Breakpoints
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // Scaling methods
  double scaleWidth(double inputWidth) => (inputWidth / 375.0) * screenWidth;
  double scaleHeight(double inputHeight) =>
      (inputHeight / 812.0) * screenHeight;
  double scaleText(double fontSize) => fontSize * textScaleFactor;
}
