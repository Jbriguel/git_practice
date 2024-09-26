import 'package:atelier_so/components/ligne_details.dart';
import 'package:atelier_so/core/modeles/user/user.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/PopUps/confirm_delete_client.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final UserInterface user;
  final bool showDeleteBtn;
  final Function(String? id)? onDelete;
  final void Function()? onSelected;

  CustomCard({
    super.key,
    required this.user,
    this.showDeleteBtn = false,
    this.onDelete,
    this.onSelected,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
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
      onTap: widget.onSelected,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.lightBlueAccent.withOpacity(0.2),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade50, width: 1.2),
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
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(1),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ThemeColors.greyDisable,
                                ThemeColors.greyDisable.withOpacity(0.1),
                              ],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ThemeColors.redOrange,
                              width: 1.0,
                            ),
                          ),
                          child: CustomImageView(
                            imagePath: Images.afro_man_avatar,
                            placeHolder: Images.contact,
                            fit: BoxFit.contain,
                            radius: BorderRadius.circular(40),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(
                                            widget.user.name,
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            textDirection: TextDirection.ltr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: ThemeColors.black,
                                              fontFamily: "Speedee",
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (widget.showDeleteBtn) ...[
                                        DeleteIconButton(
                                          name: widget.user.name,
                                          onPressed: () {
                                            if (widget.onDelete != null) {
                                              widget.onDelete!(widget.user.uid);
                                            }
                                          },
                                        ),
                                      ],
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
                                ],
                              ),
                              const SizedBox(height: 2),
                              detailsLigne(
                                titre: "Tel",
                                data: widget.user.phone ?? '---',
                                dataColor: ThemeColors.greyDeep,
                                nLigne: 1,
                                paddingV: 2,
                              ),
                              detailsLigne(
                                titre: "Adresse",
                                data: widget.user.adresse ?? '---',
                                dataColor: ThemeColors.greyDeep,
                                nLigne: 1,
                                paddingV: 2,
                              ),
                              detailsLigne(
                                titre: "@-email",
                                data: widget.user.email ?? '---',
                                dataColor: ThemeColors.greyDeep,
                                nLigne: 1,
                                paddingV: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class DeleteIconButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  DeleteIconButton({super.key, required this.name, required this.onPressed});

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
      ),
    );
  }
}
