import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      this.width,
      this.controller,
      this.focusNode,
      this.autofocus = true,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.suffix,
      this.contentPadding,
      this.fillColor,
      this.textColor = Colors.white,
      this.filled = true,
      this.enable = true,
      this.validator,
      this.textStyle})
      : super(
          key: key,
        );

  final bool enable;

  final double? width;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final Widget? prefix;

  final Widget? suffix;

  final EdgeInsets? contentPadding;

  final Color? fillColor;

  final Color textColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final TextStyle? textStyle;
  double radius = 15.0;
  @override
  Widget build(BuildContext context) {
    return textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          enabled: enable,
          controller: controller,
          //focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus ?? false,
          style: (textStyle ?? TextStyle()).copyWith(
              color: textColor.withOpacity(0.8),
              fontSize: 14,
              fontFamily: "Speedee",
              fontWeight: FontWeight.w500),
          obscureText: obscureText ?? false,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          onTapOutside: (event) {
            print('onTapOutside');
          },
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: (textStyle ?? TextStyle()).copyWith(
          color: textColor.withOpacity(0.8),
          fontFamily: "Aller",
          fontSize: 14,
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        fillColor: fillColor ?? Colors.white70.withOpacity(0.19),
        filled: filled,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: fillColor ?? Colors.white70.withOpacity(0.19),
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: fillColor ?? Colors.white70.withOpacity(0.19),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: fillColor ?? Colors.white70.withOpacity(0.19),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: fillColor ?? Colors.white70.withOpacity(0.19),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.red.shade300,
          ),
        ), /*InputBorder.none,
        */
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillWhiteA => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      );
}
