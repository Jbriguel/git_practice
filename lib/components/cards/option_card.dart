import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  OptionCard({
    Key? key,
    required this.image,
    required this.titre,
    required this.subText,
    required this.press,
  }) : super(key: key);
  final String image;
  final String titre;
  final String subText;
  final Function? press;
  //final Color bac;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press as void Function()?,
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 0.5,
        shadowColor: ThemeColors.greyInputBack.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //color: Colors.transparent,playstore
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.greyDeep.withOpacity(0.04),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  titre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Speedee',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    /*InkWell(
      onTap: press as void Function()?,
      child: Container(
        width: 200,
        height: 200,
        child: Card(
          color: Colors.white,
          elevation: 1.0,
          shadowColor: Colors.lightBlueAccent.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          //color: Colors.transparent,playstore
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Opacity(
                      opacity: 0.85,
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          titre,
                          presetFontSizes: [13, 12],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Speedee',
                          ),
                        ),
                        /* AutoSizeText(
                          subText,
                          presetFontSizes: [11, 10],
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Speedee',
                            color: Colors.blueGrey.shade400,
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
