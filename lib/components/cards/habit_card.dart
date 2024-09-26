import 'dart:io';

import 'package:atelier_so/core/modeles/data_commande/habit/habit.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/PopUps/delete_habit.popUp.dart';
import 'package:atelier_so/widgets/PopUps/delete_modele.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';

class HabitItemCard extends StatefulWidget {
  Habit habit;
  final Function press;
  bool showDeleteIcon;
  Function() deleteHabit;
  void Function(Habit habit)? onSelected;
  String? btnDefautText;
  bool showBtn;
  HabitItemCard(
      {super.key,
      required this.habit,
      required this.press,
      this.showDeleteIcon = false,
      required this.deleteHabit,
      this.btnDefautText,
      this.onSelected,
      this.showBtn = true});

  @override
  State<HabitItemCard> createState() => _HabitItemCardState();
}

class _HabitItemCardState extends State<HabitItemCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.lightBlueAccent.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 3.0,
      color: Colors.white,
      child: Stack(children: [
        GestureDetector(
          onTap: () => widget.press.call(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Stack(children: [
                    //widget.Lemodele.imgPath
                    CustomImageView(
                      imagePath: widget.habit.image ?? Images.mannequin,
                      fit: widget.habit.image != null
                          ? BoxFit.cover
                          : BoxFit.contain,
                      placeHolder: Images.mannequin,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Opacity(
                      opacity: 0.2,
                      child: Container(
                        color: Colors.black12,
                      ),
                    ),
                    if (widget.showDeleteIcon) ...[
                      Positioned(
                        top: 0,
                        right: 1,
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          icon: Container(
                            decoration: BoxDecoration(
                                color: ThemeColors.redOrange.withOpacity(0.2),
                                shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete,
                                color: ThemeColors.redOrange,
                              ),
                            ),
                          ),
                          color: ThemeColors.redOrange.withOpacity(0.2),
                          onPressed: () {
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (_) => DeleteHabitAlert(
                                  habit: widget.habit,
                                  onDelete: widget.deleteHabit),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      )
                    ]
                  ]),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 1.0,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color(0x17000533),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      child: Text(
                        "${widget.habit.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey.shade800,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    if (widget.showBtn) ...[
                      InkWell(
                        onTap: () => widget.onSelected != null
                            ? widget.onSelected?.call(widget.habit)
                            : () {
                                widget.press();
                              },
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ViewModelePage(
                        //       press: (() => widget.press()),
                        //       leModele: Modele(
                        //           modeleInfo: widget.Lemodele,
                        //           proprieties: ListModeleProprieties),
                        //     ),
                        //   ),
                        // ),
                        child: Container(
                          margin: EdgeInsets.all(2.0),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    /*   Color(0xFFfdaf63),
                                      Colors.deepOrangeAccent*/
                                    Colors.white,
                                    Colors.white,
                                  ]),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                                widget.btnDefautText != null
                                    ? widget.btnDefautText!
                                    : widget.onSelected != null
                                        ? "Choisir"
                                        : "voir",
                                style: const TextStyle(
                                  color: ThemeColors.greyDeep,
                                  fontSize: 15.5,
                                )),
                          ),
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
