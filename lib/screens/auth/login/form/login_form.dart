import 'package:atelier_so/animations/delay_animation.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  TextEditingController identifyCtlr;
  TextEditingController pwdCtlr;
  TextEditingController phoneCtlr;

  LoginForm(
      {super.key,
      required this.identifyCtlr,
      required this.pwdCtlr,
      required this.phoneCtlr});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Color colors = const Color(0xffe7123b).withOpacity(0.8);
  final TextEditingController _identifyController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //-------------------------------------------------------------//
  String message = '';

  bool reload = false;

  void setMessage(String msg) {
    setState(() {
      message = msg;
    });
  }

  //-------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 1000,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // //Le Email
              // InputTextField(
              //     type: "email",
              //     text: "Adresse Email",
              //     controller: _EmailController,
              //     prefixIcon: true),

              // const SizedBox(
              //   height: 10,
              // ), // Le password
              // InputTextField(
              //     type: "password",
              //     text: "Mot de passe ",
              //     controller: _PwdController,
              //     prefixIcon: true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomTextFormField(
                  autofocus: false,
                  controller: widget.phoneCtlr,
                  hintText: "Numero Téléphone",
                  textInputAction: TextInputAction.done,
                  textColor: Colors.white,
                  fillColor: ThemeColors.white.withOpacity(0.8),
                  filled: false,
                  prefix: const Icon(
                    CupertinoIcons.device_phone_portrait,
                    color: ThemeColors.white,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return '\u26A0 Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomTextFormField(
                  autofocus: false,
                  obscureText: true,
                  controller: widget.pwdCtlr,
                  hintText: "Mot de passe",
                  textInputAction: TextInputAction.done,
                  textColor: Colors.white,
                  fillColor: ThemeColors.white.withOpacity(0.8),
                  filled: false,
                  prefix: const Icon(
                    CupertinoIcons.lock,
                    color: ThemeColors.white,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return '\u26A0 Mot de passe requis!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomTextFormField(
                  autofocus: false,
                  controller: widget.identifyCtlr,
                  hintText: "Identifiant Atelier",
                  textInputAction: TextInputAction.done,
                  textColor: Colors.white,
                  fillColor: ThemeColors.white.withOpacity(0.8),
                  filled: false,
                  prefix: const Icon(
                    Icons.key_rounded,
                    color: ThemeColors.white,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
