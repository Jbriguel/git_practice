import 'package:atelier_so/components/default_btn/defaultButton.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/screens/dataManager/pages/pdf/ShowPdf_screen.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CommandeDetailsAlert extends StatefulWidget {
  CommandeDetailsAlert(
      {Key? key,
      required this.editer,
      required this.commande,
      required this.client})
      : super(key: key);
  Commande commande;
  Client client;
  VoidCallback editer;
  @override
  State<StatefulWidget> createState() => NewRequestDetails_PopUpState();
}

class NewRequestDetails_PopUpState extends State<CommandeDetailsAlert>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  Color Color3 = const Color.fromARGB(255, 18, 40, 70);

  //-------------------------------------------------------------//
  TextStyle style = const TextStyle(fontFamily: 'Aller');

//##############################################//

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    scaleAnimation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutCubicEmphasized);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: OrientationBuilder(builder: (context, orientation) {
              return Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width < 400
                      ? MediaQuery.of(context).size.width * 0.9
                      : 380,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: ThemeColors.redOrange.withOpacity(0.8),
                            width: 1.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: Images.logo_noBack,
                                  width: 50,
                                  fit: BoxFit.contain,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ThemeColors.white
                                              .withOpacity(0.2),
                                          width: 1.0),
                                      color: ThemeColors.greyDeep,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: DateFormat('dd MMMM yyyy').format(
                                            DateTime.parse(
                                                widget.commande.deliveryDate)),
                                        style: const TextStyle(
                                          color: ThemeColors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                            // displayImage(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0, vertical: 5),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      ' • ',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: ThemeColors.black),
                                    ),
                                    Text(
                                      widget.client.nomComplet ?? '',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ThemeColors.black
                                              .withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            subTitle(text: "Tel : ${widget.client.phone}"),
                            title(text: "Details de la commande"),

                            subTitle(
                                text: "Prix : ${widget.commande.price} Fcfa"),
                            subTitle(
                                text:
                                    "livraison : ${DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.commande.deliveryDate))}"),
                            subTitle(text: widget.commande.details ?? '---'),
                            title(text: "Habits de la commande"),
                            //--------------------------------//

                            // title(text: "Mesures prises"),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: widget.commande.habits!
                                    .asList()
                                    .map((habit) => Column(children: [
                                          Row(children: [
                                            const Text(
                                              ' • ',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                  color: ThemeColors.black),
                                            ),
                                            subTitle(text: habit.name ?? '---'),
                                          ]),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Wrap(
                                                alignment: WrapAlignment.start,
                                                spacing: 4.0,
                                                children: habit.proprieties
                                                        ?.asList()
                                                        .map((hp) => ChoiceChip(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200)),
                                                              pressElevation:
                                                                  0.5,
                                                              selectedColor:
                                                                  ThemeColors
                                                                      .redOrange,
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .shade50,
                                                              label: Text(
                                                                "${hp.name ?? ''} ${hp.value ?? '00'}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              selected: false,
                                                              onSelected: (bool
                                                                  selected) {},
                                                            ))
                                                        .toList() ??
                                                    []
                                                // SizedBox.shrink()
                                                ),
                                          ),
                                        ]))
                                    .toList(),
                              ),
                            ),

                            Row(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: DefaultButton(
                                      paddingV: 5,
                                      fontSize: 13,
                                      height: 40,
                                      textColor: ThemeColors.white,
                                      backColor: ThemeColors.greyDeep,
                                      text: "Modifier".toUpperCase(),
                                      press: () {
                                        Navigator.of(context).pop();
                                        widget.editer();
                                      }),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: DefaultButton(
                                      paddingV: 5,
                                      fontSize: 13,
                                      height: 40,
                                      textColor: ThemeColors.greyDeep,
                                      backColor: ThemeColors.orangeBackground,
                                      text: " Pdf ".toUpperCase(),
                                      press: () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AfficherDataInPDF(
                                              genre: 'comDetails',
                                              document_name: "Détails commande",
                                              client: widget.client,
                                              commandes: [widget.commande],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),

                            //--------------------------------//
                            //--------------------------------//
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                // --------------------------//

                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeColors.redOrange.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.close,
                          color: ThemeColors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )
                // ----------------------------//
              ]);
            }),
          ),
        ),
      ),
    );
  }

  Widget displayImage() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: ThemeColors.orangeBackground, width: 2),
          color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: CustomImageView(
        imagePath: Images.wardrobe,
        fit: BoxFit.contain,
      ),
    );
  }

  title({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 14,
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: ThemeColors.black.withOpacity(0.9),
              ),
            ),
          ),
        ),
      );

  subTitle({required String text}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 12,
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: ThemeColors.greyDeep.withOpacity(0.9),
              ),
            ),
          ),
        ),
      );
}
