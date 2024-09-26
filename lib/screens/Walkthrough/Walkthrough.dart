import 'dart:developer';

import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/navigations/root_name.dart';
import 'package:atelier_so/core/repository/appRepository/app_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/Walkthrough/data/splashData.dart';
import 'package:atelier_so/widgets/conditions_and_terms/condition_paper_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'components/content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});
  static String route = '/Customer/walktrough';
  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  int slideIndex = 0;
  bool _conditionAccepted = false;
  late PageController controller;
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);
  final int totalPages = 2; // Update the total number of pages

  @override
  void initState() {
    super.initState();
    controller = PageController();
    controller.addListener(() {
      currentPageNotifier.value = controller.page?.round() ?? 0;
    });
  }

  void _onNextPressed() {
    // Changer de page en augmentant le numéro de la page actuelle
    if (slideIndex < totalPages - 1) {
      controller.animateToPage(
        slideIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      //Navigation to client page
      print("##### [ to Login page ] ####");
      //  Navigator.pushNamed(context, LoginPage.route);
      showDialog(
        context: context,
        builder: (context) {
          return ConditionAndTermsPopUp();
        },
      ).then(
        (value) {
          if (value == true) {
            try {
              getIt<AppRepository>().setAppIsOpened();
              getIt<ContextDistributor>().context!.go("/");
            } catch (e) {
              log("Error: $e");
            }
          }
        },
      );
    }
  }

  List<SplashItem> splashData(BuildContext context) {
    List<SplashItem> data = [
      SplashItem(
          title: "Votre assistant couture",
          description:
              "Simplifiez votre quotidien de couturière avec Atelier So. Gagnez en efficacité, gérez vos commandes et vos clients en toute simplicité, et concentrez-vous sur ce qui compte vraiment : votre créativité.",
          imagePath: Images.sewing_machine,
          titleColor: ThemeColors.black),
      SplashItem(
          title: "Une gestion complète de votre atelier",
          description:
              "De la prise de rendez-vous à la livraison, Atelier So vous accompagne à chaque étape. Optimisez votre temps, améliorez la relation avec vos clients, et développez votre activité en toute sérénité.",
          imagePath: Images.logo_white,
          backgroundImage: Images.init_back_2,
          descritionColor: ThemeColors.white,
          titleColor: ThemeColors.white),
    ];
    return data;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            ),
          ),
          height: double.infinity,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
              children: splashData(context).asMap().entries.map((entry) {
                final index = entry.key;
                final itemData = entry.value;

                return SplashContent(
                  passer: () {},
                  data: itemData,
                  showButtonPasser: true,
                  bottomWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* if (slideIndex == 1) ...[
                        Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                    activeColor: ThemeColors.redOrange,
                                    side: const BorderSide(
                                        color: ThemeColors.white),
                                    value: _conditionAccepted,
                                    onChanged: (val) {
                                      setState(() {
                                        _conditionAccepted = val!;
                                      });
                                    }),
                                Flexible(
                                  child: Text(
                                    'Appuyer sur <<Accepter et continuer>> pour accepter les conditions d\'utilisations de ',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],*/
                      _buildPageIndicator(
                          inactiveColor: itemData.descritionColor),
                      DefaultButton(
                          fontSize: 15,
                          textColor: ThemeColors.white,
                          backColor: ThemeColors.redOrange,
                          text: slideIndex < totalPages - 1
                              ? "Suivant".toUpperCase()
                              : "Commencer".toUpperCase(),
                          press: () => _onNextPressed()),
                    ],
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }

  Widget _buildPageIndicator({required Color inactiveColor}) {
    return Container(
      height: 7,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: AnimatedSmoothIndicator(
        activeIndex: slideIndex,
        count: totalPages,
        effect: WormEffect(
          spacing: 4.2,
          activeDotColor: ThemeColors.redOrange,
          dotColor: inactiveColor,
          dotHeight: 5,
          dotWidth: 15,
        ),
      ),
    );
  }
}
