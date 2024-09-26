import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/navigations/root_name.dart';
import 'package:atelier_so/core/repository/appRepository/app_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConditionAndTermsPopUp extends StatefulWidget {
  ConditionAndTermsPopUp({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => ConditionAndTermsPopUpState();
}

class ConditionAndTermsPopUpState extends State<ConditionAndTermsPopUp>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  ScrollController _scrollCtrl = ScrollController();

  final _formKey = GlobalKey<FormState>();
  bool remember = false;

  Color colors = const Color(0xffe7123b).withOpacity(0.8);

  //-------------------------------------------------------------//
  TextStyle style = TextStyle(fontFamily: 'Aller');

//##############################################//

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  bool _conditionAccepted = false;

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Center(
        child: Form(
          key: _formKey,
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: OrientationBuilder(builder: (context, orientation) {
                return Stack(
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width < 400
                            ? MediaQuery.of(context).size.width * 0.9
                            : 380,
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            //TItre
                            Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.7),
                              child: Scrollbar(
                                controller: _scrollCtrl,
                                interactive: true,
                                trackVisibility: true,
                                thumbVisibility: true,
                                radius: const Radius.circular(10),
                                scrollbarOrientation:
                                    ScrollbarOrientation.right,
                                thickness: 2.0,
                                child: SingleChildScrollView(
                                  controller: _scrollCtrl,
                                  child: Column(
                                    children: [
                                      CustomImageView(
                                        imagePath: Images.logo_noBack,
                                        fit: BoxFit.contain,
                                        width: 200,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Text(
                                          "Conditions Générales d'Utilisation de AtelierSo",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Text(
                                          "Bienvenue sur Atelier So, votre application dédiée à la gestion de vos projets de couture. En utilisant cette application, vous acceptez de respecter les termes et conditions suivants :",
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                      ),
                                      //--------------------------------//

                                      title(
                                          text: "Utilisation de l'Application"),
                                      content(
                                          index: "",
                                          contenu:
                                              "Atelier So est conçue pour vous assister dans l'organisation et le suivi de vos projets de couture. Vous vous engagez à utiliser l'application de manière légale et conforme aux usages prévus, tout en respectant les droits des autres utilisateurs."),

                                      title(
                                          text:
                                              "Protection des Données Personnelles"),
                                      content(
                                          index: "",
                                          contenu:
                                              "Vos données personnelles sont protégées conformément aux lois en vigueur au Mali. Nous recueillons certaines informations pour améliorer votre expérience utilisateur, mais elles ne seront ni partagées ni vendues à des tiers sans votre consentement explicite."),
                                      title(
                                          text:
                                              "Responsabilité de l'Utilisateur"),
                                      content(
                                          index: "",
                                          contenu:
                                              "Bien que nous nous efforcions de fournir un service fiable et sans interruptions, nous ne garantissons pas que l'application sera exempte de bugs ou d'interruptions. Vous êtes responsable de la gestion de vos données et des informations que vous enregistrez via l'application."),
                                      title(
                                          text:
                                              "Mises à Jour et Modifications"),
                                      content(
                                          index: "",
                                          contenu:
                                              "Nous nous réservons le droit de modifier ou de mettre à jour ces conditions à tout moment. En cas de changements majeurs, vous serez notifié dans l'application, et vous devrez accepter les nouvelles conditions pour continuer à utiliser Atelier So."),

                                      title(
                                          text: "Territorialité et Expansion"),
                                      content(
                                          index: "",
                                          contenu:
                                              "Bien que Atelier So soit initialement disponible au Mali, nous prévoyons d'étendre nos services à d'autres régions. Les lois et réglementations locales peuvent varier en fonction de votre localisation future."),

                                      title(text: "Résiliation"),
                                      content(
                                          index: "",
                                          contenu:
                                              "En cas de non-respect des présentes conditions, nous nous réservons le droit de suspendre ou de résilier votre accès à l'application, avec ou sans préavis."),
                                      /*
                                        title(
                                            text:
                                                "Certification pour les Entreprises"),
                                        subTitle(text: "Comment ça marche ?"),
                        
                                        // content(index: "1", titre: "", contenu: " "),
                                        content(
                                            index: "1",
                                            titre: "Soumettez vos Documents",
                                            contenu:
                                                " Les entreprises doivent fournir des documents tels que le registre de commerce et les pièces d'identité des représentants légaux."),
                                        content(
                                            index: "2",
                                            titre: "Vérification Rigoureuse",
                                            contenu:
                                                "Notre équipe dédiée effectuera une vérification approfondie pour assurer la validité de vos informations."),
                                        content(
                                            index: "3",
                                            titre: "Notification en Temps Réel",
                                            contenu:
                                                "Soyez informé du statut de votre certification. En cas d'approbation, votre profil sera agrémenté d'un badge de confiance."),
                                                */
                                      //--------------------------------//
                                      //--------------------------------//
                                      title(
                                          text:
                                              "J'accepte les termes et conditions d'utilisation de Atelier So.",
                                          color: ThemeColors.greyDeep),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Center(
                                          child: Row(
                                            children: <Widget>[
                                              Checkbox(
                                                  activeColor:
                                                      ThemeColors.redOrange,
                                                  side: const BorderSide(
                                                      color:
                                                          ThemeColors.greyDeep),
                                                  value: _conditionAccepted,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _conditionAccepted = val!;
                                                    });
                                                  }),
                                              const Flexible(
                                                child: Text(
                                                  "J'accepte",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color:
                                                          ThemeColors.greyDeep,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            DefaultButton(
                                fontSize: 15,
                                textColor: _conditionAccepted
                                    ? ThemeColors.white
                                    : ThemeColors.greyDeep,
                                backColor: _conditionAccepted
                                    ? ThemeColors.redOrange
                                    : ThemeColors.greyDisable,
                                text: "ACCPETER & COMMNENCER".toUpperCase(),
                                press: () {
                                  if (_conditionAccepted == true) {
                                    // print("condition accepted");
                                    // Navigator.of(context).pop(true);
                                    LoadingDialog.show(context);
                                    getIt<AppRepository>().setAppIsOpened();
                                    Future.delayed(Durations.medium2, () {
                                      context.go(RootName.login_path);
                                    });
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    // --------------------------//

                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: (() => Navigator.of(context).pop()),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.5, color: Colors.white),
                          ),
                          child: const Center(
                            child:
                                Icon(Icons.close, color: ThemeColors.redOrange),
                          ),
                        ),
                      ),
                    )
                    // ----------------------------//
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  String Information =
      "Nous comprenons l'importance de la confiance dans notre communauté, c'est pourquoi nous proposons un processus de certification de compte transparent et adapté à vos besoins, que vous soyez un particulier ou une entreprise.";

  title({required String text, Color color = ThemeColors.redOrange}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ),
      );

  subTitle({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      );

  content({String? index, String? titre, required String contenu}) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText.rich(
            TextSpan(text: '$index. ', children: [
              TextSpan(
                text: titre != null ? "$titre : " : '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: contenu,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ]),
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.black, fontSize: 13),
            minFontSize: 12,
          ),
        ),
      );
}
