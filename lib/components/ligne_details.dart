// ignore_for_file: non_constant_identifier_names

import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

class detailsLigne extends StatelessWidget {
  final String titre;
  final String data;
  final int nLigneTitre;
  final int nLigne;
  Color titreColor;
  Color dataColor;
  bool setContenu_bold;
  bool setContenu_nearbyTitle;
  bool setTitre_bold;
  bool setContenu_italic;
  bool showData;
  double maxFontTitre;
  double maxFontData;
  double paddingV;
  double paddingH;

  detailsLigne({
    super.key,
    required this.titre,
    required this.data,
    required this.nLigne,
    this.nLigneTitre = 1,
    this.titreColor = ThemeColors.greyDeep,
    this.dataColor = ThemeColors.greyDeep,
    this.setTitre_bold = true,
    this.setContenu_bold = false,
    this.setContenu_nearbyTitle = false,
    this.setContenu_italic = false,
    this.showData = true,
    this.maxFontData = 12,
    this.maxFontTitre = 12,
    this.paddingH = 5,
    this.paddingV = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AutoSizeText(
              "$titre ",
              minFontSize: 11,
              maxLines: nLigneTitre,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: maxFontTitre,
                  color: titreColor,
                  fontWeight: setTitre_bold ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ),
          if (showData == true) ...[
            Expanded(
              child: AutoSizeText(
                "$data ",
                maxLines: nLigne,
                minFontSize: 11,
                textAlign:
                    setContenu_nearbyTitle ? TextAlign.left : TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: maxFontData,
                    fontStyle:
                        setContenu_italic ? FontStyle.italic : FontStyle.normal,
                    color: dataColor,
                    fontWeight:
                        setContenu_bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
