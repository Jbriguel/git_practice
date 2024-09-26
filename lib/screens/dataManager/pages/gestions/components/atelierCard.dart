import 'package:atelier_so/components/ligne_details.dart';
import 'package:atelier_so/core/modeles/atelier/atelier.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/separator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AtelierCard extends StatefulWidget {
  Atelier atelier;
  bool showDeleteBtn;
  bool selectionMode;
  Function(String? elementId)? onDelete;
  void Function(Atelier atlr)? onSelected;
  bool isSelected;
  AtelierCard(
      {super.key,
      required this.atelier,
      this.showDeleteBtn = false,
      this.selectionMode = true,
      this.isSelected = false,
      this.onDelete,
      this.onSelected});

  @override
  State<AtelierCard> createState() => _AtelierCardState();
}

class _AtelierCardState extends State<AtelierCard> {
  TextStyle style = const TextStyle(
    fontFamily: 'Poppins',
    color: Colors.white,
    fontWeight: FontWeight.w200,
    fontSize: 16,
  );
  TextStyle style2 = const TextStyle(fontFamily: "Poppins", fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onSelected != null
          ? () {
              widget.onSelected?.call(widget.atelier);
              setState(() {});
            }
          : () {},
      child: Card(
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.lightBlueAccent.withOpacity(0.2),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: widget.isSelected
                  ? ThemeColors.redOrange.withOpacity(0.5)
                  : Colors.grey.shade100,
              width: 1.5),
        ),
        margin: const EdgeInsets.all(5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ThemeColors.greyDisable.withOpacity(0.4),
                                    ThemeColors.greyDisable.withOpacity(0.2),
                                    ThemeColors.greyDisable.withOpacity(0.1),
                                  ]),
                              shape: BoxShape.rectangle,
                              // border: Border.all(
                              //     color: ThemeColors.redOrange, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomImageView(
                              imagePath: Images.sewing,
                              placeHolder: Images.sewing,
                              fit: BoxFit.contain,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Text(
                                                widget.atelier.name,
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: ThemeColors.black,
                                                    fontFamily: "Speedee"),
                                              ),
                                            ),
                                          ),
                                          if (widget.showDeleteBtn) ...[
                                            deleteHistoriqueElementIcon(
                                              name: widget.atelier.name,
                                              onPressed: () {
                                                //A Decommenter
                                                widget.onDelete!(
                                                    widget.atelier.uid);
                                                print("supprimer atelier");
                                              },
                                            ),
                                          ]
                                        ],
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Divider(
                                          color: ThemeColors.redOrange
                                              .withOpacity(0.1),
                                          height: 1,
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 5,
                                ),
                                detailsLigne(
                                  titre: "Identifiant:",
                                  data: widget.atelier.identify ?? '---',
                                  dataColor: ThemeColors.greyDeep,
                                  nLigne: 1,
                                  paddingV: 2,
                                ),
                                detailsLigne(
                                  titre: "Adresse:",
                                  data: (widget.atelier.adresse == null ||
                                          widget.atelier.adresse!
                                              .trim()
                                              .isEmpty)
                                      ? '---'
                                      : widget.atelier.adresse!,
                                  dataColor: ThemeColors.greyDeep,
                                  nLigne: 1,
                                  paddingV: 2,
                                ),
                              ],
                            ),
                          ),
                        ]),
                    if (widget.selectionMode) ...[
                      Spacer(),
                      Text(
                        widget.isSelected
                            ? "Sélectionné"
                            : "Cliquez pour selectionner",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Speedee',
                          fontSize: 14,
                          color: widget.isSelected
                              ? ThemeColors.greenLeger
                              : ThemeColors.greyDeep.withOpacity(0.4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class deleteHistoriqueElementIcon extends StatelessWidget {
  deleteHistoriqueElementIcon(
      {super.key, required this.name, required this.onPressed});

  final String name;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          // showDialog(
          //   barrierDismissible: true,
          //   context: context,
          //   builder: (_) => ConfirmeDeleteAtelierAlert(
          //     press: onPressed,
          //     atelierName: name,
          //   ),
          // );
        },
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.withOpacity(0.2),
          ),
          padding: const EdgeInsets.all(5),
          child: Icon(
            CupertinoIcons.delete,
            size: 20,
            color: Colors.red.shade400,
          ),
        ));
  }
}

class LigneText extends StatelessWidget {
  final String text;
  LigneText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: AutoSizeText(
        text,
        presetFontSizes: const [11, 10],
        maxLines: 1,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style:
            const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      ),
    );
  }
}
