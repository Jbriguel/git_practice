import 'package:atelier_so/core/modeles/data_modeles/propriety/propriety.dart';
import 'package:atelier_so/core/repository/modeleRepository/propriety_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/dataManager/pages/all_proprieties/components/no_propertiy_found.dart';
import 'package:flutter/material.dart';

import '../../../modeles/widgets/rechercheCard.dart';

class AllProprietiesScreen extends StatefulWidget {
  const AllProprietiesScreen({super.key});

  @override
  State<AllProprietiesScreen> createState() => _AllProprietiesScreenState();
}

class _AllProprietiesScreenState extends State<AllProprietiesScreen>
    with TickerProviderStateMixin {
  bool deleteMode = false;
  late ScrollController scrollController;
  late AnimationController animationController;
  late Animation<double> animation;

  ProprietyRepository _proprietyRepository = getIt<ProprietyRepository>();

  ScrollController _controller = ScrollController();
  //--------------------------------------

  TextEditingController rechercheController = TextEditingController();
  bool _isLoading = true;
  List<Propriety> _proprietiesList = [];
  String _selectedRechercheBy =
      'searchByName'; // Critère de recherche sélectionné

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animationController.forward();

    // Charger les modèles ici
    _refreshModels();

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
      final List<Propriety> data =
          await _proprietyRepository.getAllProprieties();
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _proprietiesList = data; // Mettre à jour avec les données réelles
        _isLoading = false;
        rechercheController.text = "";
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Proprietés',
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
                  onPressed: () {}),
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
                  child: Text("Nos Différentes Proprietés",
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
                  : _proprietiesList.isEmpty
                      ? const NoProprietyFound()
                      : Flexible(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10.0,
                            children: _proprietiesList
                                .map(
                                  (propriety) => ChoiceChip(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            color: Colors.grey.shade200)),
                                    pressElevation: 0.5,
                                    selectedColor: ThemeColors.redOrange,
                                    backgroundColor: Colors.grey.shade50,
                                    label: Text(
                                      propriety.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    selected: false,
                                    onSelected: (bool selected) {},
                                  ),
                                )
                                .toList(),
                          ),
                        ),
            ]));
  }
}
