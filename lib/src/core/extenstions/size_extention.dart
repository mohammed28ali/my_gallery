import 'package:flutter/material.dart';

extension SizeMediaQuery on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get heightNavbar =>
      height * 0.085 + MediaQuery.of(this).padding.bottom;
  Orientation get orientation => MediaQuery.of(this).orientation;

}
