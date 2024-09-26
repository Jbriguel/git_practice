import 'package:flutter/material.dart';
import 'package:atelier_so/core/theme/theme_colors.dart'; // Assurez-vous que le chemin est correct

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.iconData,
    this.textColor = ThemeColors.greyDeep,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontFamily: "Speedee",
        ),
      ),
      icon: Icon(iconData),
      style: ElevatedButton.styleFrom(
        elevation: 1.2,
        shadowColor: Colors.blueAccent.shade100,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: ThemeColors.white,
      ),
    );
  }
}

class CustomElevatedIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomElevatedIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: ThemeColors.redOrange,
      ),
      style: ElevatedButton.styleFrom(
        elevation: 1.2,
        shadowColor: Colors.blueAccent.shade100,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: ThemeColors.white,
      ),
    );
  }
}
