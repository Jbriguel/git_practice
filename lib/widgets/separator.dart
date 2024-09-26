import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class separator extends StatelessWidget {
  separator(
      {super.key, required this.text, this.couleur = ThemeColors.greyDeep});

  String text;
  Color couleur;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              height: 1,
              color: couleur.withOpacity(0.6),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 8,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Speedee',
                  fontSize: 14,
                  color: couleur.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 1,
              color: couleur.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
