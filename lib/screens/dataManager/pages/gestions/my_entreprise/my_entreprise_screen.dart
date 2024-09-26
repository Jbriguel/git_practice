import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/my_entreprise/ateliers_screen.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/my_entreprise/personnels_screen.dart';
import 'package:atelier_so/widgets/separator.dart';
import 'package:atelier_so/widgets/stats/exmple3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../components/statCard.dart';

class MyEntrepriseScreen extends StatefulWidget {
  const MyEntrepriseScreen({super.key});

  @override
  State<MyEntrepriseScreen> createState() => _MyEntrepriseScreenState();
}

class _MyEntrepriseScreenState extends State<MyEntrepriseScreen> {
  final ScrollController _controller = ScrollController();

  List<Map<String, dynamic>> _getActionData() {
    List<Map<String, dynamic>> list = [
      {
        "text": "Mon Personnel",
        "description": "Voir vos employés",
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
        "onPress": () {}
      },
      {
        "text": "Finances",
        "description": "Voir vos finances",
        "icon": Icons.graphic_eq,
        "couleur": ThemeColors.redOrange,
        "onPress": () {}
      },
    ];
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRepository>(builder: (context, userRepo, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Nom de l'entreprise\n",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: userRepo.user?.getFullName() ?? '--',
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // logoutBouton(),
            Image.asset(
              Images.logo2,
              fit: BoxFit.contain,
              height: 40,
              width: 40,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                child: GridView.builder(
                  controller: _controller,
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 150,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: _getActionData().length,
                  itemBuilder: (BuildContext ctx, index) {
                    Map<String, dynamic> action = _getActionData()[index];
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
              separator(
                  text: "Evolutions commandes", couleur: ThemeColors.greyDeep),
              Container(
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
                  child: BarChartSample6()),
            ],
          ),
        ),
      );
    });
  }
}
