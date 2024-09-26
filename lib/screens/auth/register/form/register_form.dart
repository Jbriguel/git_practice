import 'package:atelier_so/animations/delay_animation.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController pwdCtrl;
  final TextEditingController nomCtrl;
  final TextEditingController prenomCtrl;
  final TextEditingController phoneCtrl;

  RegisterForm(
      {required this.nomCtrl,
      required this.phoneCtrl,
      required this.prenomCtrl,
      required this.pwdCtrl});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 1000,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Nom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CustomTextFormField(
                autofocus: false,
                controller: widget.nomCtrl,
                hintText: "Nom",
                textInputAction: TextInputAction.done,
                textColor: Colors.white,
                fillColor: ThemeColors.white.withOpacity(0.8),
                filled: false,
                prefix:
                    const Icon(CupertinoIcons.person, color: ThemeColors.white),
                validator: (text) {
                  if (text == null || text.isEmpty || text.trim() == "") {
                    return '\u26A0 Champ requis!';
                  }
                  return null;
                },
              ),
            ),
            // Prénom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CustomTextFormField(
                autofocus: false,
                controller: widget.prenomCtrl,
                hintText: "Prénom",
                textInputAction: TextInputAction.done,
                textColor: Colors.white,
                fillColor: ThemeColors.white.withOpacity(0.8),
                filled: false,
                prefix:
                    const Icon(CupertinoIcons.person, color: ThemeColors.white),
                validator: (text) {
                  if (text == null || text.isEmpty || text.trim() == "") {
                    return '\u26A0 Champ requis!';
                  }
                  return null;
                },
              ),
            ),
            // Email ou numéro de téléphone
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CustomTextFormField(
                autofocus: false,
                controller: widget.phoneCtrl,
                hintText: "Numéro Téléphone",
                textInputAction: TextInputAction.done,
                textColor: Colors.white,
                fillColor: ThemeColors.white.withOpacity(0.8),
                filled: false,
                prefix: const Icon(CupertinoIcons.device_phone_portrait,
                    color: ThemeColors.white),
                validator: (text) {
                  if (text == null || text.isEmpty || text.trim() == "") {
                    return '\u26A0 Champ requis!';
                  }
                  return null;
                },
              ),
            ),
            // Mot de passe
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CustomTextFormField(
                autofocus: false,
                obscureText: true,
                controller: widget.pwdCtrl,
                hintText: "Mot de passe",
                textInputAction: TextInputAction.done,
                textColor: Colors.white,
                fillColor: ThemeColors.white.withOpacity(0.8),
                filled: false,
                prefix:
                    const Icon(CupertinoIcons.lock, color: ThemeColors.white),
                validator: (text) {
                  if (text == null || text.isEmpty || text.trim() == "") {
                    return '\u26A0 Mot de passe requis!';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
