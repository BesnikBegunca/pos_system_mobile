import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x08000000), blurRadius: 12, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> cardElevated = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 18, offset: Offset(0, 8)),
  ];
}
