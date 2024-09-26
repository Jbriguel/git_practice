import 'package:atelier_so/core/modeles/employe/employe.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeCardLineMode extends StatelessWidget {
  Employe user;
  bool isSelected;
  void Function(Employe user) onSelected;
  EmployeCardLineMode({
    super.key,
    required this.user,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => onSelected(user)),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.grey.shade400,
        color: Colors.grey.shade50,
        surfaceTintColor: Colors.white,
        elevation: 0.2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: isSelected ? ThemeColors.redOrange : Colors.grey.shade100,
            width: 1.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ThemeColors.redOrange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: CustomImageView(
                  imagePath: Images.afro_man_avatar,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                  radius: BorderRadius.circular(25),
                ),
              ),
              const SizedBox(
                width: 5,
                height: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      user.name,
                      minFontSize: 10,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColors.greyDeep.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 5.0),
                      child: AutoSizeText(
                        user.phone ?? '---',
                        textAlign: TextAlign.left,
                        presetFontSizes: const [11, 10],
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontFamily: "Aller",
                              color: ThemeColors.greyDeep,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                  isSelected
                      ? CupertinoIcons.check_mark
                      : CupertinoIcons.circle,
                  color: isSelected
                      ? ThemeColors.redOrange
                      : ThemeColors.greyDeep),
            ],
          ),
        ),
      ),
    );
  }
}
