import 'package:atelier_so/animations/delay_animation.dart';
import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUpdateEmployer extends StatelessWidget {
  AddUpdateEmployer({
    Key? key,
    required this.prenomCtrl,
    required this.nomCtrl,
    required this.adresseCtrl,
    required this.phoneCtrl,
    required this.confirmPasswordCtrl,
    required this.passwordCtrl,
  }) : super(key: key);

  final TextEditingController nomCtrl;
  final TextEditingController prenomCtrl;
  final TextEditingController adresseCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 500,
      child: SizedBox(
        width: MediaQuery.of(context).size.width < 400
            ? MediaQuery.of(context).size.width * 0.8
            : MediaQuery.of(context).size.width * 0.8,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: nomCtrl,
                  hintText: "Saisir nom...",
                  textInputAction: TextInputAction.next,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  prefix: const Icon(
                    CupertinoIcons.person,
                    color: ThemeColors.greyDeep,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return 'Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: prenomCtrl,
                  hintText: "Saisir prenom...",
                  textInputAction: TextInputAction.next,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  prefix: const Icon(
                    CupertinoIcons.person,
                    color: ThemeColors.greyDeep,
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return 'Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: adresseCtrl,
                  hintText: "Adresse",
                  textInputAction: TextInputAction.next,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  prefix: const Icon(
                    CupertinoIcons.location,
                    color: ThemeColors.greyDeep,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: phoneCtrl,
                  hintText: "Numéro de Téléphone",
                  textInputAction: TextInputAction.done,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  prefix: const Icon(
                    CupertinoIcons.phone,
                    color: ThemeColors.greyDeep,
                  ),
                  textInputType: TextInputType.phone,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return 'Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: passwordCtrl,
                  hintText: "Saisir mot de passe",
                  textInputAction: TextInputAction.done,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  prefix: const Icon(
                    CupertinoIcons.lock,
                    color: ThemeColors.greyDeep,
                  ),
                  textInputType: TextInputType.visiblePassword,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return 'Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CustomTextFormField(
                  controller: confirmPasswordCtrl,
                  hintText: "Confirmer mot de passe",
                  textInputAction: TextInputAction.done,
                  textColor: ThemeColors.greyDeep,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.1),
                  filled: true,
                  prefix: const Icon(
                    CupertinoIcons.lock,
                    color: ThemeColors.greyDeep,
                  ),
                  textInputType: TextInputType.visiblePassword,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return 'Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
            ]),
      ),
    );
  }
}
