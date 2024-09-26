import 'dart:developer';
import 'dart:io';

import 'package:atelier_so/components/cards/habit_card.dart';
import 'package:atelier_so/components/default_btn/custom_elevated_button.dart';
import 'package:atelier_so/core/functions/uid_generator.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/data_commande/habit_propriety/habit_propriety.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/modeles/fields/user_create_fields/user_create_field.dart';
import 'package:atelier_so/core/repository/commandeRepository/commande_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/services/image_client/image_client.dart';
import 'package:atelier_so/core/services/image_client/image_client_extension.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/clients/clients_screen.dart';
import 'package:atelier_so/screens/commande/components/commande_details.dart';
import 'package:atelier_so/screens/modeles/modeles.page.dart';
import 'package:atelier_so/widgets/PopUps/choose_client_icon.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:atelier_so/widgets/separator.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../habits_screen/editerOrView_habit_screen.dart';
import 'components/client_info.dart';

class AddCommandePage extends StatefulWidget {
  @override
  _AddCommandePageState createState() => _AddCommandePageState();
}

class _AddCommandePageState extends State<AddCommandePage> {
  final _formKey2 = GlobalKey<FormState>();
  ScrollController _controller = ScrollController();

  // Example controllers
  TextEditingController NomFullCtrl = TextEditingController();
  TextEditingController AdresseCtrl = TextEditingController();
  TextEditingController PhoneCtrl = TextEditingController();
  TextEditingController EmailCtrl = TextEditingController();

  TextEditingController priceCtrl = TextEditingController();
  TextEditingController advanceCtrl = TextEditingController();

  DateTime dateTime = DateTime.now();
  TextEditingController commandeNote = TextEditingController();
  List<Habit> listHabits = [];
  Client? clientSelected;

  CommandeRepository _commandeRepository = getIt<CommandeRepository>();

  void SaveCommande(String imagePath) async {
    bool isAdded = false;
    LoadingDialog.show(context);
    //----------------------------------------------------------------

    // Insert a new Client to the database
    UserCreateField fields = UserCreateField(
        nomComplet: NomFullCtrl.text,
        adresse: AdresseCtrl.text,
        phone: PhoneCtrl.text,
        email: EmailCtrl.text,
        uid: clientSelected?.uid ?? const Uuid().v4(),
        photoUrl: imagePath,
        informationsSuppelementaires:
            clientSelected?.informationsSuppelementaires,
        mesures: []);

    //Faire un build de commande avec les champs
    //TODO: faire un build de commande
    Commande commande = Commande((comd) => comd
      ..uid = UIDGenerator().generateUID()
      ..clientUid = clientSelected?.uid
      ..advance = double.parse(advanceCtrl.text)
      ..price = double.parse(priceCtrl.text)
      ..details = commandeNote.text
      ..deliveryDate = dateTime.toIso8601String()
      ..habits = null
      /*..isDelivered = false
      ..isPaid = false
      ..isCanceled = false
      ..isCompleted = false*/
      ..createdAt = DateTime.now().toIso8601String());

    await _commandeRepository
        .saveCommande(commande, listHabits, fields)
        .then((value) {
      if (value == true) {
        setState(() {
          isAdded = true;
          Navigator.pop(context, true);
        });
      }
    }).whenComplete(() => LoadingDialog.hide(context));

    //--------------------------------------------------
  }

  //----------------Détails contact-----------------------
  void initClientData() {
    setState(() {
      EmailCtrl.text = clientSelected?.email ?? '';
      NomFullCtrl.text = clientSelected?.nomComplet ?? '';
      PhoneCtrl.text = clientSelected?.phone ?? '';
      AdresseCtrl.text = clientSelected?.adresse ?? '';

      if (clientSelected?.photoUrl != null) {
        if (clientSelected!.photoUrl!.contains("assets/images/")) {
          log("is asset image");
          setState(() {
            image = clientSelected!.photoUrl!;
          });
        } else {
          log("is file image");
          setState(() {
            imgFile = File(clientSelected!.photoUrl!);
          });
        }
      }
    });
  }

//------------------------------------------------------

  // Add your methods here (openGallery, choisirImage, openCamera, etc.)
  File? imgFile;
  String? image;
  final imgPicker = ImagePicker();
  String? fileName;
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

  Widget displayImage() {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: ThemeColors.redOrange, width: 2),
          color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: CustomImageView(
        imagePath: image ?? imgFile?.path ?? Images.placeholder,
        fit: (image != null || imgFile?.path != null)
            ? BoxFit.contain
            : BoxFit.cover,
      ),
    );
  }

  /////
  //--------------Commande Details---------------------------
  SelectDate() async {
    DateTime? newDateTime = await showRoundedDatePicker(
      height: 300,
      context: context,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      description: "Selectionner le jour de remise de la commande.",
    );
    if (newDateTime != null) {
      setState(() => dateTime = newDateTime);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

//------------------List des modeles used -------------------
  // List<HabitDonnees> listHabits = [];
  // void supprimerHabitFormListHabitsSelected(int index) {
  //   setState(() {
  //     listHabits.removeAt(index);
  //   });
  // }
  ///---------------------------------------------//
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajouter Commande",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        surfaceTintColor: ThemeColors.white,
        backgroundColor: Colors.white,
        elevation: 1.0,
        scrolledUnderElevation: 1.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined, color: ThemeColors.redOrange),
            onPressed: () async {
              // Step 2: Check for valid file
              if (!_formKey2.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    'Erreur! Veuillez remplir les champs obligatoires',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red.shade400,
                ));
              } else if (dateTime.isBefore(DateTime.now())) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    'Erreur! La date de livraison est antérieure à la date du jour',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red.shade400,
                ));
              } else {
                SaveCommande(imgFile != null
                    ? imgFile!.path
                    : image ?? Images.placeholder);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              displayImage(), // Method for displaying image
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 5,
                runSpacing: 10,
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
                  const SizedBox(width: 5),
                  CustomElevatedButton(
                    text: 'Choisir client',
                    iconData: Icons.person,
                    onPressed: () => _toSelectClientPage(
                        context,
                        AllClientsScreen(
                          selectedMode: true,
                        )),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              separator(text: "Information"),
              ContactAndDeatils(
                enable: true,
                nomFullCtrl: NomFullCtrl,
                adresseCtrl: AdresseCtrl,
                phoneCtrl: PhoneCtrl,
                emailCtrl: EmailCtrl,
              ),
              const SizedBox(height: 10),
              separator(text: "Détails sur la commande"),
              ////////////////////////////////////////////////////
              CommandeDetailsZone(
                enable: true,
                dateTime: dateTime,
                commandeNote: commandeNote,
                SelectDate: SelectDate,
                priceCtrl: priceCtrl,
                advanceCtrl: advanceCtrl,
              ),
              ///////////////////////////////////////////////////
              const SizedBox(height: 10),
              separator(text: "Les Habits de la commande ${listHabits.length}"),
              addButton(),

              GridView.builder(
                shrinkWrap: true,
                controller: _controller,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                itemCount: listHabits.length,
                itemBuilder: (BuildContext ctx, index) {
                  Habit _habit = listHabits[index];
                  return HabitItemCard(
                      press: () => _toEditPage(
                            context,
                            ViewOrEditHabitPage(
                              onSave: (() => {}),
                              indexInList: index,
                              habit: _habit,
                              action: "edit",
                            ),
                          ),
                      habit: _habit,
                      showBtn: false,
                      onSelected: (Habit h) {},
                      showDeleteIcon: true,
                      deleteHabit: () {
                        listHabits.removeAt(index);
                        setState(() {});
                        // _refreshModels();
                        setState(() {});
                      });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget addButton() => InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(5),
          child: CustomImageView(
            imagePath: Images.add_commande,
            fit: BoxFit.contain,
            height: 50,
            width: 50,
          ),
        ),
        onTap: () => _secondPage(
            context,
            AllModelsPage(
              selectedMode: true,
            )),
      );

  Future<void> _secondPage(BuildContext context, Widget page) async {
    try {
      final Modele dataFromSecondPage = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

      // listHabits.add(HabitDonnees(
      //   modeleInfo: dataFromSecondPage.modeleInfo,
      //   proprieties: dataFromSecondPage.proprieties,
      // ));
      Habit _habit = Habit(
        (h) => h
          ..image = dataFromSecondPage.imgPath
          ..details = dataFromSecondPage.description
          ..modeleUid = dataFromSecondPage.uid
          ..name = dataFromSecondPage.name
          ..proprieties = ListBuilder<HabitPropriety>(
            dataFromSecondPage.proprieties
                .asList()
                .map((e) => HabitPropriety((p0) => p0
                  ..value = ''
                  ..name = e.name))
                .toBuiltList(),
          ),
      );
      listHabits.add(_habit);
      setState(() {});
    } catch (e) {
      print("Erreur $e");
    }
  }

  Future<void> _toEditPage(BuildContext context, Widget page) async {
    final dataFromSecondPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ) as Map<String, dynamic>;

    print("object: dataFromSecondPage: $dataFromSecondPage");
    setState(() {
      listHabits[dataFromSecondPage["index"]] = dataFromSecondPage["Habit"];
    });
  }

  Future<void> _toSelectClientPage(BuildContext context, Widget page) async {
    final dataFromSecondPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ) as Client;
    print("object $dataFromSecondPage");
    setState(() {
      clientSelected = dataFromSecondPage;
      initClientData();
    });
  }
}

class DividerSection extends StatelessWidget {
  final String title;

  const DividerSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(height: 1, color: Colors.black),
          ),
        ),
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(height: 1, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
