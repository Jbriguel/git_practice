import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/repository/modeleRepository/modele_repository.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteModeleAlert extends StatefulWidget {
  DeleteModeleAlert({super.key, required this.modele, required this.refresh});
  Modele modele;
  Function() refresh;

  @override
  State<DeleteModeleAlert> createState() => _ConfirmeDeconnexionAlertState();
}

class _ConfirmeDeconnexionAlertState extends State<DeleteModeleAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  ModeleRepository _modeleRepository = getIt<ModeleRepository>();

  void saveModele() async {
    bool? isDeleted;
    LoadingDialog.show(context);
    _modeleRepository.deleteModele(widget.modele.uid!).then((retour) {
      if (retour == true) {
        setState(() {
          isDeleted = true;
        });
        Navigator.pop(context, true);
      }
    }).whenComplete(() => LoadingDialog.hide(context));

    if (isDeleted == true) {
      //Navigator.pop(context, true);
    }
  }

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

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: Center(
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
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 50,
                                child: Image.asset(
                                  Images.close,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                  "Voulez-vous vous supprimer ${widget.modele.name != null ? 'le modèle ~${widget.modele.name}~' : 'ce modèle'}  ?",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Speedee',
                                      color: Colors.black)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('yes selected');
                                      Navigator.of(context).pop();
                                      widget.refresh.call();
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
                                  onPressed: () async {
                                    saveModele();
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: ThemeColors.redOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text(
                                    "Supprimer",
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
        ));
  }
}
