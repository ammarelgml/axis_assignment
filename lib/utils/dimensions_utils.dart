import 'package:flutter/material.dart';

const double baseHeight = 812.0;
const double baseWidth = 375.0;

double screenAwareHeight(double size, BuildContext context) {
  double drawingHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  return size * drawingHeight / baseHeight;
}

double screenAwareSize(double size, BuildContext context) {
  double drawingHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  return size * drawingHeight / baseHeight;
}

double screenAwareWidth(double size, BuildContext context) {
  double drawingWidth = MediaQuery.of(context).size.width - 16;
  return size * drawingWidth / baseWidth;
}
