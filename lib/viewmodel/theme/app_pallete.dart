//boilerplate from Rivaan

import 'package:flutter/material.dart';

class Pallete {
  // 4 -5 Core Colors

  // Ocean Colors
  static const backgroundColor = Color(0xFF03045e); // Deep Twilight
  static const surfaceColor = Color(0xFF023e8a); // French Blue - for cards
  static const primaryText = Color(0xFFcaf0f8); // Light Cyan
  static const primaryAction = Color(0xFF00b4d8); // Turquoise Surf
  static const skyAqua = Color(0xFF48CAE4); // Sky Aqua
  static const blueGreen = Color(0xFF0096C7); // Blue Green
  static const brighttealBlue = Color(0xFF0077b6); // Bright Teal Blue
  static const frostedBlue = Color(0xFF90e0ef); // Frosted Blue

  //Ocean Adjectent Colors
  static const stormyTeal = Color(0xFF2a747b); // Stormy Teal
  static const darkCyan = Color(0xFF21897E); // Dark Cyan
  static const oceanMist = Color(0xFF3ba99c); // Ocean Mist
  static const pearlAqua = Color(0xFF69d1c5); // Pearl Aqua
  static const mayaBlue = Color(0xFF7ebce6); // Maya Blue
  static const softPeriwinkle = Color(0xFF8980f5); // Soft Periwinkle

  // Pantone Colors
  static const cloudDancer = Color(0xFFF0EEE9); // Cloud Dancer
  static const scarletSmile = Color(0xFFA33745); // Scarlet Smile
  static final Color desaturatedScarletSmile = HSLColor.fromColor(
    scarletSmile,
  ).withSaturation(0.4).toColor(); // Desaturated Scarlet Smile
  static const caraMEL = Color(0xFFC37C54); // Caramel
  static const iceMelt = Color(0xFFD3E4F1); // Ice Melt
  static const rinsingRivulet = Color(0xFF5CC6C3); // Rinsing Rivulet
}
