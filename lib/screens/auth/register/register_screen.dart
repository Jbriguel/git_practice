import 'dart:developer';
import 'dart:io';

import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/functions/uid_generator.dart';
import 'package:atelier_so/core/modeles/entreprise/entreprise.dart';
import 'package:atelier_so/core/modeles/owner/owner.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/navigations/root_name.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/auth/user_auth_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/auth/register/form/entreprise_register_form.dart';
import 'package:atelier_so/screens/auth/register/form/register_form.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:atelier_so/widgets/or.dart';
import 'package:atelier_so/widgets/tabs/flutter_advanced_segment.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String route = '/Customer/RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _selectedSegment = ValueNotifier('userInfos');
  final _formKey = GlobalKey<FormState>();
  UserRepository _userRepository = getIt<UserRepository>();

  ///********** [ FIELDS ]
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController nomCtrl = TextEditingController();
  final TextEditingController prenomCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  final TextEditingController entrepriseNameCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  File? imgFile;
  void addLogoFile(File? newFile) {
    setState(() {
      imgFile = newFile;
    });
  }

  ///********************************

  void createEntrepriseAccount(
      Owner _user, Entreprise entreprise, File? logoFile) async {
    //getIt<ContextDistributor>().setContext(context);
    LoadingDialog.show(context, title: "Veuillez patienter ...");

    //----------------------------------------------------------------
    await _userRepository
        .registerOwnerUser(
            owner: _user, entreprise: entreprise, logoFile: logoFile)
        .then((value) {
      if (value == true) {
        log("Création de compte ---");
        //Navigator.pop(context, true);
        context.goNamed(RootName.login_view);
      }
    }).whenComplete(() => LoadingDialog.hide(context));
  }

  ///**************************************

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double height = mediaQueryData.size.height;
    final double width = mediaQueryData.size.width;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ThemeColors.white,
          resizeToAvoidBottomInset: true,
          body: Form(
            key: _formKey,
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.init_back_3),
                  fit: BoxFit.cover,
                ),
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Center(
                  child: SingleChildScrollView(
                    child: Stack(children: [
                      Container(
                        color: Colors.black26,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.black.withOpacity(0.2),
                              shadowColor: Colors.black38,
                              surfaceTintColor: Colors.transparent,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: AutoSizeText(
                                        "Creer un compte",
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeColors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: AdvancedSegment(
                                        controller: _selectedSegment,
                                        sliderColor:
                                            ThemeColors.orangeBackground,
                                        activeStyle: const TextStyle(
                                          color: ThemeColors.greyDeep,
                                        ),
                                        backgroundColor:
                                            ThemeColors.white.withOpacity(0.4),
                                        segments: {
                                          'userInfos': 'Mes Informations',
                                          'entreprise': 'Mon Entreprise',
                                        },
                                      ),
                                    ),
                                    ValueListenableBuilder<String>(
                                      valueListenable: _selectedSegment,
                                      builder: (_, key, __) {
                                        if (_selectedSegment.value ==
                                            "userInfos") {
                                          return ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  child: AutoSizeText(
                                                    "Veuillez renseigner les informations pour vous connecter!",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            ThemeColors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5),
                                                  child: RegisterForm(
                                                      nomCtrl: nomCtrl,
                                                      phoneCtrl: phoneCtrl,
                                                      prenomCtrl: prenomCtrl,
                                                      pwdCtrl: pwdCtrl),
                                                ),
                                                DefaultButton(
                                                    paddingV: 10,
                                                    fontSize: 14,
                                                    height: 50,
                                                    textColor:
                                                        ThemeColors.greyDeep,
                                                    backColor:
                                                        ThemeColors.white,
                                                    text:
                                                        "Suivant".toUpperCase(),
                                                    press: () {
                                                      setState(() {
                                                        _selectedSegment.value =
                                                            "entreprise";
                                                      });
                                                      _selectedSegment
                                                          .notifyListeners();
                                                    }),
                                              ]);
                                        } else {
                                          return ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  child: AutoSizeText(
                                                    "Veuillez renseigner les informations de votre Entreprise",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            ThemeColors.white),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                    child: AddEntrepriseForm(
                                                        entrepriseNameCtrl:
                                                            entrepriseNameCtrl,
                                                        descriptionCtrl:
                                                            descriptionCtrl,
                                                        imgFile: imgFile,
                                                        addLogoFile:
                                                            addLogoFile)),
                                                DefaultButton(
                                                    paddingV: 10,
                                                    fontSize: 14,
                                                    height: 50,
                                                    textColor:
                                                        ThemeColors.greyDeep,
                                                    backColor:
                                                        ThemeColors.white,
                                                    text: "Créer compte"
                                                        .toUpperCase(),
                                                    press: () {
                                                      if (!_formKey
                                                          .currentState!
                                                          .validate()) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: const Text(
                                                            'Erreur! Veuillez remplir les informations',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade400,
                                                        ));
                                                      } else {
                                                        Entreprise entreprise =
                                                            Entreprise((p0) =>
                                                                p0
                                                                  ..uid = UIDGenerator()
                                                                      .generateUID()
                                                                  ..description =
                                                                      descriptionCtrl
                                                                          .text
                                                                  ..entrepriseName =
                                                                      entrepriseNameCtrl
                                                                          .text
                                                                  ..logoUrl = ''
                                                                  ..createdAt =
                                                                      DateTime
                                                                          .now());

                                                        Owner _owner = Owner(
                                                            (p0) => p0
                                                              ..uid = UIDGenerator()
                                                                  .generateUID()
                                                              ..password =
                                                                  pwdCtrl.text
                                                              ..nom =
                                                                  nomCtrl.text
                                                              ..prenom =
                                                                  prenomCtrl
                                                                      .text
                                                              ..phone =
                                                                  phoneCtrl.text
                                                              ..role = "owner"
                                                              ..entrepriseId =
                                                                  entreprise.uid
                                                              ..createdAt =
                                                                  DateTime
                                                                      .now());

                                                        createEntrepriseAccount(
                                                            _owner,
                                                            entreprise,
                                                            imgFile);
                                                      }
                                                      /* context.goNamed(
                                                          RootName.home_view);*/
                                                    }),
                                              ]);
                                        }
                                      },
                                    ),
                                  ]),
                            ),
                            loginAccount(),
                          ]),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class loginAccount extends StatelessWidget {
  const loginAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          color: ThemeColors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          const TextSpan(
            text: "J'ai un compte! ",
            style: TextStyle(
              color: ThemeColors.white,
              fontSize: 13,
            ),
          ),
          TextSpan(
            text: "Se connecter",
            style: const TextStyle(
              color: ThemeColors.orangeBackground,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decorationThickness: 0.5,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(RootName.login_view);
              },
          ),
        ]),
      ),
    );
  }
}
