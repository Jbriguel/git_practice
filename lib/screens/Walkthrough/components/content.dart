import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/splashData.dart';

class SplashContent extends StatelessWidget {
  final void Function()? passer;
  final SplashItem data;
  final bool showButtonPasser;
  final Widget? bottomWidget;
  final Color backgroundColor;

  SplashContent({
    Key? key,
    required this.passer,
    required this.data,
    this.showButtonPasser = false,
    this.bottomWidget,
    this.backgroundColor = ThemeColors.white, // Default background color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double height = mediaQueryData.size.height - 50;
    final double width = mediaQueryData.size.width;
    final double width_reduce = mediaQueryData.size.width * 0.95;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: data.backgroundImage != null
            ? DecorationImage(
                image: AssetImage(data.backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          data.backgroundImage != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black12,
                          Colors.black26,
                          Colors.black54,
                          Colors.black87,
                          Colors.black87,
                          Colors.black87,
                          Colors.black,
                        ],
                      ),
                    ),
                    height: height * 0.7,
                    width: width,
                  ),
                )
              : const SizedBox.shrink(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: width_reduce,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: data.imagePath != null
                          ? CustomImageView(
                              alignment: Alignment.bottomCenter,
                              imagePath: data.imagePath!,
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width * 0.6,
                            )
                          : const SizedBox(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (data.title != null) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: AutoSizeText(
                                data.title ?? '',
                                presetFontSizes: const [32, 20, 15, 13],
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Speedee",
                                    // fontWeight: FontWeight.bold,
                                    color: data.titleColor),
                              ),
                            )
                          ],
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: AutoSizeText(
                              data.description,
                              presetFontSizes: const [14, 13, 12, 11, 10],
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: data.descritionColor),
                            ),
                          ),
                          if (bottomWidget != null)
                            Align(
                                alignment: Alignment.center,
                                child: bottomWidget!),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
