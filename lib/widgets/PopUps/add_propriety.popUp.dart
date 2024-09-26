import 'package:atelier_so/core/functions/uid_generator.dart';
import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/repository/modeleRepository/propriety_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/custom/cutomInput.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNewProprietyAlert extends StatefulWidget {
  AddNewProprietyAlert({super.key, required this.createPropriety});
  void Function() createPropriety;

  @override
  State<AddNewProprietyAlert> createState() => _ConfirmeDeconnexionAlertState();
}

class _ConfirmeDeconnexionAlertState extends State<AddNewProprietyAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  ProprietyRepository _proprietyRepository = getIt<ProprietyRepository>();
  final TextEditingController mesureItemCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInExpo);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  final _formKey2 = GlobalKey<FormState>();

  void createPropriety(Propriety propriety) async {
    LoadingDialog.show(context);
    //----------------------------------------------------------------
    await _proprietyRepository.savePropriety(propriety).then((value) {
      if (value == true) {
        Navigator.pop(context, true);
      }
    }).whenComplete(() => LoadingDialog.hide(context));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: Center(
            child: Form(
          key: _formKey2,
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
                scale: scaleAnimation,
                child: OrientationBuilder(builder: (context, orientation) {
                  return SingleChildScrollView(
                    child: Container(
                      width: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.85
                          : MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.all(5.0),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    height: 20,
                                    child: Image.asset(
                                      Images.plus,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 10.0),
                                    child: Text("Nouvelle proprieté",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Speedee',
                                            fontWeight: FontWeight.w600,
                                            color: ThemeColors.greyDeep)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: CustomTextFormField(
                                controller: mesureItemCtrl,
                                hintText: "Saisir nom de la mesure...",
                                textInputAction: TextInputAction.none,
                                textColor: Colors.black87,
                                fillColor:
                                    ThemeColors.greyDeep.withOpacity(0.2),
                                filled: true,
                                validator: (text) {
                                  if (text == null ||
                                      text.isEmpty ||
                                      text.trim() == "") {
                                    return 'Champ requis!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child: Divider(
                                color: ThemeColors.greyDeep.withOpacity(0.1),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('yes selected');
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 1.0,
                                        surfaceTintColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor: Colors.white),
                                    child: const Text(
                                      "Annuler",
                                      style: TextStyle(
                                          fontFamily: "Speedee",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey2.currentState!.validate()) {
                                      Navigator.of(context).pop();
                                      createPropriety(Propriety((p) => p
                                        ..uid = UIDGenerator().generateUID()
                                        ..name = mesureItemCtrl.text
                                        ..value = mesureItemCtrl.text));
                                      widget.createPropriety.call();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: ThemeColors.redOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text(
                                    "Créer proprieté",
                                    style: TextStyle(
                                        fontFamily: "Speedee",
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ))
                              ]),
                            ),
                          ]),
                    ),
                  );
                })),
          ),
        )));
  }
}
