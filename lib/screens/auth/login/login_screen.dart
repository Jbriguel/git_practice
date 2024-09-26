import 'dart:developer';

import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/navigations/root_name.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/auth/user_auth_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:atelier_so/widgets/or.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'form/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String route = '/Customer/LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  UserRepository _userRepository = getIt<UserRepository>();

  ///********** [ FIELDS ]
  TextEditingController identifyCtlr = TextEditingController();
  TextEditingController pwdCtlr = TextEditingController();
  TextEditingController phoneCtlr = TextEditingController();

  ///********************************

  void loginToMyAccount(String phone, String password, String identify) async {
    LoadingDialog.show(context, title: "Veuillez patienter ...");

    //----------------------------------------------------------------
    await _userRepository
        .login(phone: phone, password: password, identify: identify)
        .then((value) {
      if (value == true) {
        log("Login to my account ---");
        //Navigator.pop(context, true);
        context.goNamed(RootName.home_view);
      }
    }).whenComplete(() => LoadingDialog.hide(context));
  }

  //********** [ METHODS ]
  //**************************************

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

    return Scaffold(
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
                  Align(
                    alignment: Alignment.center,
                    child: Column(
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: CustomImageView(
                                    imagePath: Images.logo_white,
                                    fit: BoxFit.contain,
                                    height: 150,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: AutoSizeText(
                                    """Veuillez renseigner les informations pour vous connecter!""",
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontSize: 15, color: ThemeColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: LoginForm(
                                      identifyCtlr: identifyCtlr,
                                      pwdCtlr: pwdCtlr,
                                      phoneCtlr: phoneCtlr),
                                ),
                                DefaultButton(
                                    paddingV: 10,
                                    fontSize: 14,
                                    height: 50,
                                    textColor: ThemeColors.greyDeep,
                                    backColor: ThemeColors.white,
                                    text: "Se Connecter".toUpperCase(),
                                    press: () {
                                      if (_formKey.currentState!.validate()) {
                                        loginToMyAccount(
                                            phoneCtlr.text.trim(),
                                            pwdCtlr.text.trim(),
                                            identifyCtlr.text.trim());
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text(
                                            'Erreur! Veuillez remplir les informations',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red.shade400,
                                        ));
                                      }
                                    }),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      const TextSpan(
                                        text: "",
                                        style: TextStyle(
                                          color: ThemeColors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Mot de passe oublié!",
                                        style: const TextStyle(
                                          color: ThemeColors.orangeBackground,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Speedee",
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.wavy,
                                          decorationColor: Colors.white,
                                          decorationThickness: 0.5,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.goNamed(
                                                RootName.password_forget_view);
                                            //  Navigator.pushReplacementNamed(context, RegisterPage.route);
                                          },
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          creerAccount(),
                        ]),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class creerAccount extends StatelessWidget {
  const creerAccount({
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
            text: "Je n'ai pas de compte! ",
            style: TextStyle(
              color: ThemeColors.white,
              fontSize: 13,
            ),
          ),
          TextSpan(
            text: "Créer un compte",
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
                context.pushNamed(RootName.register_view);
              },
          ),
        ]),
      ),
    );
  }
}
