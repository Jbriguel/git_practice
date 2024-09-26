import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/components/statCard.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/my_entreprise/ateliers_screen.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/my_entreprise/personnels_screen.dart';
import 'package:atelier_so/widgets/PopUps/info_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/header.dart';

import 'components/my_fields.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _controller = ScrollController();

  List<Map<String, dynamic>> _getActionData() {
    List<Map<String, dynamic>> list = [
      {
        "text": "Mon Personnel",
        "description": "Voir vos postes",
        "icon": CupertinoIcons.person_2,
        "couleur": ThemeColors.redOrange,
        "onPress": () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MonPersonnelScreen(),
            ),
          );
        }
      },
      {
        "text": "Ateliers",
        "description": "Voir vos ateliers",
        "icon": CupertinoIcons.scissors_alt,
        "couleur": ThemeColors.redOrange,
        "onPress": () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MesAteliersScreen(),
            ),
          );
        }
      },
      {
        "text": "informations",
        "description": "Informations sur l'entreprise",
        "icon": Icons.business_center,
        "couleur": ThemeColors.redOrange,
        "onPress": () {
          showDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) => EntrepriseDetailsAlert(editer: () {  }, 
                 
                ),
              );
        }
      },
      {
        "text": "Rapports",
        "description": "Voir vos rapports",
        "icon": Icons.document_scanner,
        "couleur": ThemeColors.redOrange,
        "onPress": () {}
      },
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 2),
                        child: GridView.builder(
                          controller: _controller,
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 150,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                          itemCount: _getActionData().length,
                          itemBuilder: (BuildContext ctx, index) {
                            Map<String, dynamic> action =
                                _getActionData()[index];
                            return StatsItemCard(
                              text: action["text"],
                              description: action["description"],
                              couleur: action["couleur"],
                              icon: action["icon"],
                              onPress: action["onPress"],
                            );
                          },
                        ),
                      ),
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
