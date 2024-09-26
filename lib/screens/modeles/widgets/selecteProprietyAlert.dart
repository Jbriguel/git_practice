import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/repository/modeleRepository/propriety_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/modeles/addModele.dart';
import 'package:atelier_so/screens/modeles/widgets/rechercheCard.dart';
import 'package:atelier_so/widgets/PopUps/add_propriety.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';

class SelectProprietyAlert extends StatefulWidget {
  MyInheritedWidgetState state;
  SelectProprietyAlert({
    Key? key,
    required this.state,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => SelectProprietyAlertState();
}

class SelectProprietyAlertState extends State<SelectProprietyAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  ProprietyRepository _proprietyRepository = getIt<ProprietyRepository>();

  String nomSearched = "";

  // All Propriety
  List<Propriety> _proprieties = [];
  List<Propriety> data = [];

  void getAllPropriety() async {
    data = await _proprietyRepository.getAllProprieties();
    setState(() {
      setState(() {
        _proprieties = data;
        data = _proprieties;
      });
    });
  }

  Rechercher(String value) {
    if (nomSearched.trim().isNotEmpty) {
      setState(() {
        _proprieties = data
            .where((propriety) => propriety.name!
                .toLowerCase()
                .contains(value.toLowerCase().trim()))
            .toList();
      });
    } else {
      setState(() {
        _proprieties = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    getAllPropriety();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /* Widget actionChips(Propriety propriety) {
    return ActionChip(
      elevation: 6.0,
      padding: EdgeInsets.all(2.0), backgroundColor: Colors.white,  shape: StadiumBorder(
          side: BorderSide(
        width: 1,
        color: Colors.blueAccent,
      )),
      avatar: CircleAvatar(
        backgroundColor: Colors.green[60],
        child: Icon(Icons.call),
      ),
      label: Text("${propriety.name!}"),
      onPressed: () => widget.state.selectPropriety(propriety),
     
    
    );
  }
*/

  Widget inputChip(Propriety propriety, bool _isSelected) {
    return InputChip(
      elevation: 6.0,
      padding: EdgeInsets.all(2.0),
      avatar: Icon(
        Icons.attach_file_sharp,
        color: Colors.blue.shade600,
      ),
      backgroundColor: Colors.white,
      shape: StadiumBorder(
          side: BorderSide(
        width: 1,
        color: Colors.blueAccent,
      )),
      label: Text("${propriety.name!}"),
      selectedColor: Colors.green,
      selected: _isSelected,
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
    );
  }

  isSelected(String name) {
    if (widget.state.filters.contains(name)) return true;
    for (Propriety prop in widget.state.proprieties_selected) {
      if (prop.name! == name) {
        return true;
      }
    }
    return false;
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
    // final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
            scale: scaleAnimation,
            child: OrientationBuilder(builder: (context, orientation) {
              return SingleChildScrollView(
                child: Container(
                  width: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width * 0.75,
                  margin: const EdgeInsets.all(15.0),
                  //padding: const EdgeInsets.all(20.0),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Text("Selectionner Proprieté",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ThemeColors.greyDeep)),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                              ),
                              color: Colors.black,
                              onPressed: () {
                                widget.state.filters.clear();
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ),
                    RechercheBar(
                      onChanged: (String value) {
                        setState(() {
                          nomSearched = value;
                          Rechercher(value);
                        });
                      },
                      onClear: () {
                        setState(() {
                          nomSearched = "";
                          Rechercher("");
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: ThemeColors.greyDeep.withOpacity(0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 5.0),
                      child: _proprieties.isNotEmpty
                          ? Wrap(
                              spacing: 5,
                              children:
                                  List.generate(_proprieties.length, (index) {
                                Propriety propriety = _proprieties[index];

                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: FilterChip(
                                    elevation: 6.0,
                                    padding: const EdgeInsets.all(2.0),
                                    backgroundColor: Colors.white,
                                    shape: const StadiumBorder(
                                        side: BorderSide(
                                      width: 1,
                                      color: Colors.blueAccent,
                                    )),
                                    showCheckmark: false,
                                    avatar: CircleAvatar(
                                      child: isSelected(propriety.name!)
                                          ? Icon(
                                              Icons.check,
                                            )
                                          : Text(
                                              propriety.name![0].toUpperCase()),
                                    ),
                                    label: Text(propriety.name!),
                                    selected: isSelected(propriety.name!),
                                    selectedColor: Colors.green.shade300,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected == true) {
                                          widget.state.filters
                                              .add(propriety.name!);
                                          print(
                                              "_filters ici2 :${widget.state.filters.length}");
                                        } else {
                                          widget.state.filters
                                              .removeWhere((String name) {
                                            return name == propriety.name!;
                                          });
                                          print(
                                              "_filters ici1 :${widget.state.filters.length}");
                                        }
                                      });
                                    },
                                  ),
                                );
                              }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                      fit: BoxFit.contain,
                                      imagePath: Images.folder,
                                      height: 50,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        "Aucune Proprieté",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Speedee',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Divider(
                        color: ThemeColors.greyDeep.withOpacity(0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddNewProprietyAlert(
                                      createPropriety: () {
                                        setState(() {});
                                      },
                                    );
                                  }).then(
                                (value) {
                                  setState(() {
                                    widget.state.getProprietiesSelected();
                                    getAllPropriety();
                                  });
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 1.0,
                                surfaceTintColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Colors.white),
                            child: const Text(
                              "Créer Proprieté",
                              style: TextStyle(
                                  fontFamily: "Speedee",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            List<Propriety> mutableProprietiesSelected =
                                widget.state.proprieties_selected.toList();

                            print('yes selected');
                            //widget.state.proprieties_selected = [];
                            widget.state.filters.forEach((name) {
                              // Vérifier si la propriété existe déjà dans proprieties_selected

                              final exist = mutableProprietiesSelected
                                  .any((prop) => prop.name == name);

                              // Si elle n'existe pas, rechercher et ajouter la propriété manquante
                              if (!exist) {
                                final proprietyManquante = _proprieties
                                    .firstWhere((prop) => prop.name == name);

                                if (proprietyManquante != null) {
                                  setState(() {
                                    mutableProprietiesSelected.add(
                                      Propriety((p) => p
                                        ..uid = proprietyManquante.uid
                                        ..name = proprietyManquante.name
                                        ..value = proprietyManquante.value),
                                    );

                                    // widget.state.proprieties_selected.add(
                                    //   Propriety((p) => p
                                    //         ..uid = proprietyManquante
                                    //             .uid // Utiliser l'UID existant
                                    //         ..name = proprietyManquante
                                    //             .name // Utiliser le nom existant
                                    //         ..value = proprietyManquante
                                    //             .value // Utiliser la valeur existante
                                    //       ),
                                    // );
                                  });
                                }
                              }
                            });

                            /*widget.state.filters.forEach((name) {
                              bool exist = false; 
                              widget.state.proprieties_selected.forEach((prop) {
                                if (prop.name! == name) {
                                  setState(() {
                                    exist = true; 
                                    // propriety.rebuild((b) => b..proprieties.replace(proprieties));
                                    //propriety.rebuild(updates) prop.toJson();
                                  });
                                }
                              });
                              if (exist == false) {
                                setState(() {
                                  widget.state.proprieties_selected
                                      .add(Propriety((p) => p
                                        ..uid = prop?.uid
                                        ..name = name
                                        ..value = ""));
                                });
                              }
                            });*/
                            setState(() {
                              widget.state.proprieties_selected =
                                  mutableProprietiesSelected;
                            });
                            setState(() {
                              widget.state.getProprietiesSelected();
                              widget.state.filters = [];
                            });

                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: ThemeColors.redOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            "Ajouter",
                            style: TextStyle(
                                fontFamily: "Speedee",
                                fontSize: 13,
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
    );
  }
}




/*

 Widget _buildFirendsList() {
    final futureFriends = getIt<UserProvider>()
        .getMyFirends(refresh: false); // Utilisation d'un futur stable

    return FutureBuilder<List<UserModel>>(
      future: futureFriends,
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                'Votre liste d\'amis est vide pour le moment. Invitez des amis et ensemble et profiter des bonus exclusifs !',
                textAlign: TextAlign.center,
                style: TextStyle(color: Themecolors.Color3),
              ),
            ),
          );
        }

        List<UserModel> dataList = snapshot.data!;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              UserModel friend = dataList[index];
              return AmiItemCard(friend: friend);
            },
          ),
        );
      },
    );
  }*/