import 'dart:io';

import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/functions/uid_generator.dart';
import 'package:atelier_so/core/modeles/atelier/atelier.dart';
import 'package:atelier_so/core/modeles/employe/employe.dart';
import 'package:atelier_so/core/modeles/fields/user_create_fields/user_create_field.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/repository/clientRepository/client_repository.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/atelier/atelier_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_extensions/entreprise/employees_repository.ext.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/clients/addClient/form/addCLient_form.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/employees/forms/add_update_form_employe.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../components/atelierCard.dart';

class AddUpdateEmployerScreen extends StatefulWidget {
  final Function onSave;
  bool updateMode;
  Employe? employe;
  AddUpdateEmployerScreen(
      {super.key, required this.onSave, this.updateMode = false, this.employe});

  @override
  State<AddUpdateEmployerScreen> createState() =>
      _AddUpdateEmployerScreenState();
}

class _AddUpdateEmployerScreenState extends State<AddUpdateEmployerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _controller = ScrollController();

  final _formKey2 = GlobalKey<FormState>();
  Atelier? atelierSelected;
//------------------------------------------------------

//----------------Détails contact-----------------------
  final TextEditingController nomCtrl = TextEditingController();
  final TextEditingController prenomCtrl = TextEditingController();
  final TextEditingController adresseCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  void initData() {
    /// numeroSerieCtrl.text = generateRandomString(10);
    getAteliers();
  }

//------------------------------------------------------

  void AddNewEmployer(Employe employe) async {
    bool isAdded = false;
    LoadingDialog.show(context);

    //----------------------------------------------------------------

    await _userRepository.addNewEmploye(employe).then((value) {
      if (value == true) {
        setState(() {
          isAdded = true;
        });
      }
    }).whenComplete(() => LoadingDialog.hide(context));

    if (isAdded) {
      Navigator.pop(context, true);
    }
    setState(() {
      widget.onSave();
    });

    //--------------------------------------------------
  }

  bool _isLoading = true;
  //Get all Atelierrs
  List<Atelier> _ateliersList = [];
  void getAteliers() async {
    setState(() {
      _isLoading = true;
    });
    _ateliersList = await _userRepository
        .listAteliersByEntreprise(_userRepository.user!.entrepriseId);
    setState(() {
      _isLoading = false;
    });
  }

  Widget displayImage() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: CustomImageView(
        imagePath: Images.afro_man_avatar,
        fit: BoxFit.cover,
      ),
    );
  }

  //////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initData();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen_size_width = MediaQuery.of(context).size.width;
    final screen_size_height = MediaQuery.of(context).size.height;
    // Calculer la largeur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    // Définir une largeur fixe pour chaque carte
    final cardWidth = 300.0;
    // Calculer le nombre de colonnes basé sur la largeur de l'écran
    final crossAxisCount = (screenWidth / cardWidth).floor();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Ajouter Employé",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
                icon: const Icon(Icons.save_outlined,
                    color: ThemeColors.redOrange),
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
                  } else if (passwordCtrl.text != confirmPasswordCtrl.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        'Erreur!Mot de passe et confirme mot de pas ne sont pas identiques',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red.shade300,
                    ));
                  } else if (atelierSelected == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        'Erreur! Veuillez selectionner un atelier',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red.shade300,
                    ));
                  } else {
                    //save function there
                    Employe employe = Employe((emp) => emp
                      ..uid = UIDGenerator().generateUID()
                      ..adresse = adresseCtrl.text
                      ..atelierId = atelierSelected!.uid
                      ..atelierIdentify = atelierSelected!.identify
                      ..email = null
                      ..entrepriseId = _userRepository.user!.entrepriseId
                      ..nom = nomCtrl.text
                      ..prenom = prenomCtrl.text
                      ..password = passwordCtrl.text
                      ..role = 'employe'
                      ..createdAt = DateTime.now().toUtc());
                    AddNewEmployer(employe);
                  }
                }),
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey2,
            child: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        displayImage(),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: AutoSizeText(
                            "Renseignez les informations les champs correspondants.",
                            presetFontSizes: const [13, 12],
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: ThemeColors.greyDeep,
                              ),
                            ),
                          ),
                        ),
                        TabBar(
                          controller: _tabController,
                          labelColor: ThemeColors.greyDeep,
                          unselectedLabelColor: Colors.grey.shade600,
                          dividerColor: Colors.grey.shade200,
                          indicatorColor: ThemeColors.redOrange,
                          labelStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                          tabs: const [
                            Tab(text: "Inforamtions"),
                            Tab(text: "Atelier"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: SafeArea(
                minimum: const EdgeInsets.all(10),
                child: Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      AddUpdateEmployer(
                          prenomCtrl: prenomCtrl,
                          nomCtrl: nomCtrl,
                          adresseCtrl: adresseCtrl,
                          phoneCtrl: phoneCtrl,
                          confirmPasswordCtrl: confirmPasswordCtrl,
                          passwordCtrl: passwordCtrl),
                      _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : _ateliersList.isEmpty
                              ? Flexible(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          fit: BoxFit.contain,
                                          imagePath: Images.folder,
                                          height: 50,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: Text(
                                            "Aucun Atelier trouvée",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Speedee',
                                              color: ThemeColors.greyDeep,
                                            ),
                                          ),
                                        ),
                                        DefaultButton(
                                            paddingV: 5,
                                            fontSize: 13,
                                            height: 40,
                                            textColor: ThemeColors.white,
                                            backColor: ThemeColors.greyDeep,
                                            text: " Actualiser ".toUpperCase(),
                                            press: () {
                                              getAteliers();
                                            }),
                                      ]),
                                )
                              : Flexible(
                                  child: GridView.builder(
                                      controller: _controller,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        mainAxisExtent: 160,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                      ),
                                      itemCount: _ateliersList.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        Atelier atelier = _ateliersList[index];
                                        return AtelierCard(
                                          atelier: atelier,
                                          showDeleteBtn: false,
                                          isSelected:
                                              atelierSelected == atelier,
                                          onSelected: (Atelier atlr) {
                                            setState(() {
                                              atelierSelected = atlr;
                                            });
                                          },
                                          onDelete: null,
                                        );
                                      }),
                                ),
                    ],
                  ),
                ),
              ),
            ),
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

  UserRepository _userRepository = getIt<UserRepository>();
}
