import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/cupertino.dart';

class SplashItem {
  final String? title;
  final String description;
  final String? imagePath;
  final String? backgroundImage;
  final descritionColor;
  final titleColor;

  SplashItem(
      {  this.title,
      required this.description,
      this.imagePath,
      this.backgroundImage,
      this.descritionColor = ThemeColors.greyDeep,
      this.titleColor = ThemeColors.orangeDisable});
}
