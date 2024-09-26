import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/client_helper.dart';
import 'package:atelier_so/core/functions/date_manipulation.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/repository/commandeRepository/commande_repository.dart';
import 'package:atelier_so/core/services/ContextDistributor/context_distributor.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/widgets/custom/CustomImageView.dart';
import 'package:atelier_so/widgets/custom/loading.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core/modeles/client/client.dart';
import 'components/commande_card.dart';

class CommandesOfDayScreen extends StatefulWidget {
  CommandesOfDayScreen({Key? key, this.selectedMode = false}) : super(key: key);

  bool selectedMode;

  @override
  State<CommandesOfDayScreen> createState() => _CommandesOfDayScreenState();
}

class _CommandesOfDayScreenState extends State<CommandesOfDayScreen> {
  TextEditingController rechercheController = TextEditingController();

  CommandeRepository _commandeRepository = getIt<CommandeRepository>();
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
    final List<Commande> data = await _commandeRepository.getCommandesDuJour();
    List<Client> clientsData = await _database.obtenirTousLesClients();

    setState(() {
      _commandesList = data;
      _clientsList = clientsData;
      print("All commandes: $data");
      _isLoading = false;
      rechercheController.text = "";
    });
  }

  Future<List<Commande>> _getJournals() async {
    return await _commandeRepository.getCommandesDuJour();
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

  bool deleteMode = false;
  static late DateTime dateTime = DateTime.now();
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
          title: Text(
            "${dateTime.day}-${stringMonth("${dateTime.month}")}-${dateTime.year}",
            style: TextStyle(
              color: Colors.black,
            ),
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
              Align(
                alignment: Alignment.topCenter,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: const Text(
                      "Les commandes du jour",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Speedee',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                                      imagePath: Images.calendar_2,
                                      height: 70,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      child: Text(
                                        "Aucune commande trouvée.",
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
                                    mainAxisExtent: 145 + (deleteMode ? 10 : 0),
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
              ),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 1.0,
          shape: const CircleBorder(),
          onPressed: () {
            _refreshJournals();
          },
          mini: false,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Opacity(
              opacity: 0.9,
              child: Icon(
                Icons.refresh,
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
