import 'dart:io';

import 'package:atelier_so/components/default_btn/custom_elevated_button.dart';
import 'package:atelier_so/core/services/image_client/image_client.dart';
import 'package:atelier_so/core/services/image_client/image_client_extension.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:atelier_so/animations/delay_animation.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddEntrepriseForm extends StatefulWidget {
  final TextEditingController entrepriseNameCtrl;
  final TextEditingController descriptionCtrl;
  File? imgFile;
  void Function(File? newFile) addLogoFile;
  AddEntrepriseForm(
      {required this.entrepriseNameCtrl,
      required this.descriptionCtrl,
      required this.imgFile,
      required this.addLogoFile});
  @override
  _AddEntrepriseFormState createState() => _AddEntrepriseFormState();
}

class _AddEntrepriseFormState extends State<AddEntrepriseForm> {

  final TextEditingController _logoUrlController = TextEditingController();

  //-------------------------------------------------------------//

  final imgPicker = ImagePicker();
  String? fileName;
  void openGallery() async {
    final XFile? imgGallery = await getIt<ImageClient>().selectImage();
    setState(() {
      widget.imgFile = File(imgGallery!.path);
      fileName = imgGallery.name;
      _logoUrlController.text = fileName ?? '';
      widget.addLogoFile(File(imgGallery.path));
    });
  }

  //-------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 1000,
      child:SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Nom de l'entreprise
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomTextFormField(
                  autofocus: false,
                  controller: widget.entrepriseNameCtrl,
                  hintText: "Nom de l'entreprise",
                  textInputAction: TextInputAction.done,
                  textColor: Colors.white,
                  fillColor: ThemeColors.white.withOpacity(0.8),
                  filled: false,
                  prefix: const Icon(CupertinoIcons.building_2_fill,
                      color: ThemeColors.white),
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return '\u26A0 Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              // Logo URL
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        autofocus: false,
                        controller: _logoUrlController,
                        hintText: "logo",
                        textInputAction: TextInputAction.done,
                        textColor: Colors.white,
                        fillColor: ThemeColors.white.withOpacity(0.8),
                        filled: false,
                        prefix: const Icon(CupertinoIcons.photo_fill,
                            color: ThemeColors.white),
                        validator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              text.trim() == "") {
                            return '\u26A0 Champ requis!';
                          }
                          return null;
                        },
                      ),
                    ),
                    CustomElevatedIconButton(
                      iconData: CupertinoIcons.photo_fill,
                      onPressed: () => openGallery(),
                    ),
                    if (widget.imgFile != null) ...[
                      CustomElevatedIconButton(
                          iconData: CupertinoIcons.delete,
                          onPressed: () {
                            setState(() {
                              widget.imgFile == null;
                              fileName == null;
                              _logoUrlController.clear();
                            });
                          })
                    ]
                  ],
                ),
              ),
              // Description de l'entreprise
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: CustomTextFormField(
                  autofocus: false,
                  controller: widget.descriptionCtrl,
                  hintText: "Description de l'entreprise",
                  textInputAction: TextInputAction.done,
                  textColor: Colors.white,
                  fillColor: ThemeColors.white.withOpacity(0.8),
                  filled: false,
                  maxLines: 4,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return '\u26A0 Champ requis!';
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
