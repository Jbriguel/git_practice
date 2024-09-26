import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ChooseModeleIconAlert extends StatefulWidget {
  ChooseModeleIconAlert(
      {super.key, required this.onSelected, this.imageSelected});

  void Function(String imagePath) onSelected;
  String? imageSelected;

  @override
  State<ChooseModeleIconAlert> createState() => _ChooseClientIconAlertState();
}

class _ChooseClientIconAlertState extends State<ChooseModeleIconAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  List<String> images = [
    Images.mannequin,
    Images.mannequin,
    Images.mannequin,
    Images.mannequin,
    Images.mannequin,
    Images.mannequin,
  ];

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
                                    child: Text("Utiliser une icon",
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
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 10.0),
                                child: Text("Cliquer pour selectionner",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Speedee',
                                        color: Colors.black87)),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Flexible(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 120,
                                        mainAxisExtent: 100,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5),
                                itemCount: images.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  String item = images[index];
                                  return GestureDetector(
                                    onTap: () => setState(() {
                                      widget.onSelected.call(item);
                                      Navigator.pop(context);
                                    }),
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 1.0,
                                      surfaceTintColor: Colors.transparent,
                                      color: widget.imageSelected == item
                                          ? ThemeColors.redOrange
                                          : Colors.grey.shade100,
                                      shadowColor:
                                          Colors.lightBlueAccent.shade100,
                                      child: Container(
                                        width: 100,
                                        margin: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ThemeColors.white),
                                        child: CustomImageView(
                                          imagePath: item,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
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
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        surfaceTintColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor: ThemeColors.redOrange
                                            .withOpacity(0.5)),
                                    child: const Text(
                                      "Annuler",
                                      style: TextStyle(
                                          fontFamily: "Speedee",
                                          fontSize: 13,
                                          color: ThemeColors.black),
                                    ),
                                  ),
                                ),
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
