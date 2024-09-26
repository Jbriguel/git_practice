import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GestionItemCard extends StatelessWidget {
  final IconData icon;
  final String titre;
  final String subText;
  final Color couleur;
  final Color subTitleCouleur;
  final Function onPress;
  final bool isLocked;
  final bool isPremium; // Nouveau paramètre pour indiquer si c'est premium

  GestionItemCard({
    super.key,
    required this.icon,
    required this.titre,
    required this.subText,
    required this.couleur,
    this.subTitleCouleur = ThemeColors.greyDeep,
    required this.onPress,
    this.isLocked = false, // Valeur par défaut non verrouillée
    this.isPremium = false, // Valeur par défaut non premium
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.deepOrange.shade300,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: isLocked
              ? null
              : (() => onPress()), // Désactive l'onTap si verrouillé
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: isLocked
                            ? Colors.grey
                            : couleur, // Icône grisée si verrouillé
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        child: Text(
                          titre,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: isLocked
                                ? Colors.grey
                                : Colors.black, // Titre grisé si verrouillé
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        subText,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: isLocked
                              ? Colors.grey
                              : subTitleCouleur, // Texte grisé si verrouillé
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isPremium) // Afficher la couronne si premium
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.workspace_premium,
                      color: Colors.amber), // Icône de couronne premium
                ),
              if (isLocked) // Afficher le cadenas si verrouillé
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.lock,
                      color: Colors.grey), // Icône de verrouillage
                ),
            ],
          ),
        ),
      ),
    );
  }
}
