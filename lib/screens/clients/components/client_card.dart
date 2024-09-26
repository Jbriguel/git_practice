import 'package:atelier_so/components/ligne_details.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/PopUps/confirm_delete_client.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatefulWidget {
  Client client;
  bool showDeleteBtn;
  Function(String? elementId)? onDelete;
  void Function(Client clt)? onSelected;
  ClientCard(
      {super.key,
      required this.client,
      this.showDeleteBtn = false,
      this.onDelete,
      this.onSelected});

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
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
      onTap: () => widget.onSelected != null
          ? widget.onSelected?.call(widget.client)
          : {},
      child: Card(
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.lightBlueAccent.withOpacity(0.2),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
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
                            padding: const EdgeInsets.all(1),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ThemeColors.greyDisable,
                                      ThemeColors.greyDisable.withOpacity(0.1),
                                    ]),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ThemeColors.redOrange, width: 1.0)
                                // borderRadius: BorderRadius.circular(10),
                                ),
                            child: CustomImageView(
                              imagePath: widget.client.iconName ??
                                  widget.client.photoUrl ??
                                  Images.afro_man_avatar,
                              placeHolder: Images.contact,
                              fit: (widget.client.iconName != null ||
                                      widget.client.photoUrl != null)
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                              height: 100,
                              width: 100,
                              radius: BorderRadius.circular(50),
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
                                                widget.client.nomComplet ??
                                                    'no name',
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
                                              name: widget.client.nomComplet ??
                                                  '---',
                                              onPressed: () {
                                                //A Decommenter
                                                widget.onDelete!(
                                                    widget.client.uid);
                                                print("supprimer client");
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
                                  titre: "Tel",
                                  data: widget.client.phone ?? '---',
                                  dataColor: ThemeColors.greyDeep,
                                  nLigne: 1,
                                  paddingV: 2,
                                ),
                                detailsLigne(
                                  titre: "Adresse",
                                  data: widget.client.adresse ?? '---',
                                  dataColor: ThemeColors.greyDeep,
                                  nLigne: 1,
                                  paddingV: 2,
                                ),
                                detailsLigne(
                                  titre: "@-email",
                                  data: widget.client.email ?? '---',
                                  dataColor: ThemeColors.greyDeep,
                                  nLigne: 1,
                                  paddingV: 2,
                                ),
                              ],
                            ),
                          ),
                        ]),
                    /*  const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 1.0,
                              backgroundColor: ThemeColors.redOrange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Modifier",
                                  style: TextStyle(
                                      fontFamily: "Speedee",
                                      fontSize: 13,
                                      color: Colors.white),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Icon(
                                //   Icons.mode_edit_outlined,
                                //   color: ThemeColors.white,
                                // ),
                              ],
                            ),
                          )),
                    ),*/
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
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) => ConfirmeDeleteClientAlert(
              press: onPressed,
              clientName: name,
            ),
          );
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
