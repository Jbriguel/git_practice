import 'dart:io';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/modele_helper.dart';
import 'package:atelier_so/core/modeles/data_modeles/modele/modele.dart';
import 'package:atelier_so/core/modeles/message_event/message_event.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/modeles/addModele.dart';
import 'package:atelier_so/screens/modeles/components/no_correspondance_for_search.dart';
import 'package:atelier_so/screens/modeles/components/no_modeles_founds.dart';
import 'package:atelier_so/widgets/PopUps/modele_details.popUp.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'components/mod.card.dart';
import 'widgets/rechercheCard.dart';

class AllModelsPage extends StatefulWidget {
  AllModelsPage({Key? key, this.selectedMode = false}) : super(key: key);

  bool selectedMode;

  @override
  _AllModelsPageState createState() => _AllModelsPageState();
}

class _AllModelsPageState extends State<AllModelsPage>
    with TickerProviderStateMixin {
  bool deleteMode = false;
  DatabaseHelper _database = getIt<DatabaseHelper>();
  late ScrollController scrollController;
  late AnimationController animationController;
  late Animation<double> animation;

  ScrollController _controller = ScrollController();
  //--------------------------------------
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  TextEditingController rechercheController = TextEditingController();
  bool _isLoading = true;
  List<Modele> _modelsList = [];
  String _selectedRechercheBy =
      'searchByName'; // Critère de recherche sélectionné

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _animationController.forward();

    // Charger les modèles ici
    _refreshModels();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );

    tabController.addListener(
      () {
        setState(() {});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getUserCurrentLocation();
      setState(() {});
    });
  }

  void _refreshModels() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final List<Modele> data = await _database.recupererTousLesModeles();
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _modelsList = data; // Mettre à jour avec les données réelles

        _isLoading = false;
        rechercheController.text = "";
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Modele> _getFilterModeles(int index) {
    List<Modele> filterData = _modelsList
        .where((element) => (element.name ?? '')
            .toLowerCase()
            .contains(rechercheController.text.toLowerCase()))
        .toList();
    if (index == 0) {
      return filterData;
    }
    if (index == 1) {
      return filterData
          .where(
            (element) => element.genderType == 'Homme',
          )
          .toList();
    }
    if (index == 2) {
      return filterData
          .where(
            (element) => element.genderType == 'Femme',
          )
          .toList();
    }
    if (index == 3) {
      return filterData
          .where(
            (element) => element.genderType == 'Enfant',
          )
          .toList();
    }
    return [];
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }
  //----------------------------------------

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: ThemeColors.white,
          surfaceTintColor: ThemeColors.white,
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Nos ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Modèles',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            if (!deleteMode) ...[
              IconButton(
                  icon: const Icon(
                    Icons.playlist_add_circle_outlined,
                    color: ThemeColors.redOrange,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddModelePage(
                          press: () {},
                          // press: (() => getDir()),
                        ),
                      ),
                    ).then((value) {
                      if (value == true) {
                        MessageEvent(
                          Message(messageType.success, 'success',
                              "Modèle ajouté avec succès"),
                          style: eventStyle.snack,
                          canceled: true,
                        ).show();
                      }
                      _refreshModels();
                      setState(() {});
                    });
                  }),
            ],
            IconButton(
                icon: Icon(
                  deleteMode ? Icons.clear : Icons.delete,
                  color: ThemeColors.redOrange,
                ),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    deleteMode = !deleteMode;
                  });
                }),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text("Nos Différents Modèles",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
            SizedBox(
              height: 55,
              child: Row(
                children: [
                  Expanded(
                    child: RechercheBar(
                      onChanged: (String value) {
                        setState(() {
                          rechercheController.text = value;
                        });
                      },
                      onClear: () {
                        setState(() {
                          rechercheController.text = "";
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                          color: ThemeColors.redOrange.withOpacity(0.2),
                          shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.refresh,
                          color: ThemeColors.redOrange,
                        ),
                      ),
                    ),
                    color: ThemeColors.redOrange.withOpacity(0.2),
                    onPressed: () {
                      _refreshModels();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            //----------------------//
            TabBar(
              controller: tabController,
              labelColor: ThemeColors.redOrange,
              unselectedLabelColor: Colors.grey.shade600,
              dividerColor: Colors.grey.shade200,
              indicatorColor: ThemeColors.redOrange,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              tabs: const [
                Tab(text: "Tous"),
                Tab(text: "Hommes"),
                Tab(text: "Femmes"),
                Tab(text: "Enfants"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            _isLoading
                ? const Flexible(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Chargement...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Speedee',
                                color: ThemeColors.greyDeep,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : _modelsList.isEmpty
                    ? const noModelesFounds()
                    : _getFilterModeles(tabController.index).isEmpty
                        ? const NoCorrespondanceForSearch()
                        : Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(0),
                                color: Colors.transparent,
                                margin: const EdgeInsets.all(5),
                                child: GridView.builder(
                                  padding: const EdgeInsets.only(bottom: 80),
                                  controller: _controller,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 4 / 6,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 10),
                                  itemCount:
                                      _getFilterModeles(tabController.index)
                                          .length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    final Modele mod = _getFilterModeles(
                                        tabController.index)[index];

                                    return ModeleItemCard(
                                        press: () {
                                          showDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (_) => ModeleViewAlert(
                                              modele: mod,
                                              editer: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddModelePage(
                                                      editeMode: true,
                                                      modele: mod,
                                                      press: () {},
                                                      // press: (() => getDir()),
                                                    ),
                                                  ),
                                                ).then((value) {
                                                  if (value == true) {
                                                    MessageEvent(
                                                      Message(
                                                          messageType.success,
                                                          'success',
                                                          "Modèle modifier avec succès"),
                                                      style: eventStyle.snack,
                                                      canceled: true,
                                                    ).show();
                                                  }
                                                  _refreshModels();
                                                  setState(() {});
                                                });
                                              },
                                            ),
                                          ).then((value) {
                                            setState(() {});
                                          });
                                        },
                                        Lemodele: mod,
                                        onSelected: widget.selectedMode
                                            ? (Modele modele) =>
                                                Navigator.pop(context, modele)
                                            : null,
                                        showDeleteIcon: deleteMode,
                                        refresh: () {
                                          _refreshModels();
                                          setState(() {});
                                        });
                                  },
                                )))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 1.0,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddModelePage(
                  press: () {},
                  // press: (() => getDir()),
                ),
              ),
            ).then((value) {
              _refreshModels();
            });
          },
          mini: false,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Opacity(
              opacity: 0.9,
              child: Icon(
                LineAwesomeIcons.plus_circle_solid,
                color: ThemeColors.greyDeep.withOpacity(0.9),
                size: 45,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
