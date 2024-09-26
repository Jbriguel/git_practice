import 'dart:io';

import 'package:atelier_so/components/default_btn/custom_elevated_button.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/repository/modeleRepository/modele_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/services/image_client/image_client.dart';
import 'package:atelier_so/core/services/image_client/image_client_extension.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/modeles/addModele.dart';
import 'package:atelier_so/screens/modeles/widgets/selecteProprietyAlert.dart';
import 'package:atelier_so/widgets/PopUps/add_propriety.popUp.dart';
import 'package:atelier_so/widgets/PopUps/choose_modele_icon.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/separator.dart';

class EditerModeleBody extends StatefulWidget {
  final Function press;
  Modele modele;

  EditerModeleBody({required this.press, required this.modele});

  @override
  State<EditerModeleBody> createState() => _AddModeleBodyState();
}

class _AddModeleBodyState extends State<EditerModeleBody> {
  File? imgFile;
  String? image;
  final imgPicker = ImagePicker();
  String? fileName;
  String? _selectedGenre;

  List<Propriety> Propieties = <Propriety>[];
  ModeleRepository _modeleRepository = getIt<ModeleRepository>();

  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  void init() {
    setState(() {
      // Propieties = widget.modele.proprieties.asList();
      nameCtrl.text = widget.modele.name ?? '';
      descriptionCtrl.text = widget.modele.description ?? '';
      fileName = widget.modele.imgPath;
      image = null;
      imgFile =
          widget.modele.imgPath != null ? File(widget.modele.imgPath!) : null;
      _selectedGenre = widget.modele.genderType;
    });
  }

  void clearFields() {
    setState(() {
      Propieties.clear();
      nameCtrl.clear();
      descriptionCtrl.clear();
      fileName = null;
      image = null;
      imgFile = null;
      _selectedGenre = null;
      _formKey2.currentState!.reset();
    });
  }

  SelectPropriety(BuildContext context, MyInheritedWidgetState state) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => SelectProprietyAlert(
        state: state,
      ),
    ).then((value) {});
  }

  void openCamera() async {
    final XFile? imgCamera = await getIt<ImageClient>().takePhoto();
    setState(() {
      image = null;
      imgFile = File(imgCamera!.path);
      fileName = imgCamera.name;
    });
  }

  void openGallery() async {
    final XFile? imgGallery = await getIt<ImageClient>().selectImage();
    setState(() {
      image = null;
      imgFile = File(imgGallery!.path);
      fileName = imgGallery.name;
    });
  }

  choisirIcones(String img) {
    setState(() {
      image = img;
      imgFile = null;
      isChoice(img);
    });
    // change();
  }

  isChoice(String img) {
    if (img == image) {
      return true;
    } else {
      return false;
    }
  }

  choisirImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChooseModeleIconAlert(
            onSelected: choisirIcones,
            imageSelected: image,
          );
        });
  }

  void saveModele(MyInheritedWidgetState state) async {
    LoadingDialog.show(context);

    Modele modele = Modele(
      (b) => b
        ..uid = widget.modele.uid
        ..name = nameCtrl.text
        ..description = descriptionCtrl.text
        ..genderType = _selectedGenre
        ..createdAt = widget.modele.createdAt
        ..modifiedAt = DateTime.now().toIso8601String()
        ..proprieties = ListBuilder(BuiltList<Propriety>([]))
        ..imgPath = imgFile != null ? imgFile!.path : image ?? Images.mannequin,
    );

    _modeleRepository
        .updateModele(modele, state.proprieties_selected)
        .then((retour) {
      if (retour == true) {
        clearFields();
        setState(() {});
        Navigator.pop(context, true);
      }
      //
    }).whenComplete(() => LoadingDialog.hide(context));
  }

  Widget displayImage() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue, width: 2),
          color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: CustomImageView(
        imagePath: image ?? imgFile?.path ?? Images.mannequin,
        fit: (imgFile == null) ? BoxFit.contain : BoxFit.cover,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Editer Modèle",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.save_outlined,
                color: ThemeColors.redOrange,
              ),
              color: Colors.black,
              onPressed: () async {
                saveModele(state);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              displayImage(),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  CustomElevatedButton(
                    text: 'Choisir Image',
                    iconData: Icons.image,
                    onPressed: openGallery,
                  ),
                  const SizedBox(width: 5),
                  CustomElevatedButton(
                    text: 'Utiliser Icons',
                    iconData: Icons.art_track_rounded,
                    textColor: ThemeColors.greyDeep,
                    onPressed: choisirImage,
                  ),
                  const SizedBox(width: 5),
                  CustomElevatedButton(
                    text: 'Prendre Photo',
                    iconData: Icons.camera_alt_outlined,
                    onPressed: openCamera,
                  ),
                ],
              ),
              /////////////////////Add name //////////////////////
              separator(text: 'Informations Modèle'),
              ////////////////////////////////////////////////////
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: CustomTextFormField(
                  controller: nameCtrl,
                  hintText: "Saisir nom du modele...",
                  textInputAction: TextInputAction.none,
                  textColor: Colors.black87,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.2),
                  filled: true,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim() == "") {
                      return 'Champ requis!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: CustomTextFormField(
                  controller: descriptionCtrl,
                  hintText: "Saisir description ...",
                  textInputAction: TextInputAction.none,
                  textColor: Colors.black87,
                  fillColor: ThemeColors.greyDeep.withOpacity(0.2),
                  filled: true,
                  maxLines: 4,
                ),
              ),
/////////////////////Add name //////////////////////
              separator(text: 'Les mesures prises'),
              ////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        showCheckmark: false,
                        label: const Text(
                          'Homme',
                          style: TextStyle(
                              color: ThemeColors.greyDeep, fontSize: 16),
                        ),
                        selected: _selectedGenre == 'Homme',
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedGenre = selected ? 'Homme' : null;
                          });
                        },
                        selectedColor: ThemeColors.orangeBackground,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5), // Espacement entre les chips
                    Expanded(
                      child: ChoiceChip(
                        showCheckmark: false,
                        label: const Text(
                          'Femme',
                          style: TextStyle(
                              color: ThemeColors.greyDeep, fontSize: 16),
                        ),
                        selected: _selectedGenre == 'Femme',
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedGenre = selected ? 'Femme' : null;
                          });
                        },
                        selectedColor: ThemeColors.orangeBackground,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5), // Espacement entre les chips
                    Expanded(
                      child: ChoiceChip(
                        showCheckmark: false,
                        label: const Text(
                          'Enfant',
                          style: TextStyle(
                              color: ThemeColors.greyDeep, fontSize: 16),
                        ),
                        selected: _selectedGenre == 'Enfant',
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedGenre = selected ? 'Enfant' : null;
                          });
                        },
                        selectedColor: ThemeColors.orangeBackground,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /////////////////////Add name //////////////////////
              separator(text: 'Les mesures prises'),
              ////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 10, bottom: 15.0),
                child: Wrap(
                  spacing: 5,
                  children:
                      List.generate(state.proprieties_selected.length, (index) {
                    Propriety propiety = state.proprieties_selected[index];
                    return state.inputChips(propiety, index);
                  }),
                ),
              ),
              //Add button
              CustomElevatedButton(
                text: 'Ajouter Proprieté',
                iconData: Icons.add_circle_outline,
                onPressed: () => SelectPropriety(context, state),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
