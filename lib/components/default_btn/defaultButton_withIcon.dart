import 'package:flutter/material.dart';

class DefaultButtonWithIcon extends StatelessWidget {
  DefaultButtonWithIcon(
      {super.key,
      this.text,
      required this.textColor,
      required this.backColor,
      this.leadingIcon,
      this.trailingIcon,
      this.borderColor,
      this.paddingV = 14.0,
      this.paddingH = 10.0,
      this.press,
      this.radius = 10,
      this.iconColor = Colors.white,
      this.iconSize = 20,
      this.elevation = 1});

  final String? text;
  final Color textColor;
  final Color backColor;
  final Function? press;
  final double paddingV;
  final double paddingH;
  final double radius;
  final Color? borderColor;
  final double elevation;
  IconData? leadingIcon;
  IconData? trailingIcon;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: borderColor != null
                  ? BorderSide(color: borderColor ?? backColor)
                  : BorderSide.none),
          disabledForegroundColor: backColor.withOpacity(0.38),
          disabledBackgroundColor: backColor.withOpacity(0.12),
          backgroundColor: backColor,
          shadowColor: Colors.grey.shade400,
          elevation: elevation,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
        onPressed: press as void Function()?,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[_buildIcon(leadingIcon)],
            Text(
              text!,
              style: TextStyle(
                  fontFamily: 'Speedee', fontSize: 14, color: textColor),
            ),
            if (trailingIcon != null) ...[_buildIcon(trailingIcon)],
          ],
        ),
      ),
    );
  }

  Padding _buildIcon(IconData? icon) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      );
}
