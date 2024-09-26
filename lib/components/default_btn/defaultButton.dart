import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      this.text,
      required this.textColor,
      required this.backColor,
      this.borderColor,
      this.paddingV = 14.0,
      this.paddingH = 10.0,
      this.height = 50,
      this.press,
      this.radius = 10,
      this.elevation = 1,
      this.fontSize = 14})
      : super(key: key);
  final String? text;
  final Color textColor;
  final Color backColor;
  final Function? press;
  final double paddingV;
  final double paddingH;
  final double height;
  final double radius;
  final Color? borderColor;
  final double elevation;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
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
          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, height),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
              fontFamily: 'Speedee', fontSize: fontSize, color: textColor),
        ),
      ),
    );
  }
}
