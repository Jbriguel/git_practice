import 'package:atelier_so/animations/delay_animation.dart';
import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClientForm extends StatelessWidget {
  AddClientForm({
    Key? key,
    required this.nomFullCtrl,
    required this.adresseCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
  }) : super(key: key);

  final TextEditingController nomFullCtrl;
  final TextEditingController adresseCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 500,
      child: Form(
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 400
              ? MediaQuery.of(context).size.width * 0.95
              : MediaQuery.of(context).size.width * 0.8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 5),
                //   child: CustomTextFormField(
                //     controller: numeroSerieCtrl,
                //     hintText: "Numéro de Série",
                //     textInputAction: TextInputAction.next,
                //     textColor: Colors.black87,
                //     fillColor: ThemeColors.greyDeep.withOpacity(0.2),
                //     filled: true,
                //     prefix: const Icon(
                //       CupertinoIcons.device_phone_portrait,
                //       color: ThemeColors.greyDeep,
                //     ),
                //     validator: (text) {
                //       if (text == null || text.isEmpty || text.trim() == "") {
                //         return 'Champ requis!';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomTextFormField(
                    controller: nomFullCtrl,
                    hintText: "Nom Complet",
                    textInputAction: TextInputAction.next,
                    textColor: Colors.black87,
                    fillColor: ThemeColors.greyDeep.withOpacity(0.2),
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
                    textColor: Colors.black87,
                    fillColor: ThemeColors.greyDeep.withOpacity(0.2),
                    filled: true,
                    prefix: const Icon(
                      CupertinoIcons.location,
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
                    controller: phoneCtrl,
                    hintText: "Numéro de Téléphone",
                    textInputAction: TextInputAction.done,
                    textColor: Colors.black87,
                    fillColor: ThemeColors.greyDeep.withOpacity(0.2),
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
                    controller: emailCtrl,
                    hintText: "Adresse Email",
                    textInputAction: TextInputAction.done,
                    textColor: Colors.black87,
                    fillColor: ThemeColors.greyDeep.withOpacity(0.2),
                    filled: true,
                    prefix: const Icon(
                      CupertinoIcons.at,
                      color: ThemeColors.greyDeep,
                    ),
                    textInputType: TextInputType.emailAddress,
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
      ),
    );
  }
}
