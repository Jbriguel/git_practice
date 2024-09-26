import 'dart:io';
import 'package:atelier_so/components/default_btn/custom_elevated_button.dart';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/data_commande/habit_propriety/habit_propriety.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:atelier_so/widgets/custom/selector/multiSelectorDialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/separator.dart';
import 'components/setMesuresZone.dart';

class ViewOrEditHabitPage extends StatefulWidget {
  final Function onSave;
  String action; // "view" or "edit"
  Habit habit;
  int indexInList;

  ViewOrEditHabitPage({
    Key? key,
    required this.action,
    required this.onSave,
    required this.habit,
    required this.indexInList,
  }) : super(key: key);

  @override
  State<ViewOrEditHabitPage> createState() => _ViewOrEditHabitPageState();
}

class _ViewOrEditHabitPageState extends State<ViewOrEditHabitPage> {
  File? imgFile;
  String? image;
  final imgPicker = ImagePicker();
  String? fileName;
  bool isEditMode = false;

  List<Propriety> proprieties = [];
  List<Map<String, dynamic>> proprietyFields = [];

  List<Map<String, dynamic>> MesuresSelect = [];
  //List<String> MesuresSelect = [];

  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController detailsCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    isEditMode = widget.action == "edit";
    _initHabitData();
  }

  void _initHabitData() {
    nameCtrl.text = widget.habit.name ?? '';
    detailsCtrl.text = widget.habit.details ?? '';
    print("proprieties ${widget.habit.toJson()}");
    proprieties = (widget.habit.proprieties?.toList() ?? [])
        .map((e) => Propriety((p) => p
          ..name = e.name
          ..value = e.value))
        .toList();
    _populateProprietyFields();
    image = widget.habit.image;
  }

  void _populateProprietyFields() {
    proprietyFields = [];
    for (var propriety in proprieties) {
      TextEditingController ctrl = TextEditingController(text: propriety.value);
      proprietyFields.add(
          {"name": propriety.name, "id": propriety.uid, "controller": ctrl});
    }
    setState(() {});
  }

  List<HabitPropriety> _getDataFromTextFields() {
    return proprietyFields.map((field) {
      TextEditingController ctrl = field["controller"];
      return HabitPropriety((p) => p
        ..name = field["name"]
        ..value = ctrl.text);
    }).toList();
  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      image = null;
      imgFile = File(imgCamera!.path);
      fileName = imgCamera.name;
    });
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = null;
      imgFile = File(imgGallery!.path);
      fileName = imgGallery.name;
    });
  }

  Widget displayImage() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.orange, width: 2),
          color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: CustomImageView(
        imagePath: image ?? imgFile?.path ?? Images.mannequin,
        fit: image != null || imgFile?.path != null
            ? BoxFit.cover
            : BoxFit.contain,
      ),
    );
  }

  Widget _buildProprietyFields({bool isEnabled = true}) {
    return setMesuresDataZone(
        enable: isEnabled, allTextFields: proprietyFields);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
              ),
              child:
                  const Text("Retour", style: TextStyle(color: Colors.white)),
            ),
          ),
          if (isEditMode) ...[
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey2.currentState!.validate()) {
                    final updatedHabit = widget.habit.rebuild((b) => b
                      ..name = nameCtrl.text
                      ..details = detailsCtrl.text
                      ..image = image ?? imgFile?.path ?? b.image
                      ..proprieties.replace(_getDataFromTextFields()));
                    Navigator.pop(context, {
                      "index": widget.indexInList,
                      "Habit": updatedHabit,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                ),
                child: const Text("Sauvegarder",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  addMesure() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          final _formKey = GlobalKey<FormState>();
          final TextEditingController mesureItemCtrl = TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return Form(
              key: _formKey,
              child: AlertDialog(
                  backgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          BorderSide(width: 1.2, color: Colors.grey.shade200)),
                  title: Text(
                    'Ajouter une mesure',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: ThemeColors.greyDeep),
                  ),
                  content: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: CustomTextFormField(
                      controller: mesureItemCtrl,
                      hintText: "Saisir nom du modele...",
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
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler',
                          style: TextStyle(color: ThemeColors.greyDeep)),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO submit
                          final String nom = mesureItemCtrl.text;

                          setState(() {
                            TextEditingController ctrl =
                                TextEditingController();
                            Map<String, dynamic> ligne =
                                ({"name": nom, "controller": ctrl});
                            proprietyFields.add(ligne);
                            //generateDataWeNeed();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Ajouter',
                          style: TextStyle(color: Colors.green)),
                    ),
                  ]),
            );
          });
        });
  }

  RemoveMesure(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.9),
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: StatefulBuilder(
            builder: (_, StateSetter setState) => AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                contentPadding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1.2, color: Colors.grey.shade300)),
                title: Center(
                  child: Text(
                    'Retirer des Mesures',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ThemeColors.greyDeep,
                        ),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: MesuresSelect.map((Map<String, dynamic> mesure) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(" * " + mesure["name"]),
                        ),
                        Checkbox(
                          value: mesure["checked"],
                          onChanged: (bool? newValue) {
                            setState(() {
                              mesure["checked"] = newValue ??
                                  false; // Utilisez la valeur de `newValue`
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Annuler',
                        style: TextStyle(color: ThemeColors.greyDeep)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        for (Map<String, dynamic> mesure in MesuresSelect) {
                          if (mesure["checked"] == true) {
                            proprietyFields.removeWhere(
                                (p) => p["name"] == mesure["name"]);
                          }
                        }
                      });
                      setState(() {
                        MesuresSelect.removeWhere(
                            (mesure) => mesure["checked"] == true);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('supprimer',
                        style: TextStyle(color: ThemeColors.red)),
                  ),
                ]),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Habit",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    text: 'Choisir Image',
                    iconData: Icons.image,
                    onPressed: openGallery,
                  ),
                  const SizedBox(width: 5),
                  CustomElevatedButton(
                    text: 'Prendre Photo',
                    iconData: Icons.camera_alt_outlined,
                    onPressed: openCamera,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              separator(text: "Information"),
              _buildNameInput(isEnabled: isEditMode),
              const SizedBox(height: 10),
              separator(text: "Les mesures"),
              _buildProprietyFields(isEnabled: isEditMode),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomElevatedButton(
                    text: 'Retirer mesure',
                    iconData: Icons.remove,
                    onPressed: () async {
                      setState(() {
                        MesuresSelect = [];
                        proprietyFields.forEach((mesure) {
                          Map<String, dynamic> ligne = ({
                            "name": mesure["name"],
                            "index": 0,
                            "checked": false
                          });
                          // String ligne = mesure["name"];
                          MesuresSelect.add(ligne);
                        });
                      });
                      /* List<Map<String, dynamic>> retour =*/ RemoveMesure(
                        context,
                      );
                      //  setState(() {
                      //   MesuresSelect.removeWhere(
                      //       (mesure) => mesure["checked"] == true);
                      // });
                      // Navigator.pop(context);

                      // List<String> flavours = [];
                      // flavours = await showDialog<List<String>>(
                      //         context: context,
                      //         builder: (_) => MultiSelectDialog(
                      //             question: Text('Select Your Flavours'),

                      //             answers: List<String>.from(proprietyFields
                      //                 .map((e) => e["name"] ?? '')
                      //                 .toList()))) ??
                      //     [];
                      // print(flavours);
                    }),
                const SizedBox(width: 5),
                CustomElevatedButton(
                  text: 'Ajouter mesure',
                  iconData: Icons.add,
                  onPressed: () => addMesure(),
                ),
              ]),
              const SizedBox(height: 10),
              _buildActionButtons(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput({bool isEnabled = true}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: CustomTextFormField(
              controller: nameCtrl,
              hintText: "Saisir nom du modele...",
              textInputAction: TextInputAction.none,
              textColor: Colors.black87,
              fillColor: ThemeColors.greyDeep.withOpacity(0.2),
              filled: true,
              autofocus: false,
              validator: (text) {
                if (text == null || text.isEmpty || text.trim() == "") {
                  return 'Champ requis!';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: CustomTextFormField(
              controller: detailsCtrl,
              hintText: "Saisir description ...",
              textInputAction: TextInputAction.none,
              autofocus: false,
              textColor: Colors.black87,
              fillColor: ThemeColors.greyDeep.withOpacity(0.2),
              filled: true,
              maxLines: 4,
            ),
          ),
          // const Text(
          //   "Nom de l'habit ou du modèle utilisé",
          //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          // ),
        ],
      ),
    );
  }
}
