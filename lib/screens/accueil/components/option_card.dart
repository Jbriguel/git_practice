import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';

class optionCard extends StatelessWidget {
  optionCard(
      {super.key,
      required this.image,
      required this.titre,
      required this.subTitle,
      required this.press});

  final String image;
  final String titre;
  final String subTitle;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(children: <Widget>[
            Expanded(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                // constraints.maxWidth et constraints.maxHeight donnent la taille disponible
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;

                return CustomImageView(
                    imagePath: image,
                    fit: BoxFit.contain,
                    height: height * 0.5,
                    width: width * 0.5);
              }),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      titre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Speedee',
                          fontSize: 18,
                          color: ThemeColors.greyDeep,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      subTitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
