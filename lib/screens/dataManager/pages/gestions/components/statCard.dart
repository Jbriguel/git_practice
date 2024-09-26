import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class StatsItemCard extends StatelessWidget {
  StatsItemCard(
      {super.key,
      required this.text,
      required this.description,
      required this.couleur,
      required this.icon,
      required this.onPress});

  Color couleur;
  String text, description;
  IconData icon;

  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function()?,
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(5),
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.blueAccent.withOpacity(0.2),
                offset: Offset(0, 1),
                spreadRadius: 0.2),
          ],
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(children: [
          Positioned(
            bottom: -80,
            right: -80,
            child: Icon(
              icon,
              color: Colors.grey.shade400.withOpacity(0.1),
              size: 200,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeColors.redOrange.withOpacity(0.9),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Opacity(
                      opacity: 1,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: AutoSizeText(
                            text,
                            presetFontSizes: const [13, 12, 11],
                            maxLines: 1,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: AutoSizeText(
                            description,
                            presetFontSizes: const [12, 11, 10],
                            maxLines: 2,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: ThemeColors.greyDeep,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
