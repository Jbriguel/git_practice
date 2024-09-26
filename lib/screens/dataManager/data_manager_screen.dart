import 'package:atelier_so/core/repository/dbExportRepository/DbExportRepository.dart';
import 'package:atelier_so/core/repository/userRepositories/user_repository.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:atelier_so/screens/dataManager/pages/gestions/my_entreprise/my_entreprise_screen.dart';
import 'package:atelier_so/screens/dataManager/pages/synchronisations/sync_screen.dart';
import 'package:atelier_so/screens/statistiques/stats.dart';
import 'package:atelier_so/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/screens/main/main_screen.dart';
import './components/gestion_item.dart';
import 'pages/all_proprieties/all_proprieties_screen.dart';
import 'pages/pdf/ShowPdf_screen.dart';
import 'pages/restaurer_db/restauration_screen.dart';

class DataManagerScreen extends StatefulWidget {
  const DataManagerScreen({super.key});

  @override
  State<DataManagerScreen> createState() => _DataManagerScreenState();
}

class _DataManagerScreenState extends State<DataManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Gestion",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Consumer<UserRepository>(builder: (context, userRepo, child) {
          return Stack(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.init_back_3), fit: BoxFit.cover),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),

                    /*if (userRepo.user?.role == 'manager' ||
                        userRepo.user?.role == 'owner') ...[*/
                    ///////////////////////////////////////////////////
                    separator(
                      text: "Mon entreprise",
                      couleur: Colors.white,
                    ),
                    GestionItemCard(
                      onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MainScreen(), // const  MyEntrepriseScreen(),
                        ),
                      ),
                      icon: Icons.business_outlined,
                      couleur: ThemeColors.redOrange,
                      titre: 'Mon Entreprise',
                      subText: 'Gestion des informations de votre entreprise',
                    ),
                    //],
                    //-------------------------------------------------
                    const SizedBox(
                      height: 5,
                    ),
                    ///////////////////////////////////////////////////

                    separator(
                      text: "Exportation des données",
                      couleur: Colors.white,
                    ),
                    //-------------------------------------------------
                    GestionItemCard(
                      onPress: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AfficherDataInPDF(
                                genre: 'cmd',
                                document_name: "Rapport des Commandes",
                              ),
                            ),
                          )),
                      icon: Icons.picture_as_pdf_outlined,
                      couleur: ThemeColors.redOrange,
                      titre: 'Exporter les commandes',
                      subText: 'Exportation des informations des commandes',
                      // isLocked: userRepo.user?.role != 'manager' &&
                      //     userRepo.user?.role != 'owner',
                    ),
                    GestionItemCard(
                      onPress: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AfficherDataInPDF(
                                genre: 'clt',
                                document_name: "Rapport des clients",
                              ),
                            ),
                          )),
                      icon: Icons.picture_as_pdf_outlined,
                      couleur: ThemeColors.redOrange,
                      titre: 'Exporter les clients',
                      subText: 'Exportation des informations des clients',
                    ),
                    //-------------------------------------------------
                    const SizedBox(
                      height: 5,
                    ),
                    ///////////////////////////////////
                    separator(
                      text: "Gestion des proprietés",
                      couleur: Colors.white,
                    ),
                    //-------------------------------------------------
                    GestionItemCard(
                      onPress: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProprietiesScreen(),
                            ),
                          )),
                      icon: Icons.dashboard_outlined,
                      couleur: ThemeColors.redOrange,
                      titre: 'Afficher toutes les proprietés',
                      subText: 'Toutes vos proprietés',
                    ),
                    //-------------------------------------------------
                    const SizedBox(
                      height: 5,
                    ),
                    ///////////////////////////////////////////////////

                    separator(
                      text: "Gestion des bases de données",
                      couleur: Colors.white,
                    ),
                    ///////////////////////////////////////////////////

                    //-------------------------------------------------
                    GestionItemCard(
                      onPress: /*() {
                        Map<String, dynamic> backupData = {
                          'data': 'some data here',
                          'createdAt': DateTime.now().toString(),
                          'updatedAt': DateTime.now().toString(),
                          'companyId': 'company_123',
                          'backupId': 'backup_abc',
                        };

                        void setMessage(String message) {
                          print(message);
                        }

                        getIt<DbExportRepository>()
                            .uploadJsonToFirebase('Backup Info', 'application',
                                'backups', 'myBackupFile', setMessage)
                            .then((url) {
                          if (url != null) {
                            print('Fichier téléchargé avec succès : $url');
                          }
                        });
                      },*/
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SyncScreen(), // const  MyEntrepriseScreen(),
                        ),
                      ),
                      icon: Icons.storage_rounded,
                      couleur: ThemeColors.redOrange,
                      titre: 'Faire une sauvagarde des bases de données',
                      subText: 'Sauvegarde Regulière',
                    ),
                    GestionItemCard(
                      onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurationScreen(),
                        ),
                      ),
                      icon: Icons.settings_backup_restore_outlined,
                      couleur: ThemeColors.redOrange,
                      titre: 'Restaurer ses bases de données',
                      subText: 'Ne perder aucune donnée',
                    ),
                    GestionItemCard(
                      onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurationScreen(),
                        ),
                      ),
                      icon: Icons.swap_horizontal_circle_outlined,
                      couleur: ThemeColors.redOrange,
                      titre: 'Partager sa base de données',
                      subText: 'Partager d\'informations',
                    ),

                    // GestionItemCard(
                    //   onPress: (() {}),
                    //   icon: Icons.radio_button_on_outlined,
                    //   couleur: ThemeColors.redOrange,
                    //   titre: 'Exporter vos données en ligne',
                    //   subText:
                    //       'Veuillez contacter --- pour souscrire à l\'Application Web',
                    // ),
                    //-------------------------------------------------
                    const SizedBox(
                      height: 5,
                    ),
                    ///////////////////////////////////////////////////

                    // separator(
                    //   text: "Les Stats",
                    //   couleur: Colors.white,
                    // ),
                    // ///////////////////////////////////////////////////
                    // //-------------------------------------------------
                    // GestionItemCard(
                    //   onPress: (() {}),
                    //   icon: Icons.graphic_eq,
                    //   couleur: ThemeColors.redOrange,
                    //   titre: 'les Stats (semaine/mois)',
                    //   subText: 'Voir les statistiques',
                    // ),
                    // GestionItemCard(
                    //   onPress: () => Navigator.push<void>(
                    //     context,
                    //     MaterialPageRoute<void>(
                    //       builder: (BuildContext context) => StatsScreen(),
                    //     ),
                    //   ),
                    //   icon: Icons.graphic_eq,
                    //   couleur: ThemeColors.redOrange,
                    //   titre: 'les stats de l\'année',
                    //   subText: 'Voir les statistiques',
                    // ),
                    //-------------------------------------------------
                    const SizedBox(
                      height: 20,
                    ),
                    ///////////////////////////////////////////////////
                  ],
                ),
              ),
            )
          ]);
        }));
  }
}
