import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

class SectionTitle extends StatelessWidget {
  SectionTitle(
      {super.key,
      required this.mainTitle,
      required this.showMore,
      required this.press,
      this.subChild});

  String mainTitle;
  bool showMore;
  final Function? press;
  Widget? subChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mainTitle,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: ThemeColors.black,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Aller"),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            showMore
                ? InkWell(
                    onTap: press as void Function()?,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Voir Tout ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800,
                                fontFamily: "eastman"),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: ThemeColors.orangeDeep,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                  ),
            subChild ??
                const SizedBox(
                  width: 0,
                ),
          ])
        ],
      ),
    );
  }
}
