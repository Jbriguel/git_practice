import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/client_helper.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/repository/clientRepository/client_repository.dart';
import 'package:atelier_so/core/repository/commandeRepository/commande_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/commande/add_commande_screen.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'components/commande_card.dart';

class AllCommandesScreen extends StatefulWidget {
  const AllCommandesScreen({super.key});

  @override
  State<AllCommandesScreen> createState() => _AllCommandesScreenState();
}

class _AllCommandesScreenState extends State<AllCommandesScreen> {
  TextEditingController rechercheController = TextEditingController();

  CommandeRepository _commandeRepository = getIt<CommandeRepository>();
  ClientRepository _clientRepository = getIt<ClientRepository>();

  DatabaseHelper _database = getIt<DatabaseHelper>();
  ScrollController _controller = ScrollController();

  // All journals
  List<Commande> _commandesList = [];
  List<Client> _clientsList = [];

  bool _isLoading = true;

  DateTime? dateTime1;
  DateTime? dateTime2;
  // This function is used to fetch all data from the database

  void deleteCommande(String commandeUid) async {
    LoadingDialog.show(context);
    //----------------------------------------------------------------
    await _commandeRepository.deleteCommande(commandeUid).then((value) {
      if (value == true) {
        _refreshJournals();
        setState(() {});
      }
    }).whenComplete(() => LoadingDialog.hide(context));
    setState(() {});
    //--------------------------------------------
  }

  void _refreshJournals() async {
    setState(() {
      _isLoading = true;
    });
    final List<Commande> data =
        await _commandeRepository.getCommandesWithHabitsAndProprieties();
    List<Client> clientsData = await _database.obtenirTousLesClients();
    setState(() {
      _commandesList = data;
      _clientsList = clientsData;
      print("All commandes length: ${_commandesList.length}");
      print("All commandes: $data");
      _isLoading = false;
      rechercheController.text = "";
    });
  }

  void _rechercherClients(String mot) async {
    if (mot.trim().isNotEmpty) {
      setState(() {
        _commandesList = _commandesList
            .where((cmd) => (cmd.details ?? '')
                .toLowerCase()
                .contains(mot.toLowerCase().trim()))
            .toList();
      });
    } else {
      _refreshJournals();
    }
  }

  Future<List<Commande>> _getJournals() async {
    return await _commandeRepository.getCommandesWithHabitsAndProprieties();
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    // Loading the diary when the app starts
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mettre à jour le contexte ici
    getIt<ContextDistributor>().setContext(context);
  }

  String _selectedRechercheBy = 'searchByName';

  // ignore: non_constant_identifier_names
  _Rechecher() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      color: Colors.white.withOpacity(0.8),
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            PopupMenuButton(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              onSelected: (value) =>
                  setState(() => _selectedRechercheBy = value),
              itemBuilder: (_) => [
                CheckedPopupMenuItem(
                  checked: _selectedRechercheBy == 'searchByName',
                  value: 'searchByName',
                  child: const Text('Rechercher par nom'),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _rechercherClients(value);
                  });
                },
                controller: rechercheController,
                //decoration: InputDecoration.collapsed(
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText:
                      "recherche par ${_selectedRechercheBy == 'searchByName' ? 'nom' : _selectedRechercheBy == 'searchByAdresse' ? 'adresse' : 'telephone'} ...",
                  focusColor: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              iconSize: 20.0,
              color: ThemeColors.redOrange,
              onPressed: () {
                setState(
                  () {
                    rechercheController.text = "";
                    _rechercherClients("");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bool deleteMode = false;

  @override
  Widget build(BuildContext context) {
    final screen_size_width = MediaQuery.of(context).size.width;
    final screen_size_height = MediaQuery.of(context).size.height;
    // Calculer la largeur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    // Définir une largeur fixe pour chaque carte
    final cardWidth = 300.0;
    // Calculer le nombre de colonnes basé sur la largeur de l'écran
    final crossAxisCount = (screenWidth / cardWidth).floor();

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Les Commandes",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  deleteMode = !deleteMode;
                });
              },
              icon: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColors.greyDeep.withOpacity(0.2)),
                padding: const EdgeInsets.all(5),
                child: deleteMode
                    ? Icon(
                        Icons.clear_rounded,
                        color: ThemeColors.greyDeep.withOpacity(0.8),
                      )
                    : Icon(
                        Icons.delete,
                        color: ThemeColors.greyDeep.withOpacity(0.8),
                      ),
              ),
            )
          ],
        ),
        body: Container(
          width: screen_size_width,
          height: screen_size_height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.init_back_3), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Stack(children: <Widget>[
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),  
                ),
              ),
              Column(children: [
                Container(
                  height: 55,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: _Rechecher(),
                      ),
                      IconButton(
                          icon: Container(
                            decoration: BoxDecoration(
                                color: ThemeColors.redOrange.withOpacity(0.4),
                                shape: BoxShape.circle),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.refresh,
                                color: ThemeColors.white,
                              ),
                            ),
                          ),
                          color: ThemeColors.redOrange.withOpacity(0.4),
                          onPressed: () => _rechercherClients("")),
                    ],
                  ),
                ),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _commandesList.isEmpty
                        ? Flexible(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    fit: BoxFit.contain,
                                    imagePath: Images.folder,
                                    height: 50,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    child: Text(
                                      "Aucune commande trouvée",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Speedee',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ]),
                          )
                        : Flexible(
                            child: GridView.builder(
                                controller: _controller,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  mainAxisExtent: 160 + (deleteMode ? 10 : 0),
                                  // childAspectRatio:
                                  //     cardWidth / 100, // Ratio largeur/hauteur
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: _commandesList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  Commande commande = _commandesList[index];
                                  Client client = _clientsList
                                      .where((element) =>
                                          element.uid == commande.clientUid)
                                      .toList()[0];
                                  return CommandeCard(
                                    commande: commande,
                                    client: client,
                                    showDeleteBtn: deleteMode,
                                    onSelected: null,
                                    onDelete: null,
                                  );
                                }),
                          ),
              ]),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 1.0,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddCommandePage(),
              ),
            ).then((value) {
              if (value == true) {
                setState(() {});
              }
              _refreshJournals();
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
