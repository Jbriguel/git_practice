import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/repository/modeleRepository/modele_repository.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteHabitAlert extends StatefulWidget {
  DeleteHabitAlert({super.key, required this.habit, required this.onDelete});
  Habit habit;
  Function() onDelete;

  @override
  State<DeleteHabitAlert> createState() => _ConfirmeDeconnexionAlertState();
}

class _ConfirmeDeconnexionAlertState extends State<DeleteHabitAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

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
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                          "Voulez-vous vous supprimer ${widget.habit.name} de la commande ?",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Speedee',
                              color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text(
                          "La suppression est definitive. Veuillez confirmer votre choix.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Speedee',
                              color: Colors.red.shade300)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 1.0,
                                surfaceTintColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
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
                              widget.onDelete.call();
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
                          ),
                        )
                      ]),
                    ),
                  ]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
