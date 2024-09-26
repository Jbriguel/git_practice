import 'dart:io';

import 'package:atelier_so/components/default_btn/custom_elevated_button.dart';
import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/modeles/fields/user_create_fields/user_create_field.dart';
import 'package:atelier_so/core/repository/clientRepository/client_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/services/image_client/image_client.dart';
import 'package:atelier_so/core/services/image_client/image_client_extension.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/clients/addClient/form/addCLient_form.dart';
import 'package:atelier_so/widgets/PopUps/choose_client_icon.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/separator.dart';

class AddClientScreen extends StatefulWidget {
  final Function onSave;
  const AddClientScreen({
    super.key,
    required this.onSave,
  });

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  File? imgFile;
  String? image;
  final imgPicker = ImagePicker();
  String? fileName;

  ScrollController _controller = ScrollController();

  final _formKey2 = GlobalKey<FormState>();

//------------------------------------------------------

//----------------Détails contact-----------------------
  TextEditingController NomFullCtrl = TextEditingController();
  TextEditingController AdresseCtrl = TextEditingController();
  TextEditingController PhoneCtrl = TextEditingController();
  TextEditingController EmailCtrl = TextEditingController();
  void initData() {
    /// numeroSerieCtrl.text = generateRandomString(10);
  }

//------------------------------------------------------

  /* SelectPropriety(BuildContext context, MyInheritedWidgetState state) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => SelectProprietyAlert(
        entrerPropriety: (() => setState(() {
              addPropriety(context);
            })),
        state: state,
      ),
    );
  }*/

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
          return ChooseClientIconAlert(
            onSelected: choisirIcones,
            imageSelected: image,
          );
        });
  }

  void saveClient(String imagePath) async {
    bool isAdded = false;
    LoadingDialog.show(context);
    //----------------------------------------------------------------

    // Insert a new Client to the database
    UserCreateField fields = UserCreateField(
        nomComplet: NomFullCtrl.text,
        adresse: AdresseCtrl.text,
        phone: PhoneCtrl.text,
        email: EmailCtrl.text,
        uid: const Uuid().v4(),
        photoUrl: imagePath,
        mesures: []);
    await _clientRepository.saveClient(fields).then((value) {
      if (value == true) {
        setState(() {
          isAdded = true;
          Navigator.pop(context, true);
        });
      }
    }).whenComplete(() => LoadingDialog.hide(context));

    if (isAdded) {}
    setState(() {
      widget.onSave();
    });

    //--------------------------------------------------
  }

  Widget displayImage() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue, width: 2),
          color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: CustomImageView(
        imagePath: image ?? imgFile?.path ?? Images.placeholder,
        fit: BoxFit.cover,
      ),
    );
  }

  //////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////

  @override
  void initState() {
    // TODO: implement initState

    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajouter Client",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
              icon:
                  const Icon(Icons.save_outlined, color: ThemeColors.redOrange),
              color: Colors.black,
              onPressed: () async {
                // Step 2: Check for valid file
                if (!_formKey2.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Erreur! Veuillez remplir les informations du client',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red.shade400,
                  ));
                }
                if (imgFile == null && image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Erreur! Veuillez ajouter une image au client',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red.shade400,
                  ));
                } else {
                  saveClient(imgFile != null
                      ? imgFile!.path
                      : image ?? Images.placeholder);
                }
              }),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey2,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 10),
              displayImage(),
              const SizedBox(height: 20),
              Wrap(alignment: WrapAlignment.center, children: [
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
              ]),
              /////////////////////Add name //////////////////////
              separator(text: 'Informations clients'),
              ////////////////////////////////////////////////////
              AddClientForm(
                // enable: true,
                nomFullCtrl: NomFullCtrl,
                adresseCtrl: AdresseCtrl,
                phoneCtrl: PhoneCtrl,
                emailCtrl: EmailCtrl,
              ),

              /////////////////////////////////
              // DefaultButton(
              //     paddingV: 10,
              //     fontSize: 14,
              //     height: 50,
              //     textColor: ThemeColors.greyDeep,
              //     backColor: ThemeColors.white,
              //     text: "Se Connecter".toUpperCase(),
              //     press: () {
              //       //  context.goNamed(RootName.home_view);
              //     }),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  ClientRepository _clientRepository = getIt<ClientRepository>();
}
