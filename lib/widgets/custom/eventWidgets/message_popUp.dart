import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class ShowMessagePopUp extends StatefulWidget {
  ShowMessagePopUp(
      {super.key,
      required this.message,
      required this.titre,
      required this.typeMessage,
      required this.btnText,
      required this.showBackBtn,
      required this.btnClickaction});
  String message;
  String titre;
  messageType typeMessage;
  String btnText;
  bool showBackBtn;
  void Function() btnClickaction;

  @override
  State<ShowMessagePopUp> createState() => _ShowMessagePopUpState();
}

class _ShowMessagePopUpState extends State<ShowMessagePopUp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Color getColor() {
    switch (widget.typeMessage) {
      case messageType.error:
        return Colors.red;
      case messageType.info:
        return Colors.blue;
      case messageType.warning:
        return Colors.orange;
      case messageType.success:
        return Colors.green;
      default:
        return Colors.grey.shade400;
    }
  }

  getIcon() {
    switch (widget.typeMessage) {
      case 'erreur' || 'error':
        return Icons.dangerous_outlined;
      case 'info':
        return Icons.info_outline;
      case 'alert':
        return Icons.warning_amber_rounded;
      case 'success':
        return Icons.check;
      default:
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: OrientationBuilder(builder: (context, orientation) {
              return Stack(
                children: [
                  Container(
                    width: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.95
                        : MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.only(top: 50, left: 5, right: 5),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: Text(
                            widget.titre.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Speedee',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5.0),
                          child: Text(
                            widget.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Speedee',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              if (widget.showBackBtn) ...[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.2,
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    child: Text(
                                      "Annuler".toUpperCase(),
                                      style: const TextStyle(
                                          fontFamily: "Speedee",
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    widget.btnClickaction();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.2,
                                    backgroundColor: ThemeColors.redOrange,
                                    surfaceTintColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  child: Text(
                                    widget.btnText.toUpperCase(),
                                    style: const TextStyle(
                                        fontFamily: "Speedee",
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  //---------------//
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: getColor().withOpacity(0.6)),
                          child: Icon(
                            getIcon(),
                            color: Colors.white, //getColor(),
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
